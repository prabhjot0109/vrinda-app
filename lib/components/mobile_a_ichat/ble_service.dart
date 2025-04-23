import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:geolocator/geolocator.dart';

class BLEService {
  // Constants from ESP32
  static const String DEVICE_NAME = "Vrinda Netra";
  static const String SERVICE_UUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  static const String NPK_CHAR_UUID = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
  static const String EC_CHAR_UUID = "beb5483e-36e1-4688-b7f5-ea07361b26a9";
  static const String MOISTURE_CHAR_UUID =
      "beb5483e-36e1-4688-b7f5-ea07361b26aa";

  // Stream controller for sensor data
  final _sensorDataStreamController = StreamController<String>.broadcast();
  Stream<String> get sensorData => _sensorDataStreamController.stream;

  // Properties
  BluetoothDevice? _connectedDevice;
  BluetoothCharacteristic? _npkCharacteristic;
  BluetoothCharacteristic? _ecCharacteristic;
  BluetoothCharacteristic? _moistureCharacteristic;
  bool _isScanning = false;
  bool _isConnected = false;
  bool _isFirstReading = true;

  // Parsed sensor data
  String _nitrogenData = "N/A";
  String _phosphorusData = "N/A";
  String _potassiumData = "N/A";
  String _ecData = "N/A";
  String _moistureData = "N/A";

  // Singleton instance
  static final BLEService _instance = BLEService._internal();
  factory BLEService() => _instance;
  BLEService._internal();

  // Check if location services are enabled
  Future<bool> _checkLocationPermission() async {
    print("BLE: Checking location permission...");
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      print("BLE: Location services are disabled");
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Location permissions are denied
        print("BLE: Location permissions denied");
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Location permissions are permanently denied
      print("BLE: Location permissions permanently denied");
      return false;
    }

    print("BLE: Location permission granted");
    return true;
  }

  // Start scanning and connect to ESP32
  Future<void> startScan() async {
    if (_isScanning) {
      print("BLE: Already scanning, ignoring request");
      return;
    }

    _isScanning = true;
    _isFirstReading = true;

    print("BLE: Starting scan for devices...");

    // Reset sensor data
    _nitrogenData = "N/A";
    _phosphorusData = "N/A";
    _potassiumData = "N/A";
    _ecData = "N/A";
    _moistureData = "N/A";

    // Check if Bluetooth is supported and on
    if (await FlutterBluePlus.isSupported == false) {
      print("BLE: Bluetooth not supported on this device");
      _sensorDataStreamController.add("Bluetooth not supported");
      _isScanning = false;
      throw PlatformException(
        code: 'bluetoothNotSupported',
        message: 'Bluetooth is not supported on this device',
      );
    }

    // Check Bluetooth state
    var btState = await FlutterBluePlus.adapterState.first;
    if (btState != BluetoothAdapterState.on) {
      print("BLE: Bluetooth is not enabled (state: $btState)");
      _sensorDataStreamController.add("Bluetooth is not enabled");
      _isScanning = false;
      throw PlatformException(
        code: 'bluetoothNotEnabled',
        message: 'Bluetooth is not enabled',
      );
    }

    // Check location permission
    bool hasLocationPermission = await _checkLocationPermission();
    if (!hasLocationPermission) {
      print("BLE: Location services required for Bluetooth scan");
      _sensorDataStreamController.add("Location services required");
      _isScanning = false;

      throw PlatformException(
        code: 'startScan',
        message: 'Location services are required for Bluetooth scan',
      );
    }

    // Start scanning
    _sensorDataStreamController.add("Connecting to sensor...");

    try {
      // Add listener for scan results
      var subscription = FlutterBluePlus.scanResults.listen((results) {
        print("BLE: Found ${results.length} devices");

        // Debug: Print all found devices to help identify your sensor
        for (ScanResult result in results) {
          print(
              "BLE: Device found: ${result.device.platformName} (${result.device.id})");

          // Check for device name OR if the device name is empty, check the device ID
          // This is more flexible and will help find your device even if the name is different
          if (result.device.platformName == DEVICE_NAME ||
              (result.device.platformName.isEmpty &&
                  _isVrindaDeviceByID(result.device.id.toString()))) {
            print(
                "BLE: Found target device: ${result.device.platformName} (${result.device.id})");
            _connectToDevice(result.device);
            FlutterBluePlus.stopScan();
            break;
          }
        }
      }, onError: (e) {
        print("BLE: Error during scan: $e");
        _sensorDataStreamController.add("Error during scan: $e");
      });

      // Start scanning
      print("BLE: Starting scan with 15 second timeout");
      await FlutterBluePlus.startScan(timeout: Duration(seconds: 15));
      print("BLE: Scan completed");

      // Clean up subscription
      subscription.cancel();
    } catch (e) {
      print("BLE: Error starting scan: $e");
      _sensorDataStreamController.add("Error starting scan: $e");
      throw e;
    } finally {
      _isScanning = false;
    }

    // If no devices found after scan
    if (_connectedDevice == null) {
      print("BLE: No devices found after scan");
      _sensorDataStreamController.add("No sensor devices found. Try again.");
    }
  }

  // Helper method to check if a device ID might be our Vrinda device
  // You may need to adjust this based on your actual device ID pattern
  bool _isVrindaDeviceByID(String deviceID) {
    // Add any known patterns of your device ID here
    // For example, if your device ID has a specific prefix or structure
    // This is just an example - update with your actual device identifier pattern
    return deviceID.contains("4F:AF:C2") || // Service UUID prefix
        deviceID.contains("BE:B5:48"); // Characteristic UUID prefix
  }

  // Connect to ESP32 device
  Future<void> _connectToDevice(BluetoothDevice device) async {
    if (_isConnected) return;

    try {
      print("BLE: Connecting to device ${device.platformName}");
      await device.connect();
      _connectedDevice = device;
      _isConnected = true;
      print("BLE: Connected successfully");
      _sensorDataStreamController
          .add("Connected to sensor. Discovering services...");

      // Discover services
      print("BLE: Discovering services...");
      List<BluetoothService> services = await device.discoverServices();
      print("BLE: Found ${services.length} services");

      bool foundSoilSensorService = false;

      // Find the soil sensor service
      for (BluetoothService service in services) {
        print("BLE: Service UUID: ${service.uuid.toString()}");

        if (service.uuid.toString() == SERVICE_UUID) {
          print("BLE: Found soil sensor service!");
          foundSoilSensorService = true;

          // Find all the characteristics
          print("BLE: Looking for characteristics...");
          for (BluetoothCharacteristic characteristic
              in service.characteristics) {
            String charUuid = characteristic.uuid.toString();
            print("BLE: Found characteristic: $charUuid");

            if (charUuid == NPK_CHAR_UUID) {
              print("BLE: Found NPK characteristic");
              _npkCharacteristic = characteristic;
              await characteristic.setNotifyValue(true);
              print("BLE: NPK notifications enabled");

              characteristic.lastValueStream.listen((value) {
                if (value.isNotEmpty) {
                  String npkData = String.fromCharCodes(value);
                  print("BLE: Received NPK data: $npkData");
                  _parseNPKData(npkData);
                  _sendFormattedReading();
                }
              });
            } else if (charUuid == EC_CHAR_UUID) {
              print("BLE: Found EC characteristic");
              _ecCharacteristic = characteristic;
              await characteristic.setNotifyValue(true);
              print("BLE: EC notifications enabled");

              characteristic.lastValueStream.listen((value) {
                if (value.isNotEmpty) {
                  String ecData = String.fromCharCodes(value);
                  print("BLE: Received EC data: $ecData");
                  _ecData = ecData;
                  _sendFormattedReading();
                }
              });
            } else if (charUuid == MOISTURE_CHAR_UUID) {
              print("BLE: Found Moisture characteristic");
              _moistureCharacteristic = characteristic;
              await characteristic.setNotifyValue(true);
              print("BLE: Moisture notifications enabled");

              characteristic.lastValueStream.listen((value) {
                if (value.isNotEmpty) {
                  String moistureData = String.fromCharCodes(value);
                  print("BLE: Received Moisture data: $moistureData");
                  _moistureData = moistureData;
                  _sendFormattedReading();
                }
              });
            }
          }
          break;
        }
      }

      if (!foundSoilSensorService) {
        print("BLE: Soil sensor service not found!");
        _sensorDataStreamController.add("Connected but service not found");
      }

      // If connected but not found any characteristics
      if (_npkCharacteristic == null &&
          _ecCharacteristic == null &&
          _moistureCharacteristic == null) {
        print("BLE: Connected but no characteristics found");
        _sensorDataStreamController
            .add("Connected but sensor characteristics not found");
      } else {
        print("BLE: Successfully set up all notifications");
      }
    } catch (e) {
      print("BLE: Error connecting: $e");
      _sensorDataStreamController.add("Error connecting: $e");
      _isConnected = false;
    }
  }

  // Parse NPK data from "N:XX P:XX K:XX mg/kg" format
  void _parseNPKData(String npkData) {
    print("BLE: Parsing NPK data: $npkData");
    try {
      // Extract N, P, K values using regex
      RegExp nRegex = RegExp(r'N:(\d+)');
      RegExp pRegex = RegExp(r'P:(\d+)');
      RegExp kRegex = RegExp(r'K:(\d+)');

      Match? nMatch = nRegex.firstMatch(npkData);
      Match? pMatch = pRegex.firstMatch(npkData);
      Match? kMatch = kRegex.firstMatch(npkData);

      if (nMatch != null) {
        _nitrogenData = "${nMatch.group(1)} mg/kg";
        print("BLE: Parsed Nitrogen: $_nitrogenData");
      } else {
        print("BLE: Failed to parse Nitrogen from: $npkData");
      }

      if (pMatch != null) {
        _phosphorusData = "${pMatch.group(1)} mg/kg";
        print("BLE: Parsed Phosphorus: $_phosphorusData");
      } else {
        print("BLE: Failed to parse Phosphorus from: $npkData");
      }

      if (kMatch != null) {
        _potassiumData = "${kMatch.group(1)} mg/kg";
        print("BLE: Parsed Potassium: $_potassiumData");
      } else {
        print("BLE: Failed to parse Potassium from: $npkData");
      }
    } catch (e) {
      print("BLE: Error parsing NPK data: $e");
    }
  }

  // Send formatted reading to the stream
  void _sendFormattedReading() {
    print("BLE: Sending formatted reading to UI");

    // For the first reading, send a special message to indicate connection success
    // This will be used to trigger the transition from "Connecting..." to "Sensor Data"
    if (_isFirstReading) {
      _sensorDataStreamController.add("CONNECTION_SUCCESS");
      _isFirstReading = false;

      // Wait a short moment before sending the actual data
      Future.delayed(Duration(milliseconds: 500), () {
        // Format the message with all sensor data in a detailed layout
        String formattedMessage = "Soil Sensor Connected\n\n"
            "Nitrogen (N): $_nitrogenData\n"
            "Phosphorus (P): $_phosphorusData\n"
            "Potassium (K): $_potassiumData\n\n"
            "Electrical Conductivity: $_ecData\n"
            "Soil Moisture: $_moistureData";

        print("BLE: Formatted message: $formattedMessage");
        _sensorDataStreamController.add(formattedMessage);
      });
    } else {
      // For subsequent readings, just send the formatted data directly
      String formattedMessage = "Soil Sensor Connected\n\n"
          "Nitrogen (N): $_nitrogenData\n"
          "Phosphorus (P): $_phosphorusData\n"
          "Potassium (K): $_potassiumData\n\n"
          "Electrical Conductivity: $_ecData\n"
          "Soil Moisture: $_moistureData";

      print("BLE: Formatted message: $formattedMessage");
      _sensorDataStreamController.add(formattedMessage);
    }
  }

  // Disconnect from device
  Future<void> disconnect() async {
    if (_connectedDevice != null) {
      try {
        print("BLE: Disconnecting from device");
        await _connectedDevice!.disconnect();
        _isConnected = false;
        _sensorDataStreamController.add("Sensor disconnected.");
        _connectedDevice = null;
        _npkCharacteristic = null;
        _ecCharacteristic = null;
        _moistureCharacteristic = null;

        // Reset sensor data
        _nitrogenData = "N/A";
        _phosphorusData = "N/A";
        _potassiumData = "N/A";
        _ecData = "N/A";
        _moistureData = "N/A";
        print("BLE: Disconnect completed");
      } catch (e) {
        print("BLE: Error disconnecting: $e");
        _sensorDataStreamController.add("Error disconnecting: $e");
      }
    }
  }

  // Dispose resources
  void dispose() {
    disconnect();
    _sensorDataStreamController.close();
  }
}
