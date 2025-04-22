import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'alerts_page_model.dart';
export 'alerts_page_model.dart';

class AlertsPageWidget extends StatefulWidget {
  const AlertsPageWidget({super.key});

  static String routeName = 'alertsPage';
  static String routePath = '/alertsPage';

  @override
  State<AlertsPageWidget> createState() => _AlertsPageWidgetState();
}

class _AlertsPageWidgetState extends State<AlertsPageWidget> with RouteAware {
  late AlertsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AlertsPageModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'alertsPage'});
    _model.switchValue1 = true;
    _model.switchValue2 = true;
    _model.switchValue3 = true;
    _model.switchValue4 = true;
    _model.switchValue5 = true;
    _model.switchValue6 = true;
    _model.switchValue7 = true;
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    _model.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(AlertsPageWidget oldWidget) {
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

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 66.0,
            icon: Icon(
              Icons.chevron_left,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 36.0,
            ),
            onPressed: () async {
              logFirebaseEvent('ALERTS_PAGE_PAGE_chevron_left_ICN_ON_TAP');
              context.pop();
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'je17y8vy' /* Soil Alerts */,
            ),
            style: FlutterFlowTheme.of(context).headlineSmall.override(
              fontFamily: 'Space Grotesk',
              color: FlutterFlowTheme.of(context).primaryText,
              fontSize: 24.0,
              letterSpacing: 0.0,
              useGoogleFonts:
              GoogleFonts.asMap().containsKey('Space Grotesk'),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          '1ye5v59m' /* Enable Soil Alerts */,
                        ),
                        style:
                        FlutterFlowTheme.of(context).titleMedium.override(
                          fontFamily: FlutterFlowTheme.of(context)
                              .titleMediumFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts: GoogleFonts.asMap()
                              .containsKey(FlutterFlowTheme.of(context)
                              .titleMediumFamily),
                        ),
                      ),
                      Switch.adaptive(
                        value: _model.switchValue1!,
                        onChanged: (newValue) async {
                          safeSetState(() => _model.switchValue1 = newValue!);
                        },
                        activeColor: FlutterFlowTheme.of(context).primary,
                        activeTrackColor:
                        FlutterFlowTheme.of(context).primaryText,
                        inactiveTrackColor:
                        FlutterFlowTheme.of(context).primaryBackground,
                        inactiveThumbColor:
                        FlutterFlowTheme.of(context).alternate,
                      ),
                    ],
                  ),
                ),
                if (_model.switchValue1 ?? true)
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      width: double.infinity,
                      height: 400.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: Color(0x1AF44336),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Icon(
                                      Icons.notifications_active,
                                      color:
                                      FlutterFlowTheme.of(context).primary,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'qx5x0kok' /* Alert Management */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                          fontFamily:
                                          FlutterFlowTheme.of(context)
                                              .titleMediumFamily,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts: GoogleFonts
                                              .asMap()
                                              .containsKey(
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .titleMediumFamily),
                                        ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'e64hjsiw' /* Enable notifications for soil ... */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .override(
                                          fontFamily:
                                          FlutterFlowTheme.of(context)
                                              .bodySmallFamily,
                                          color:
                                          FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                          GoogleFonts.asMap()
                                              .containsKey(
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodySmallFamily),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ].divide(SizedBox(width: 12.0)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.water_drop,
                                      color:
                                      FlutterFlowTheme.of(context).primary,
                                      size: 20.0,
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'wybubkcl' /* Low Moisture Alert */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 12.0)),
                                ),
                                Switch(
                                  value: _model.switchValue2!,
                                  onChanged: (newValue) async {
                                    safeSetState(
                                            () => _model.switchValue2 = newValue!);
                                  },
                                  activeColor:
                                  FlutterFlowTheme.of(context).primary,
                                  activeTrackColor:
                                  FlutterFlowTheme.of(context).primaryText,
                                  inactiveTrackColor:
                                  FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  inactiveThumbColor:
                                  FlutterFlowTheme.of(context).alternate,
                                ),
                              ],
                            ),
                            Divider(
                              height: 1.0,
                              thickness: 1.0,
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.grass,
                                      color:
                                      FlutterFlowTheme.of(context).primary,
                                      size: 20.0,
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'oapgj41w' /* High Nutrient Alert */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 12.0)),
                                ),
                                Switch(
                                  value: _model.switchValue3!,
                                  onChanged: (newValue) async {
                                    safeSetState(
                                            () => _model.switchValue3 = newValue!);
                                  },
                                  activeColor:
                                  FlutterFlowTheme.of(context).primary,
                                  activeTrackColor:
                                  FlutterFlowTheme.of(context).primaryText,
                                  inactiveTrackColor:
                                  FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  inactiveThumbColor:
                                  FlutterFlowTheme.of(context).alternate,
                                ),
                              ],
                            ),
                            Divider(
                              height: 1.0,
                              thickness: 1.0,
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.science,
                                      color:
                                      FlutterFlowTheme.of(context).primary,
                                      size: 20.0,
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'd1itnk64' /* pH Level Alert */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 12.0)),
                                ),
                                Switch(
                                  value: _model.switchValue4!,
                                  onChanged: (newValue) async {
                                    safeSetState(
                                            () => _model.switchValue4 = newValue!);
                                  },
                                  activeColor:
                                  FlutterFlowTheme.of(context).primary,
                                  activeTrackColor:
                                  FlutterFlowTheme.of(context).primaryText,
                                  inactiveTrackColor:
                                  FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  inactiveThumbColor:
                                  FlutterFlowTheme.of(context).alternate,
                                ),
                              ],
                            ),
                            Divider(
                              height: 1.0,
                              thickness: 1.0,
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.device_thermostat,
                                      color:
                                      FlutterFlowTheme.of(context).primary,
                                      size: 20.0,
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        '8av4xsof' /* Temperature Alert */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 12.0)),
                                ),
                                Switch(
                                  value: _model.switchValue5!,
                                  onChanged: (newValue) async {
                                    safeSetState(
                                            () => _model.switchValue5 = newValue!);
                                  },
                                  activeColor:
                                  FlutterFlowTheme.of(context).primary,
                                  activeTrackColor:
                                  FlutterFlowTheme.of(context).primaryText,
                                  inactiveTrackColor:
                                  FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  inactiveThumbColor:
                                  FlutterFlowTheme.of(context).alternate,
                                ),
                              ],
                            ),
                            Divider(
                              height: 1.0,
                              thickness: 1.0,
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.bug_report,
                                      color:
                                      FlutterFlowTheme.of(context).primary,
                                      size: 20.0,
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'et69n7ii' /* Pest Alerts */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 12.0)),
                                ),
                                Switch(
                                  value: _model.switchValue6!,
                                  onChanged: (newValue) async {
                                    safeSetState(
                                            () => _model.switchValue6 = newValue!);
                                  },
                                  activeColor:
                                  FlutterFlowTheme.of(context).primary,
                                  activeTrackColor:
                                  FlutterFlowTheme.of(context).primaryText,
                                  inactiveTrackColor:
                                  FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  inactiveThumbColor:
                                  FlutterFlowTheme.of(context).alternate,
                                ),
                              ],
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      ),
                    ),
                  ),
                if (_model.switchValue1 ?? true)
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 16.0, 16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 40.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: Color(0x1A9C27B0),
                                        borderRadius:
                                        BorderRadius.circular(20.0),
                                      ),
                                      child: Align(
                                        alignment:
                                        AlignmentDirectional(0.0, 0.0),
                                        child: Icon(
                                          Icons.alarm,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 24.0,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'z2izncsg' /* Alert Timing Settings */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedium
                                                .override(
                                              fontFamily:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .titleMediumFamily,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts: GoogleFonts
                                                  .asMap()
                                                  .containsKey(
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .titleMediumFamily),
                                            ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'opglj3ra' /* Configure when and how often y... */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                              fontFamily:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodySmallFamily,
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .secondaryText,
                                              letterSpacing: 0.0,
                                              useGoogleFonts: GoogleFonts
                                                  .asMap()
                                                  .containsKey(
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .bodySmallFamily),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 12.0)),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'rak9v1oo' /* Alert Time */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                      ),
                                    ),
                                    Text(
                                      dateTimeFormat(
                                        "d/M h:mm a",
                                        _model.datePicked,
                                        locale: FFLocalizations.of(context)
                                            .languageCode,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'ALERTS_Container_so0cwg34_ON_TAP');

                                    final _datePickedTime =
                                    await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          getCurrentTimestamp),
                                      builder: (context, child) {
                                        return wrapInMaterialTimePickerTheme(
                                          context,
                                          child!,
                                          headerBackgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primary,
                                          headerForegroundColor:
                                          FlutterFlowTheme.of(context)
                                              .black,
                                          headerTextStyle: FlutterFlowTheme.of(
                                              context)
                                              .headlineLarge
                                              .override(
                                            fontFamily:
                                            FlutterFlowTheme.of(context)
                                                .headlineLargeFamily,
                                            fontSize: 32.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            useGoogleFonts: GoogleFonts
                                                .asMap()
                                                .containsKey(FlutterFlowTheme
                                                .of(context)
                                                .headlineLargeFamily),
                                          ),
                                          pickerBackgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          pickerForegroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                          selectedDateTimeBackgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primary,
                                          selectedDateTimeForegroundColor:
                                          FlutterFlowTheme.of(context)
                                              .black,
                                          actionButtonForegroundColor:
                                          FlutterFlowTheme.of(context)
                                              .black,
                                          iconSize: 24.0,
                                        );
                                      },
                                    );
                                    if (_datePickedTime != null) {
                                      safeSetState(() {
                                        _model.datePicked = DateTime(
                                          getCurrentTimestamp.year,
                                          getCurrentTimestamp.month,
                                          getCurrentTimestamp.day,
                                          _datePickedTime.hour,
                                          _datePickedTime.minute,
                                        );
                                      });
                                    } else if (_model.datePicked != null) {
                                      safeSetState(() {
                                        _model.datePicked = getCurrentTimestamp;
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 12.0, 12.0, 12.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(
                                                Icons.access_time,
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                                size: 24.0,
                                              ),
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '6dljd39m' /* Set Alert Date and Time */,
                                                ),
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMediumFamily,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                      .containsKey(
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodyMediumFamily),
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 12.0)),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 18.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'l03wnz80' /* Alert Frequency */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                      ),
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'bzh24jxz' /* Daily */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                    ),
                                  ),
                                  child: FlutterFlowChoiceChips(
                                    options: [
                                      ChipData(
                                          FFLocalizations.of(context).getText(
                                            'xhbwxrwa' /* Daily */,
                                          )),
                                      ChipData(
                                          FFLocalizations.of(context).getText(
                                            'b3g4l3t8' /* Weekly */,
                                          )),
                                      ChipData(
                                          FFLocalizations.of(context).getText(
                                            'o31vqvq0' /* Monthly */,
                                          ))
                                    ],
                                    onChanged: (val) => safeSetState(() =>
                                    _model.choiceChipsValue =
                                        val?.firstOrNull),
                                    selectedChipStyle: ChipStyle(
                                      backgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .black,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                      ),
                                      iconColor:
                                      FlutterFlowTheme.of(context).black,
                                      iconSize: 16.0,
                                      elevation: 0.0,
                                      borderColor:
                                      FlutterFlowTheme.of(context).primary,
                                      borderWidth: 1.0,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    unselectedChipStyle: ChipStyle(
                                      backgroundColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      textStyle: FlutterFlowTheme.of(context)
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
                                      iconColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      iconSize: 18.0,
                                      elevation: 0.0,
                                      borderColor: FlutterFlowTheme.of(context)
                                          .alternate,
                                      borderWidth: 1.0,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    chipSpacing: 24.0,
                                    rowSpacing: 8.0,
                                    multiselect: false,
                                    alignment: WrapAlignment.start,
                                    controller:
                                    _model.choiceChipsValueController ??=
                                        FormFieldController<List<String>>(
                                          [],
                                        ),
                                    wrapped: false,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        '1806xh4c' /* Repeat Alerts */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                      ),
                                    ),
                                    Switch(
                                      value: _model.switchValue7!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                        _model.switchValue7 = newValue!);
                                      },
                                      activeColor:
                                      FlutterFlowTheme.of(context).primary,
                                      activeTrackColor:
                                      FlutterFlowTheme.of(context)
                                          .primaryText,
                                      inactiveTrackColor:
                                      FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      inactiveThumbColor:
                                      FlutterFlowTheme.of(context)
                                          .alternate,
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 1.0,
                                  decoration: BoxDecoration(
                                    color: Color(0x10000000),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'zxvlv1to' /* Alert Interval */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily:
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts
                                                .asMap()
                                                .containsKey(
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMediumFamily),
                                          ),
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            '8rxn0bu8' /* Time between repeated alerts */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                            fontFamily:
                                            FlutterFlowTheme.of(context)
                                                .bodySmallFamily,
                                            color:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            useGoogleFonts: GoogleFonts
                                                .asMap()
                                                .containsKey(
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .bodySmallFamily),
                                          ),
                                        ),
                                      ],
                                    ),
                                    RichText(
                                      textScaler:
                                      MediaQuery.of(context).textScaler,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: valueOrDefault<String>(
                                              _model.sliderValue?.toString(),
                                              '5',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMediumFamily,
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primary,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts: GoogleFonts
                                                  .asMap()
                                                  .containsKey(
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMediumFamily),
                                            ),
                                          ),
                                          TextSpan(
                                            text: FFLocalizations.of(context)
                                                .getText(
                                              'f9exyhuu' /*  min */,
                                            ),
                                            style: TextStyle(),
                                          )
                                        ],
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily:
                                          FlutterFlowTheme.of(context)
                                              .bodyMediumFamily,
                                          color:
                                          FlutterFlowTheme.of(context)
                                              .primary,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts: GoogleFonts
                                              .asMap()
                                              .containsKey(
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMediumFamily),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: Color(0x10000000),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Slider(
                                    activeColor:
                                    FlutterFlowTheme.of(context).primary,
                                    inactiveColor:
                                    FlutterFlowTheme.of(context).alternate,
                                    min: 5.0,
                                    max: 120.0,
                                    value: _model.sliderValue ??= 30.0,
                                    onChanged: (newValue) {
                                      newValue = double.parse(
                                          newValue.toStringAsFixed(1));
                                      safeSetState(
                                              () => _model.sliderValue = newValue);
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        '9aqnp1nv' /* 5m */,
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
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        '1pxq1r7u' /* 60m */,
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
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'uz325gid' /* 120m */,
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
                                  ].divide(SizedBox(width: 8.0)),
                                ),
                              ].divide(SizedBox(height: 16.0)),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 16.0, 16.0, 16.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'ALERTS_SAVE_ALERT_SETTINGS_BTN_ON_TAP');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Alert set successfully.',
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                          fontFamily:
                                          FlutterFlowTheme.of(context)
                                              .labelMediumFamily,
                                          color:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          useGoogleFonts: GoogleFonts
                                              .asMap()
                                              .containsKey(
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelMediumFamily),
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 2000),
                                      backgroundColor:
                                      FlutterFlowTheme.of(context)
                                          .alternate,
                                    ),
                                  );
                                  HapticFeedback.mediumImpact();
                                },
                                text: FFLocalizations.of(context).getText(
                                  '9ca3rnqo' /* Save Alert Settings */,
                                ),
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 45.0,
                                  padding: EdgeInsets.all(8.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleSmallFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .primary,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                        FlutterFlowTheme.of(context)
                                            .titleSmallFamily),
                                  ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ]
                  .addToStart(SizedBox(height: 12.0))
                  .addToEnd(SizedBox(height: 36.0)),
            ),
          ),
        ),
      ),
    );
  }
}
