import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/components/ai_bottom_sheet/ai_bottom_sheet_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';
import 'mobile_a_ichat_model.dart';
export 'mobile_a_ichat_model.dart';

class MobileAIchatWidget extends StatefulWidget {
  const MobileAIchatWidget({super.key});

  @override
  State<MobileAIchatWidget> createState() => _MobileAIchatWidgetState();
}

class _MobileAIchatWidgetState extends State<MobileAIchatWidget>
    with RouteAware {
  late MobileAIchatModel _model;

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
        debugLogWidgetClass(_model);
      });
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    _model.maybeDispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(MobileAIchatWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _model.widget = widget;
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

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: chat.length,
                  itemBuilder: (context, chatIndex) {
                    final chatItem = chat[chatIndex];
                    // Get the user info for profile image
                    final bool isUser = getJsonField(chatItem, r'''$.isuser''') == true;
                    final String message = getJsonField(chatItem, r'''$.message''').toString();
                    
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
                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 12.0, 8.0, 0),
                      child: Column(
                        crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          // Display uploaded image if available
                          if (hasImage)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8.0),
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
                                              errorBuilder: (context, error, stackTrace) => 
                                                Image.asset('assets/images/error_image.png'),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text('Pest Detection Image', 
                                                style: FlutterFlowTheme.of(context).bodyMedium),
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
                                      color: FlutterFlowTheme.of(context).alternate,
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
                                      errorBuilder: (context, error, stackTrace) {
                                        print("Error loading image: $error");
                                        return Image.asset(
                                          'assets/images/error_image.png', 
                                          fit: BoxFit.cover,
                                          width: 300,
                                          height: 300,
                                        );
                                      },
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded / 
                                                  loadingProgress.expectedTotalBytes!
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
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8.0, 0),
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context).alternate,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Image.asset(
                                      'assets/images/new_(1).png',  // Use existing image from assets
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => 
                                        Image.asset('assets/images/error_image.png', fit: BoxFit.cover),
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
                                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isUser
                                            ? FlutterFlowTheme.of(context).secondaryBackground
                                            : FlutterFlowTheme.of(context).primaryBackground, // Changed to primaryBackground for AI responses
                                        borderRadius: BorderRadius.circular(12.0),
                                        border: isUser ? Border.all(
                                          color: FlutterFlowTheme.of(context).alternate,
                                          width: 1.0,
                                        ) : null, // Removed border for AI responses
                                        boxShadow: isUser ? [
                                          BoxShadow(
                                            blurRadius: 3.0,
                                            color: Color(0x33000000),
                                            offset: Offset(0.0, 1.0),
                                          ),
                                        ] : null,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                        child: isUser
                                            ? Text(
                                                message,
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                  fontSize: 14.0,
                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                      FlutterFlowTheme.of(context).bodyMediumFamily),
                                                ),
                                              )
                                            : Builder(
                                                builder: (context) {
                                                  // Check if this is a newly added message to trigger animation
                                                  final isNewMessage = chatIndex == chat.length - 1 && 
                                                      !isUser && 
                                                      FFAppState().lastProcessedMessageCount != chat.length;
                                                  
                                                  // Update the last processed message count if needed
                                                  if (isNewMessage && chatIndex == chat.length - 1) {
                                                    Future.delayed(Duration(milliseconds: 100), () {
                                                      FFAppState().lastProcessedMessageCount = chat.length;
                                                    });
                                                  }
                                                  
                                                  return isNewMessage
                                                    ? AnimatedTextKit(
                                                        animatedTexts: [
                                                          TyperAnimatedText(
                                                            message,
                                                            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                              fontSize: 14.0,
                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                              letterSpacing: 0.0,
                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                                  FlutterFlowTheme.of(context).bodyMediumFamily),
                                                            ),
                                                            speed: Duration(milliseconds: 20),
                                                            curve: Curves.easeOutQuad,
                                                          ),
                                                        ],
                                                        isRepeatingAnimation: false,
                                                        totalRepeatCount: 1,
                                                        displayFullTextOnTap: true,
                                                        stopPauseOnTap: true,
                                                      )
                                                    : Text(
                                                        message,
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                          fontSize: 14.0,
                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                          letterSpacing: 0.0,
                                                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                              FlutterFlowTheme.of(context).bodyMediumFamily),
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
                                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0, 0, 0),
                                  child: AuthUserStreamWidget(
                                    builder: (context) => Container(
                                      width: 36,
                                      height: 36,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context).alternate,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: currentUserPhoto.isEmpty
                                            ? 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/vrinda-kriyeta4-tllf8o/assets/e1ui32jgr1xq/avatar.png'
                                            : currentUserPhoto,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) => 
                                          Image.asset('assets/images/error_image.png', fit: BoxFit.cover),
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 10.0, 10.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          text: FFLocalizations.of(context).getText(
                            'g0wk709a' /* Help with irrigation? */,
                          ),
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).alternate,
                            textStyle: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelSmallFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .labelSmallFamily),
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 10.0, 10.0, 10.0),
                        child: FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          text: FFLocalizations.of(context).getText(
                            'zcquu9i8' /* Sustainable farming practices? */,
                          ),
                          options: FFButtonOptions(
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
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .labelSmallFamily),
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 10.0, 10.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          text: FFLocalizations.of(context).getText(
                            'abts8ag1' /* Your current challenges? */,
                          ),
                          options: FFButtonOptions(
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
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .labelSmallFamily),
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 10.0, 10.0, 10.0),
                        child: FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          text: FFLocalizations.of(context).getText(
                            'p0oad8c8' /* Ideal crop to grow currently? */,
                          ),
                          options: FFButtonOptions(
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
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .labelSmallFamily),
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Material(
            color: Colors.transparent,
            elevation: 5.0,
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
                        child: TextFormField(
                          controller: _model.textController,
                          focusNode: _model.textFieldFocusNode,
                          autofocus: false,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.done,
                          obscureText: false,
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
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
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
                                color: Color(0x00000000),
                                width: 0.0,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 0.0,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
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
                            contentPadding: EdgeInsets.all(12.0),
                            hoverColor: FlutterFlowTheme.of(context).alternate,
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
                                lineHeight: 1.5,
                              ),
                          maxLines: 12,
                          minLines: 1,
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model.textControllerValidator
                              .asValidator(context),
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
                                return SizedBox(
                                  height: 240.0,
                                  child: AiBottomSheetWidget(),
                                );
                              },
                            ).then((value) => safeSetState(() {}));
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                        child: AlignedTooltip(
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
                              safeSetState(() => FFAppState().voiceTrigger =
                                  !FFAppState().voiceTrigger);
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
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      logFirebaseEvent(
                                          'MOBILE_A_ICHAT_COMP_Icon_5qjrztdr_ON_TAP');
                                      FFAppState().showContainer = false;
                                      safeSetState(() {});
                                      FFAppState().usermessage =
                                          _model.textController.text;
                                      safeSetState(() {});
                                      FFAppState().isLoading = true;
                                      safeSetState(() {});
                                      FFAppState()
                                          .addToChatlist(<String, dynamic>{
                                        'message': FFAppState().usermessage,
                                        'isuser': true,
                                      });
                                      safeSetState(() {});
                                      safeSetState(() {
                                        _model.textController?.clear();
                                      });
                                      _model.apiResulte8x = await PaulCall.call(
                                        input: FFAppState().usermessage,
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
                                        safeSetState(() {});
                                      }
                                      FFAppState().isLoading = false;
                                      safeSetState(() {});
                                      await _model.listViewController?.animateTo(
                                        _model.listViewController!.position
                                            .maxScrollExtent,
                                        duration: Duration(milliseconds: 100),
                                        curve: Curves.ease,
                                      );

                                      safeSetState(() {});
                                    },
                                    child: Icon(
                                      Icons.arrow_upward,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
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
                    ],
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
