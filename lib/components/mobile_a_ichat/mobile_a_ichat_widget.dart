import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/components/ai_bottom_sheet/ai_bottom_sheet_widget.dart';
import '/components/sensor_data/sensor_data_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'dart:async';
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'mobile_a_ichat_model.dart';
export 'mobile_a_ichat_model.dart';
import 'ble_service.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

class MobileAIchatWidget extends StatefulWidget {
  const MobileAIchatWidget({super.key});

  @override
  State<MobileAIchatWidget> createState() => _MobileAIchatWidgetState();
}

class _MobileAIchatWidgetState extends State<MobileAIchatWidget>
    with RouteAware {
  late MobileAIchatModel _model;

  // BLE service and subscription
  final BLEService _bleService = BLEService();
  StreamSubscription? _sensorDataSubscription;
  bool _isSensorRichTextVisible = false;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MobileAIchatModel());

    _model.textController ??= TextEditingController()
      ..addListener(() {
        // Check if the text field content changed and sensor tag was deleted
        if (_isSensorRichTextVisible &&
            (_model.textController!.text.isEmpty ||
                !_model.textController!.text.contains("📊 Sensor Data"))) {
          setState(() {
            _isSensorRichTextVisible = false;
          });
        }
        debugLogWidgetClass(_model);
      });
    _model.textFieldFocusNode ??= FocusNode();

    // Initialize BLE sensor data subscription
    _sensorDataSubscription = _bleService.sensorData.listen((data) {
      // Track if the message is a connection-related message
      bool isConnectionMessage = data == "CONNECTION_SUCCESS" ||
          data.contains("Connecting to sensor") ||
          data.contains("Connected to sensor");

      if (FFAppState().sensorDataFetch) {
        // Handle the special "CONNECTION_SUCCESS" message
        if (data == "CONNECTION_SUCCESS") {
          if (mounted) {
            setState(() {
              // Just remove the "Connecting to sensor..." message first without adding Sensor Data tag yet
              if (_model.textController != null) {
                String currentText = _model.textController!.text;
                _model.textController!.text = currentText
                    .replaceAll("Connecting to sensor...", "")
                    .trim();
              }
            });
          }
          return; // Don't process this special message further
        }

        // Don't extract data from connection status messages
        if (!isConnectionMessage) {
          // Extract and store sensor values in app state when actual data arrives
          _extractAndStoreSensorValues(data);

          // Show visually distinct sensor data text in the text field
          if (mounted) {
            setState(() {
              if (_model.textController != null) {
                // Check if we need to add the tag - only add if not already there
                bool shouldAddTag =
                    !_model.textController!.text.contains("📊 Sensor Data");

                if (shouldAddTag) {
                  // Replace any "Connecting to sensor..." text first
                  String currentText = _model.textController!.text
                      .replaceAll("Connecting to sensor...", "")
                      .trim();

                  // Add space if needed
                  if (currentText.isNotEmpty && !currentText.endsWith(" ")) {
                    currentText += " ";
                  }

                  // Add the sensor data tag
                  _model.textController!.text = currentText + "📊 Sensor Data";
                  _isSensorRichTextVisible = true;
                }
              }
            });
          }
        }
      }
    });

    // Restore sensor tag if we have sensor data in app state
    if (FFAppState().Nvalue.isNotEmpty ||
        FFAppState().Pvalue.isNotEmpty ||
        FFAppState().Kvalue.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 500), () {
        if (mounted && _model.textController != null) {
          setState(() {
            if (!_model.textController!.text.contains("📊 Sensor Data")) {
              String currentText = _model.textController!.text;
              if (currentText.isNotEmpty && !currentText.endsWith(" ")) {
                currentText += " ";
              }
              _model.textController!.text = currentText + "📊 Sensor Data";
              _isSensorRichTextVisible = true;
            }
          });
        }
      });
    }
  }

  // Extract and store sensor values from the received data string
  void _extractAndStoreSensorValues(String sensorData) {
    try {
      print("Extracting sensor values from: $sensorData");

      // Extract N value
      RegExp nRegex = RegExp(r'Nitrogen \(N\): (\d+) mg\/kg');
      Match? nMatch = nRegex.firstMatch(sensorData);
      if (nMatch != null && nMatch.group(1) != null) {
        String nValue = nMatch.group(1)!;
        print("Extracted N value: $nValue");
        FFAppState().Nvalue = nValue;
      }

      // Extract P value
      RegExp pRegex = RegExp(r'Phosphorus \(P\): (\d+) mg\/kg');
      Match? pMatch = pRegex.firstMatch(sensorData);
      if (pMatch != null && pMatch.group(1) != null) {
        String pValue = pMatch.group(1)!;
        print("Extracted P value: $pValue");
        FFAppState().Pvalue = pValue;
      }

      // Extract K value
      RegExp kRegex = RegExp(r'Potassium \(K\): (\d+) mg\/kg');
      Match? kMatch = kRegex.firstMatch(sensorData);
      if (kMatch != null && kMatch.group(1) != null) {
        String kValue = kMatch.group(1)!;
        print("Extracted K value: $kValue");
        FFAppState().Kvalue = kValue;
      }

      // Extract EC value
      RegExp ecRegex = RegExp(r'Electrical Conductivity: ([\d.]+)');
      Match? ecMatch = ecRegex.firstMatch(sensorData);
      if (ecMatch != null && ecMatch.group(1) != null) {
        String ecValue = ecMatch.group(1)!;
        print("Extracted EC value: $ecValue");
        FFAppState().ECvalue = ecValue;
      }

      // Extract Moisture value
      RegExp moistureRegex = RegExp(r'Soil Moisture: ([\d.]+)%?');
      Match? moistureMatch = moistureRegex.firstMatch(sensorData);
      if (moistureMatch != null && moistureMatch.group(1) != null) {
        String moistureValue = moistureMatch.group(1)!;
        print("Extracted Moisture value: $moistureValue");
        FFAppState().moisturevalue =
            moistureValue; // Note: using correct variable name 'moisturevalue'
      }

      // Sensor values successfully stored in app state
      print("Sensor values stored in AppState successfully");
    } catch (e) {
      print("Error extracting sensor values: $e");
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    _model.dispose();

    _sensorDataSubscription?.cancel(); // Cancel subscription
    _bleService.disconnect(); // Disconnect from BLE device

    super.dispose();
  }

  // Handle sensor toggle button press
  void _handleSensorToggle() async {
    bool previousState = FFAppState().sensorDataFetch;
    bool newState = !previousState;

    safeSetState(() => FFAppState().sensorDataFetch = newState);

    if (newState) {
      // When toggled ON, start scanning for BLE device
      print("Sensor toggle turned ON, starting scan...");

      // Use the main text controller to show connecting message
      setState(() {
        if (_model.textController != null) {
          // Clear any existing "📊 Sensor Data" tag first
          String currentText = _model.textController!.text;
          currentText = currentText.replaceAll("📊 Sensor Data", "").trim();

          // Add connecting message
          if (currentText.isNotEmpty) {
            if (!currentText.endsWith(" ")) {
              currentText += " ";
            }
            _model.textController!.text =
                currentText + "Connecting to sensor...";
          } else {
            _model.textController!.text = "Connecting to sensor...";
          }
          _isSensorRichTextVisible = true;
        }
      });

      try {
        // Check if we have any sensor values already before trying to scan
        print(
            "Checking existing sensor values - N: ${FFAppState().Nvalue}, P: ${FFAppState().Pvalue}, K: ${FFAppState().Kvalue}");
        print(
            "Existing moisture: ${FFAppState().moisturevalue}, EC: ${FFAppState().ECvalue}");

        // Start scanning for BLE device
        print("Starting BLE scan now...");
        await _bleService.startScan();
        print("BLE scan started successfully");
      } catch (e) {
        print("ERROR starting BLE scan: $e");

        // Update UI to show error
        setState(() {
          String currentText = _model.textController!.text;
          if (currentText.contains("Connecting to sensor")) {
            _model.textController!.text = currentText.replaceAll(
                "Connecting to sensor...", "⚠️ Location services required");
          }
        });

        // Show error dialog
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Location Services Required"),
              content: Text(
                "Location services are required for Bluetooth scanning. Please enable location services in your device settings.",
                style: FlutterFlowTheme.of(context).bodyMedium,
              ),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );

        // Turn off sensor toggle after error
        safeSetState(() => FFAppState().sensorDataFetch = false);
        return;
      }

      // After a short delay, update text to show the tag or error message
      await Future.delayed(Duration(seconds: 2));
      if (FFAppState().sensorDataFetch && mounted) {
        // Print current sensor values to check if they've been updated
        print(
            "After scan - N: ${FFAppState().Nvalue}, P: ${FFAppState().Pvalue}, K: ${FFAppState().Kvalue}");
        print(
            "After scan - moisture: ${FFAppState().moisturevalue}, EC: ${FFAppState().ECvalue}");

        // Check if we got any real data
        bool hasRealData = FFAppState().Nvalue.isNotEmpty ||
            FFAppState().Pvalue.isNotEmpty ||
            FFAppState().Kvalue.isNotEmpty ||
            FFAppState().moisturevalue.isNotEmpty ||
            FFAppState().ECvalue.isNotEmpty;

        // Only update if still toggled on
        setState(() {
          String currentText = _model.textController!.text;
          if (currentText.contains("Connecting to sensor")) {
            if (hasRealData) {
              // Replace connecting message with sensor data tag
              _model.textController!.text = currentText.replaceAll(
                  "Connecting to sensor...", "📊 Sensor Data");
            } else {
              // Show error message if no data found
              _model.textController!.text = currentText.replaceAll(
                  "Connecting to sensor...", "❌ No sensor found");

              // Auto-turn off the toggle after a moment
              Future.delayed(Duration(seconds: 1), () {
                if (mounted) {
                  safeSetState(() => FFAppState().sensorDataFetch = false);
                }
              });
            }
          } else if (!currentText.contains("📊 Sensor Data") && hasRealData) {
            // Add sensor data tag if not already there and we have data
            if (currentText.isNotEmpty && !currentText.endsWith(" ")) {
              currentText += " ";
            }
            _model.textController!.text = currentText + "📊 Sensor Data";
          }
        });
      }
    } else {
      // When toggled OFF, disconnect but preserve the data and sensor tag
      print("Sensor toggle turned OFF, disconnecting...");
      await _bleService.disconnect();
      print("BLE service disconnected");

      // Update the text field to show disconnected but keep the sensor data tag
      if (_model.textController!.text.contains("📊 Sensor Data")) {
        // We keep the sensor data tag since the data is still in app state
        // No visual change needed - the user can continue to reference the data
        print("Kept sensor data tag in text field");
      } else if (_model.textController!.text.contains("Connecting to sensor")) {
        // Replace connecting message with nothing
        setState(() {
          _model.textController!.text = _model.textController!.text
              .replaceAll("Connecting to sensor...", "")
              .trim();
          _isSensorRichTextVisible = false;
        });
      } else if (_model.textController!.text.contains("❌ No sensor found")) {
        // Replace error message with nothing
        setState(() {
          _model.textController!.text = _model.textController!.text
              .replaceAll("❌ No sensor found", "")
              .trim();
          _isSensorRichTextVisible = false;
        });
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = DebugModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route);
    }
    debugLogGlobalProperty(context);
  }

  @override
  void didPopNext() {
    if (mounted && DebugFlutterFlowModelContext.maybeOf(context) == null) {
      setState(() => _model.isRouteVisible = true);
      debugLogWidgetClass(_model);
    }
  }

  @override
  void didPush() {
    if (mounted && DebugFlutterFlowModelContext.maybeOf(context) == null) {
      setState(() => _model.isRouteVisible = true);
      debugLogWidgetClass(_model);
    }
  }

  @override
  void didPop() {
    _model.isRouteVisible = false;
  }

  @override
  void didPushNext() {
    _model.isRouteVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    DebugFlutterFlowModelContext.maybeOf(context)
        ?.parentModelCallback
        ?.call(_model);
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
            ),
            child: Builder(
              builder: (context) {
                final chat = FFAppState().chatlist.toList();
                _model.debugGeneratorVariables[
                        'chat${chat.length > 100 ? ' (first 100)' : ''}'] =
                    debugSerializeParam(
                  chat.take(100),
                  ParamType.JSON,
                  isList: true,
                  link:
                      'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=uiBuilder&page=mobileAIchat',
                  name: 'dynamic',
                  nullable: false,
                );
                debugLogWidgetClass(_model);

                return CustomRefreshIndicator(
                  onRefresh: () async {
                    // Show loading animation
                    setState(() {
                      FFAppState().isLoading = true;
                    });

                    // Simulate refresh delay (or perform actual data refresh)
                    await Future.delayed(Duration(milliseconds: 1500));

                    // Hide loading indicator when done
                    setState(() {
                      FFAppState().isLoading = false;
                    });
                    // Required to complete the refresh properly
                    return Future.value();
                  },
                  builder: (
                    BuildContext context,
                    Widget child,
                    IndicatorController controller,
                  ) {
                    return Stack(
                      children: [
                        child,
                        if (controller.isLoading)
                          Positioned(
                            top: 20,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: SpinKitChasingDots(
                                color: FlutterFlowTheme.of(context).primary,
                                size: 50.0,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                        bottom:
                            10.0), // Extra padding at bottom for better scrolling
                    scrollDirection: Axis.vertical,
                    itemCount: chat.isEmpty ? 1 : chat.length,
                    itemBuilder: (context, chatIndex) {
                      if (chat.isEmpty) {
                        // Show empty state when no messages
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Center(
                            child: Text(
                                "Hi, I'm Vrinda AI.\nHow can I help you today?",
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .copyWith(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 20.0,
                                    )),
                          ),
                        );
                      }
                      final chatItem = chat[chatIndex];
                      // Get the user info for profile image
                      final bool isUser =
                          getJsonField(chatItem, r'''$.isuser''') == true;
                      final String message =
                          getJsonField(chatItem, r'''$.message''').toString();

                      // Extract image URL from message if available
                      String? imageUrl;
                      bool hasImage = false;
                      String messageText = message;

                      // Check if message contains pest detection image request
                      if (isUser && message.contains('Detect Pest')) {
                        hasImage = true;
                        imageUrl = FFAppState().uploadedImagePath;
                        print("Found pest detection image: $imageUrl");
                      }

                      return Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 12.0, 8.0, 0),
                        child: Column(
                          crossAxisAlignment: isUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            // Display uploaded image if available
                            if (hasImage)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 8.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    // Show full-size image in dialog
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          insetPadding: EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.network(
                                                imageUrl!,
                                                fit: BoxFit.contain,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Image.asset(
                                                        'assets/images/error_image.png'),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                    'Pest Detection Image',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: 300,
                                    height: 300,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        imageUrl!,
                                        width: 300,
                                        height: 300,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          print("Error loading image: $error");
                                          return Image.asset(
                                            'assets/images/error_image.png',
                                            fit: BoxFit.cover,
                                            width: 300,
                                            height: 300,
                                          );
                                        },
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (!isUser)
                                  // AI Avatar
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 8.0, 0),
                                    child: Container(
                                      width: 36,
                                      height: 36,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Image.asset(
                                        'assets/images/new_(1).png', // Use existing image from assets
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error,
                                                stackTrace) =>
                                            Image.asset(
                                                'assets/images/error_image.png',
                                                fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: isUser
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isUser
                                              ? FlutterFlowTheme.of(context)
                                                  .secondaryBackground
                                              : FlutterFlowTheme.of(context)
                                                  .primaryBackground, // Changed to primaryBackground for AI responses
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          border: isUser
                                              ? Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                  width: 1.0,
                                                )
                                              : null, // Removed border for AI responses
                                          boxShadow: isUser
                                              ? [
                                                  BoxShadow(
                                                    blurRadius: 3.0,
                                                    color: Color(0x33000000),
                                                    offset: Offset(0.0, 1.0),
                                                  ),
                                                ]
                                              : null,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 8.0),
                                          child: isUser
                                              ? Text(
                                                  message,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        fontSize: 14.0,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                                )
                                              : Builder(
                                                  builder: (context) {
                                                    // Check if this is a newly added message to trigger animation
                                                    final isNewMessage =
                                                        chatIndex ==
                                                                chat.length -
                                                                    1 &&
                                                            !isUser &&
                                                            FFAppState()
                                                                    .lastProcessedMessageCount !=
                                                                chat.length;

                                                    // Update the last processed message count if needed
                                                    if (isNewMessage &&
                                                        chatIndex ==
                                                            chat.length - 1) {
                                                      Future.delayed(
                                                          Duration(
                                                              milliseconds:
                                                                  100), () {
                                                        FFAppState()
                                                                .lastProcessedMessageCount =
                                                            chat.length;
                                                      });
                                                    }

                                                    return isNewMessage
                                                        ? AnimatedTextKit(
                                                            animatedTexts: [
                                                              TyperAnimatedText(
                                                                message,
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily,
                                                                      fontSize:
                                                                          14.0,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                    ),
                                                                speed: Duration(
                                                                    milliseconds:
                                                                        20),
                                                                curve: Curves
                                                                    .easeOutQuad,
                                                              ),
                                                            ],
                                                            isRepeatingAnimation:
                                                                false,
                                                            totalRepeatCount: 1,
                                                            displayFullTextOnTap:
                                                                true,
                                                            stopPauseOnTap:
                                                                true,
                                                          )
                                                        : Text(
                                                            message,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  fontSize:
                                                                      14.0,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily),
                                                                ),
                                                          );
                                                  },
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isUser)
                                  // User Avatar
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8.0, 0, 0, 0),
                                    child: AuthUserStreamWidget(
                                      builder: (context) => Container(
                                        width: 36,
                                        height: 36,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: currentUserPhoto.isEmpty
                                              ? 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/vrinda-kriyeta4-tllf8o/assets/e1ui32jgr1xq/avatar.png'
                                              : currentUserPhoto,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  'assets/images/error_image.png',
                                                  fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    controller: _model.listViewController,
                  ),
                );
              },
            ),
          ),
        ),
        if (FFAppState().showContainer)
          Container(
            decoration: BoxDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          text: FFLocalizations.of(context).getText(
                            'g0wk709a' /* Help with irrigation? */,
                          ),
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).alternate,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodySmallFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodySmallFamily),
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: FFLocalizations.of(context).getText(
                          'zcquu9i8' /* Sustainable farming practices? */,
                        ),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 8.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).alternate,
                          textStyle: FlutterFlowTheme.of(context)
                              .labelSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelSmallFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .labelSmallFamily),
                              ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ]
                        .divide(SizedBox(height: 10.0))
                        .around(SizedBox(height: 10.0)),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: FFLocalizations.of(context).getText(
                          'abts8ag1' /* Your current challenges? */,
                        ),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 8.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).alternate,
                          textStyle: FlutterFlowTheme.of(context)
                              .labelSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelSmallFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .labelSmallFamily),
                              ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: FFLocalizations.of(context).getText(
                          'p0oad8c8' /* Ideal crop to grow currently? */,
                        ),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 8.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).alternate,
                          textStyle: FlutterFlowTheme.of(context)
                              .labelSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelSmallFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .labelSmallFamily),
                              ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ]
                        .divide(SizedBox(height: 10.0))
                        .around(SizedBox(height: 10.0)),
                  ),
                ),
              ].divide(SizedBox(width: 12.0)).around(SizedBox(width: 12.0)),
            ),
          ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Material(
            color: Colors.transparent,
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minWidth: double.infinity,
                maxWidth: double.infinity,
              ),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).alternate,
                  width: 1.0,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.textController',
                                Duration(milliseconds: 2000),
                                () => setState(() {
                                  // Check if "📊 Sensor Data" was just deleted (special handling for the tag)
                                  if (_isSensorRichTextVisible &&
                                      !_model.textController!.text
                                          .contains("📊 Sensor Data")) {
                                    // Clear any sensor data tag reference if removed
                                    _isSensorRichTextVisible = false;
                                  }
                                }),
                              ),
                              onTap: () {
                                // Open sensor data bottom sheet when sensor data is available
                                if (_model.textController!.text
                                    .contains("📊 Sensor Data")) {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: true,
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.6,
                                          child: SensorDataWidget(),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              autofocus: true,
                              textCapitalization: TextCapitalization.sentences,
                              obscureText: false,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                    lineHeight: 1.5,
                                    // Apply custom styling conditionally for sensor data tag
                                    color: _model.textController!.text
                                            .contains("📊 Sensor Data")
                                        ? Color(0xFF3794FF)
                                        : FlutterFlowTheme.of(context)
                                            .primaryText,
                                    fontWeight: _model.textController!.text
                                            .contains("📊 Sensor Data")
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: FFLocalizations.of(context).getText(
                                  '761yar0a' /* Ask Anything... */,
                                ),
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                      lineHeight: 1.0,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    width: 0.0,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    width: 0.0,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    width: 0.0,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    width: 0.0,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                contentPadding: EdgeInsets.all(16.0),
                                hoverColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              maxLines: 12,
                              minLines: 1,
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              validator: _model.textControllerValidator
                                  .asValidator(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AlignedTooltip(
                        content: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '184awelk' /* Tap to capture images, upload ... */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                        ),
                        offset: 4.0,
                        preferredDirection: AxisDirection.right,
                        borderRadius: BorderRadius.circular(12.0),
                        backgroundColor: FlutterFlowTheme.of(context).alternate,
                        elevation: 4.0,
                        tailBaseWidth: 24.0,
                        tailLength: 12.0,
                        waitDuration: Duration(milliseconds: 100),
                        showDuration: Duration(milliseconds: 1000),
                        triggerMode: TooltipTriggerMode.longPress,
                        child: FlutterFlowIconButton(
                          borderColor: FlutterFlowTheme.of(context).alternate,
                          borderRadius: 100.0,
                          buttonSize: 35.0,
                          fillColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          hoverColor: FlutterFlowTheme.of(context).alternate,
                          hoverIconColor:
                              FlutterFlowTheme.of(context).secondaryText,
                          icon: Icon(
                            Icons.add,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 20.0,
                          ),
                          onPressed: () async {
                            logFirebaseEvent(
                                'MOBILE_A_ICHAT_COMP_add_ICN_ON_TAP');
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              enableDrag: false,
                              useSafeArea: true,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: Container(
                                    height: 240.0,
                                    child: AiBottomSheetWidget(),
                                  ),
                                );
                              },
                            ).then((value) => safeSetState(() {}));
                          },
                        ),
                      ),
                      AlignedTooltip(
                        content: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'bwii8oi8' /* Toggle the button to fetch and... */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                        ),
                        offset: 4.0,
                        preferredDirection: AxisDirection.up,
                        borderRadius: BorderRadius.circular(12.0),
                        backgroundColor: FlutterFlowTheme.of(context).alternate,
                        elevation: 4.0,
                        tailBaseWidth: 24.0,
                        tailLength: 12.0,
                        waitDuration: Duration(milliseconds: 100),
                        showDuration: Duration(milliseconds: 1500),
                        triggerMode: TooltipTriggerMode.longPress,
                        child: Container(
                          height: 35.0,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(24.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  ToggleIcon(
                                    onPressed: () async {
                                      _handleSensorToggle();
                                    },
                                    value: FFAppState().sensorDataFetch,
                                    onIcon: Icon(
                                      Icons.sensors,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 20.0,
                                    ),
                                    offIcon: Icon(
                                      Icons.sensors_off,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 20.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        34.0, 8.0, 0.0, 0.0),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        'vkejjohs' /* Sensor Data */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ].addToEnd(SizedBox(width: 12.0)),
                          ),
                        ),
                      ),
                      AlignedTooltip(
                        content: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'rfakd6m8' /* Toggle the button to access da... */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyMediumFamily),
                                ),
                          ),
                        ),
                        offset: 4.0,
                        preferredDirection: AxisDirection.up,
                        borderRadius: BorderRadius.circular(12.0),
                        backgroundColor: FlutterFlowTheme.of(context).alternate,
                        elevation: 4.0,
                        tailBaseWidth: 24.0,
                        tailLength: 12.0,
                        waitDuration: Duration(milliseconds: 100),
                        showDuration: Duration(milliseconds: 1500),
                        triggerMode: TooltipTriggerMode.longPress,
                        child: Container(
                          height: 35.0,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(24.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  ToggleIcon(
                                    onPressed: () async {
                                      safeSetState(() =>
                                          FFAppState().aiSearchButton =
                                              !FFAppState().aiSearchButton);
                                    },
                                    value: FFAppState().aiSearchButton,
                                    onIcon: Icon(
                                      Icons.travel_explore,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 20.0,
                                    ),
                                    offIcon: Icon(
                                      Icons.search_off,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 20.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        34.0, 8.0, 0.0, 0.0),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        'dgzgvb4m' /* Search */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ].addToEnd(SizedBox(width: 12.0)),
                          ),
                        ),
                      ),
                      AlignedTooltip(
                        content: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'f205439b' /* Tap to give a voice input. */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodySmallFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodySmallFamily),
                                ),
                          ),
                        ),
                        offset: 4.0,
                        preferredDirection: AxisDirection.up,
                        borderRadius: BorderRadius.circular(12.0),
                        backgroundColor: FlutterFlowTheme.of(context).alternate,
                        elevation: 4.0,
                        tailBaseWidth: 24.0,
                        tailLength: 12.0,
                        waitDuration: Duration(milliseconds: 100),
                        showDuration: Duration(milliseconds: 1000),
                        triggerMode: TooltipTriggerMode.longPress,
                        child: ToggleIcon(
                          onPressed: () async {
                            // Toggle voice recognition state
                            setState(() {
                              FFAppState().voiceTrigger =
                                  !FFAppState().voiceTrigger;
                            });

                            if (FFAppState().voiceTrigger) {
                              // Start speech recognition
                              _model.startListening((recognizedText) {
                                // Update the text field with recognized text
                                setState(() {
                                  // If text field is empty, just set it to recognized text
                                  // Otherwise append to existing text
                                  if (_model.textController!.text.isEmpty) {
                                    _model.textController!.text =
                                        recognizedText;
                                  } else {
                                    _model.textController!.text =
                                        recognizedText;
                                  }

                                  // Move cursor to the end of text
                                  _model.textController!.selection =
                                      TextSelection.fromPosition(
                                    TextPosition(
                                        offset:
                                            _model.textController!.text.length),
                                  );
                                });
                              });

                              // Update text field to show listening status
                              if (_model.textController!.text.isEmpty) {
                                _model.textController!.text = "Listening...";
                              } else if (!_model.textController!.text
                                  .contains("Listening")) {
                                _model.textController!.text +=
                                    " (Listening...)";
                              }
                            } else {
                              // Stop speech recognition
                              _model.stopListening();

                              // Remove the listening indicator from text field
                              if (_model.textController!.text ==
                                  "Listening...") {
                                _model.textController!.text = "";
                              } else {
                                _model.textController!.text = _model
                                    .textController!.text
                                    .replaceAll(" (Listening...)", "");
                              }
                            }
                          },
                          value: FFAppState().voiceTrigger,
                          onIcon: Icon(
                            Icons.mic,
                            color: FlutterFlowTheme.of(context).primary,
                            size: 20.0,
                          ),
                          offIcon: Icon(
                            Icons.mic_off,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 20.0,
                          ),
                        ),
                      ),
                      AlignedTooltip(
                        content: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '7ucquesg' /* Tap to generate an AI response... */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodySmallFamily,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodySmallFamily),
                                ),
                          ),
                        ),
                        offset: 4.0,
                        preferredDirection: AxisDirection.left,
                        borderRadius: BorderRadius.circular(12.0),
                        backgroundColor: FlutterFlowTheme.of(context).alternate,
                        elevation: 4.0,
                        tailBaseWidth: 24.0,
                        tailLength: 12.0,
                        waitDuration: Duration(milliseconds: 100),
                        showDuration: Duration(milliseconds: 1000),
                        triggerMode: TooltipTriggerMode.longPress,
                        child: Builder(
                          builder: (context) {
                            if (!FFAppState().isLoading) {
                              return Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                  ),
                                ),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'MOBILE_A_ICHAT_COMP_Icon_5qjrztdr_ON_TAP');
                                    FFAppState().showContainer = false;
                                    setState(() {});
                                    // Get user message from text field
                                    String userMessage =
                                        _model.textController!.text;

                                    // Store the original message for display in chat
                                    FFAppState().usermessage = userMessage;

                                    // Prepare the prompt for AI with sensor data if available
                                    String aiPrompt = userMessage;

                                    // Check if the message contains sensor data tag
                                    if (userMessage
                                        .contains("📊 Sensor Data")) {
                                      // Create a detailed sensor data prompt to send to the API
                                      String sensorDataPrompt = '''
${userMessage}

Soil Sensor Readings:
- Nitrogen (N): "${FFAppState().Nvalue} mg/kg"
- Phosphorus (P): "${FFAppState().Pvalue} mg/kg"
- Potassium (K):"${FFAppState().Kvalue} mg/kg"
- Electrical Conductivity: "${FFAppState().ECvalue} μs/cm"
- Soil Moisture: "${FFAppState().moisturevalue} %" ''';

                                      aiPrompt = sensorDataPrompt;
                                      print(
                                          "Sending prompt with sensor data: $aiPrompt");
                                    }

                                    // Set loading state
                                    setState(() {
                                      FFAppState().isLoading = true;
                                    });

                                    // Add user message to chat list with the original message
                                    FFAppState()
                                        .addToChatlist(<String, dynamic>{
                                      'message': userMessage,
                                      'isuser': true,
                                    });
                                    // Clear text field
                                    setState(() {
                                      _model.textController?.clear();
                                      // Keep sensor data flag but hide the rich text indicator
                                      _isSensorRichTextVisible = false;
                                    });
                                    // Call AI API with the enhanced prompt
                                    _model.apiResulte8x = await PaulCall.call(
                                      input: aiPrompt,
                                    );
                                    if ((_model.apiResulte8x?.succeeded ??
                                        true)) {
                                      FFAppState()
                                          .addToChatlist(<String, dynamic>{
                                        'message': PaulCall.answer(
                                          (_model.apiResulte8x?.jsonBody ?? ''),
                                        ),
                                        'isuser': false,
                                      });
                                    }
                                    // Update UI state
                                    setState(() {
                                      FFAppState().isLoading = false;
                                    });
                                    // Scroll to bottom
                                    await _model.listViewController?.animateTo(
                                      _model.listViewController!.position
                                          .maxScrollExtent,
                                      duration: Duration(milliseconds: 100),
                                      curve: Curves.ease,
                                    );
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.arrow_upward,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                ),
                              );
                            } else {
                              return Lottie.asset(
                                'assets/jsons/AI_Text_Animation_Krishi.json',
                                width: 35.0,
                                height: 35.0,
                                fit: BoxFit.contain,
                                animate: true,
                              );
                            }
                          },
                        ),
                      ),
                    ]
                        .addToStart(SizedBox(width: 4.0))
                        .addToEnd(SizedBox(width: 4.0)),
                  ),
                ].divide(SizedBox(height: 8.0)).around(SizedBox(height: 8.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
