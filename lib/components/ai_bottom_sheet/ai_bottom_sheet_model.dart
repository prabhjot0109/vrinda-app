import '/flutter_flow/flutter_flow_model.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AiBottomSheetModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this component.

  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
  FFUploadedFile(bytes: Uint8List.fromList([]));

  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
  FFUploadedFile(bytes: Uint8List.fromList([]));

  bool isDataUploading3 = false;
  FFUploadedFile uploadedLocalFile3 =
  FFUploadedFile(bytes: Uint8List.fromList([]));

  // State for prediction
  bool isProcessing = false;
  String? predictionResult;
  String? boundedBoxImageUrl;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}
}