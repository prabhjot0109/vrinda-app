import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/upload_data.dart';
import '/backend/api_requests/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ai_bottom_sheet_model.dart';
export 'ai_bottom_sheet_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import 'dart:convert';

class AiBottomSheetWidget extends StatefulWidget {
  const AiBottomSheetWidget({Key? key}) : super(key: key);

  @override
  _AiBottomSheetWidgetState createState() => _AiBottomSheetWidgetState();
}

class _AiBottomSheetWidgetState extends State<AiBottomSheetWidget> {
  late AiBottomSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AiBottomSheetModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: Container(
                  width: 40.0,
                  height: 6.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  alignment: AlignmentDirectional(0.5, 0.0),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Text(
                  FFLocalizations.of(context).getText(
                    'poiwhbx8' /* Upload to Vrinda AI */,
                  ),
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                    fontFamily:
                    FlutterFlowTheme.of(context).titleLargeFamily,
                    letterSpacing: 0.0,
                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                        FlutterFlowTheme.of(context).titleLargeFamily),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color:
                            FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: FlutterFlowIconButton(
                            borderColor: FlutterFlowTheme.of(context).alternate,
                            borderRadius: 30.0,
                            borderWidth: 1.0,
                            buttonSize: 60.0,
                            fillColor: FlutterFlowTheme.of(context).alternate,
                            icon: Icon(
                              Icons.camera_alt_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              logFirebaseEvent(
                                  'AI_BOTTOM_SHEET_camera_alt_rounded_ICN_O');
                              final selectedMedia = await selectMedia(
                                multiImage: false,
                              );
                              print("Camera");
                              print(selectedMedia);
                              if (selectedMedia != null &&
                                  selectedMedia.every((m) => validateFileFormat(
                                      m.storagePath, context))) {
                                safeSetState(
                                        () => _model.isDataUploading1 = true);
                                var selectedUploadedFiles = <FFUploadedFile>[];

                                try {
                                  showUploadMessage(
                                    context,
                                    'Uploading file...',
                                    showLoading: true,
                                  );
                                  selectedUploadedFiles = selectedMedia
                                      .map((m) => FFUploadedFile(
                                    name: m.storagePath.split('/').last,
                                    bytes: m.bytes,
                                    height: m.dimensions?.height,
                                    width: m.dimensions?.width,
                                    blurHash: m.blurHash,
                                  ))
                                      .toList();
                                } finally {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  _model.isDataUploading1 = false;
                                }
                                if (selectedUploadedFiles.length ==
                                    selectedMedia.length) {
                                  safeSetState(() {
                                    _model.uploadedLocalFile1 =
                                        selectedUploadedFiles.first;
                                  });
                                  showUploadMessage(context, 'Success!');

                                  // Start processing with Supabase and API
                                  await processImageWithAI(
                                      _model.uploadedLocalFile1);
                                } else {
                                  safeSetState(() {});
                                  showUploadMessage(
                                      context, 'Failed to upload data');
                                  return;
                                }
                              }
                            },
                          ),
                        ),
                        Text(
                          FFLocalizations.of(context).getText(
                            '8eawddfq' /* Camera */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: FlutterFlowTheme.of(context)
                                .bodyMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context)
                                    .bodyMediumFamily),
                          ),
                        ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color:
                            FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: FlutterFlowIconButton(
                            borderColor: FlutterFlowTheme.of(context).alternate,
                            borderRadius: 30.0,
                            borderWidth: 1.0,
                            buttonSize: 60.0,
                            fillColor: FlutterFlowTheme.of(context).alternate,
                            icon: Icon(
                              Icons.photo_library_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              logFirebaseEvent(
                                  'AI_BOTTOM_SHEET_photo_library_rounded_IC');
                              final selectedMedia = await selectMedia(
                                mediaSource: MediaSource.photoGallery,
                                multiImage: false,
                              );

                              print('Photo Library');

                              if (selectedMedia != null &&
                                  selectedMedia.every((m) => validateFileFormat(
                                      m.storagePath, context))) {
                                safeSetState(
                                        () => _model.isDataUploading2 = true);
                                var selectedUploadedFiles = <FFUploadedFile>[];

                                try {
                                  print("Trying Upload");
                                  print(selectedMedia);
                                  showUploadMessage(
                                    context,
                                    'Uploading file...',
                                    showLoading: true,
                                  );
                                  selectedUploadedFiles = selectedMedia
                                      .map((m) => FFUploadedFile(
                                    name: m.storagePath.split('/').last,
                                    bytes: m.bytes,
                                    height: m.dimensions?.height,
                                    width: m.dimensions?.width,
                                    blurHash: m.blurHash,
                                  ))
                                      .toList();
                                  print("Selected Uploaded Files");
                                  print(selectedUploadedFiles);
                                } finally {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  _model.isDataUploading2 = false;
                                }
                                if (selectedUploadedFiles.length ==
                                    selectedMedia.length) {
                                  safeSetState(() {
                                    _model.uploadedLocalFile2 =
                                        selectedUploadedFiles.first;
                                  });
                                  showUploadMessage(context, 'Success!');

                                  // Start processing with Supabase and API
                                  await processImageWithAI(
                                      _model.uploadedLocalFile2);
                                } else {
                                  safeSetState(() {});
                                  showUploadMessage(
                                      context, 'Failed to upload data');
                                  return;
                                }
                              }
                            },
                          ),
                        ),
                        Text(
                          FFLocalizations.of(context).getText(
                            'wkzuqjs7' /* Photos */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: FlutterFlowTheme.of(context)
                                .bodyMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context)
                                    .bodyMediumFamily),
                          ),
                        ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color:
                            FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: FlutterFlowIconButton(
                            borderColor: FlutterFlowTheme.of(context).alternate,
                            borderRadius: 30.0,
                            borderWidth: 1.0,
                            buttonSize: 60.0,
                            fillColor: FlutterFlowTheme.of(context).alternate,
                            icon: Icon(
                              Icons.upload_file,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              logFirebaseEvent(
                                  'AI_BOTTOM_SHEET_upload_file_ICN_ON_TAP');
                              final selectedFiles = await selectFiles(
                                allowedExtensions: ['pdf'],
                                multiFile: false,
                              );
                              if (selectedFiles != null) {
                                safeSetState(
                                        () => _model.isDataUploading3 = true);
                                var selectedUploadedFiles = <FFUploadedFile>[];

                                try {
                                  showUploadMessage(
                                    context,
                                    'Uploading file...',
                                    showLoading: true,
                                  );
                                  selectedUploadedFiles = selectedFiles
                                      .map((m) => FFUploadedFile(
                                    name: m.storagePath.split('/').last,
                                    bytes: m.bytes,
                                  ))
                                      .toList();
                                } finally {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  _model.isDataUploading3 = false;
                                }
                                if (selectedUploadedFiles.length ==
                                    selectedFiles.length) {
                                  safeSetState(() {
                                    _model.uploadedLocalFile3 =
                                        selectedUploadedFiles.first;
                                  });
                                  showUploadMessage(
                                    context,
                                    'Success!',
                                  );
                                }
                              }
                            },
                          ),
                        ),
                        Text(
                          FFLocalizations.of(context).getText(
                            'dipu0cos' /* Files */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: FlutterFlowTheme.of(context)
                                .bodyMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context)
                                    .bodyMediumFamily),
                          ),
                        ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                  ],
                ),
              ),
            ].divide(SizedBox(height: 24.0)),
          ),
        ),
      ),
    );
  }

  // Dialog to show image results
  void showResultsDialog(
      BuildContext context, String prediction, String imageUrl) {
    bool isLoading = false;
    String geminiResponse = '';
    
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Analysis Results'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prediction: $prediction',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyMediumFamily),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.contain,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    if (geminiResponse.isNotEmpty) ...[  
                      const SizedBox(height: 15),
                      Text(
                        'Gemini Solution:',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyMediumFamily),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          geminiResponse,
                          style: FlutterFlowTheme.of(context).bodySmall,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                    if (isLoading) ...[  
                      const SizedBox(height: 15),
                      Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            const SizedBox(height: 10),
                            Text(
                              'Getting solutions from Gemini...',
                              style: FlutterFlowTheme.of(context).bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                if (!isLoading && geminiResponse.isEmpty)
                  ElevatedButton.icon(
                    icon: Icon(Icons.send),
                    label: Text('Send to Gemini'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: FlutterFlowTheme.of(context).primary,
                      foregroundColor: FlutterFlowTheme.of(context).info,
                    ),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      
                      try {
                        // Send the detected pest class to Gemini API
                        final apiCallOutput = await GeminiAPICall.call(
                          pestClass: prediction,
                          imageUrl: imageUrl,
                        );
                        
                        if (apiCallOutput.succeeded) {
                          final solution = GeminiAPICall.solution(apiCallOutput.jsonBody);
                          setState(() {
                            geminiResponse = solution ?? 'No solution found';
                            isLoading = false;
                          });
                          
                          // Add to chat history in the app state
                          FFAppState().addToChatlist({
                            'isuser': false,
                            'message': 'I have analyzed the pest image and found: $prediction\n\n$solution',
                          });
                        } else {
                          setState(() {
                            geminiResponse = 'Failed to get solution from Gemini API';
                            isLoading = false;
                          });
                        }
                      } catch (e) {
                        setState(() {
                          geminiResponse = 'Error: ${e.toString()}';
                          isLoading = false;
                        });
                      }
                    },
                  ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                ),
                if (geminiResponse.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      // Close dialog and go back to chat
                      Navigator.pop(context);
                      Navigator.pop(context); // Close bottom sheet too
                    },
                    child: Text('View in Chat'),
                  ),
              ],
            );
          },
        );
      },
    );
  }



  // Function to process images with AI
  Future<void> processImageWithAI(FFUploadedFile file) async {
    if (file.bytes == null) {
      showUploadMessage(context, 'Invalid file data');
      return;
    }

    try {
      safeSetState(() {
        _model.isProcessing = true;
      });

      // 1. Upload to Supabase
      final supabase = Supabase.instance.client;
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.name}';
      print("File Name");
      print(fileName);
      final storageResponse = supabase.storage
          .from('images')
          .uploadBinary(
        fileName,
        file.bytes!,
        fileOptions: FileOptions(
          contentType: 'image/jpeg',
        ),
      );

      // 2. Get the public URL
      final imageUrl = supabase.storage.from('images').getPublicUrl(fileName);

      print("Image URL");
      print(imageUrl);

      // 3. Call your prediction API
      String prediction = "";
      String boundedBoxUrl = "";
      String geminiResponse = "";
      bool detectionFailed = false;

      try {
        final response = await http.post(
          Uri.parse(
              "https://swastikbansal0-734bb471-5844-4e55-b40d-2d9032985e7a.socketxp.com/predictImg"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'link': imageUrl,
          }),
        );
        print("API Response");
        print(response.body);

        if (response.statusCode != 200) {
          throw Exception('API Error: ${response.body}');
        }

        // 4. Process the API response
        final responseData = jsonDecode(response.body);
        prediction = responseData['prediction'];
        boundedBoxUrl = responseData['img_link'];

        print("Prediction");
        print(prediction);
        print("Bounded Box URL");
        print(boundedBoxUrl);

        // 5. Automatically send to Gemini API
        if (prediction.isNotEmpty) {
          final geminiOutput = await GeminiAPICall.call(
            pestClass: prediction,
            imageUrl: boundedBoxUrl,
          );

          if (geminiOutput.succeeded) {
            geminiResponse = GeminiAPICall.solution(geminiOutput.jsonBody) ?? 'No solution available';
            print("Gemini Response Received");
          } else {
            geminiResponse = "Could not get pest management solutions at this time.";
            print("Gemini API call failed");
          }
        } else {
          detectionFailed = true;
          geminiResponse = "Pest detection failed. No pest class was identified.";
        }
      } catch (apiError) {
        print("Pest Detection API Error: $apiError");
        detectionFailed = true;
        geminiResponse = "Pest detection failed.";
        // Continue execution to show error in chat
      }

      // 6. Update the model with results
      safeSetState(() {
        _model.predictionResult = prediction;
        _model.boundedBoxImageUrl = boundedBoxUrl;
        _model.isProcessing = false;
      });

      try {
        final Uint8List result_img =
        await supabase.storage.from('images').download('result/$fileName.jpg');
        print("temp downloaded");
      } catch (downloadError) {
        print("Could not download result image: $downloadError");
        // Continue execution
      }

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      // Close the bottom sheet first
      Navigator.pop(context);

      _model.isProcessing = false;

      // Add results to chat
      if (detectionFailed) {
        FFAppState().addToChatlist({
          'isuser': false,
          'message': geminiResponse,
        });
      } else {
        // Add the complete analysis to chat history
        FFAppState().addToChatlist({
          'isuser': false,
          'message': "I have analyzed the pest image and identified: $prediction\n\n$geminiResponse",
        });
      }

      // Return to chat screen without showing a dialog
      return Future.delayed(Duration(milliseconds: 100), () {
        // Navigate back to the chat page
        context.pushNamed('/ai2');
      });

    } catch (e) {
      print("Overall Process Error: $e");
      safeSetState(() {
        _model.isProcessing = false;
      });
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      showUploadMessage(context, 'Error: ${e.toString()}',
          showLoading: false);
      
      // Add error message to chat
      FFAppState().addToChatlist({
        'isuser': false,
        'message': "Pest detection failed. There was an error processing your image.",
      });
      
      // Close bottom sheet and return to chat
      Navigator.pop(context);
      return Future.delayed(Duration(milliseconds: 100), () {
        context.pushNamed('/ai2');
      });
    }
  }
}