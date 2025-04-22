import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'alerts_page_widget.dart' show AlertsPageWidget;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AlertsPageModel extends FlutterFlowModel<AlertsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Switch widget.
  bool? _switchValue1;
  set switchValue1(bool? value) {
    _switchValue1 = value;
    debugLogWidgetClass(this);
  }

  bool? get switchValue1 => _switchValue1;

  // State field(s) for Switch widget.
  bool? _switchValue2;
  set switchValue2(bool? value) {
    _switchValue2 = value;
    debugLogWidgetClass(this);
  }

  bool? get switchValue2 => _switchValue2;

  // State field(s) for Switch widget.
  bool? _switchValue3;
  set switchValue3(bool? value) {
    _switchValue3 = value;
    debugLogWidgetClass(this);
  }

  bool? get switchValue3 => _switchValue3;

  // State field(s) for Switch widget.
  bool? _switchValue4;
  set switchValue4(bool? value) {
    _switchValue4 = value;
    debugLogWidgetClass(this);
  }

  bool? get switchValue4 => _switchValue4;

  // State field(s) for Switch widget.
  bool? _switchValue5;
  set switchValue5(bool? value) {
    _switchValue5 = value;
    debugLogWidgetClass(this);
  }

  bool? get switchValue5 => _switchValue5;

  // State field(s) for Switch widget.
  bool? _switchValue6;
  set switchValue6(bool? value) {
    _switchValue6 = value;
    debugLogWidgetClass(this);
  }

  bool? get switchValue6 => _switchValue6;

  DateTime? datePicked;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) {
    choiceChipsValueController?.value = val != null ? [val] : [];
    debugLogWidgetClass(this);
  }

  // State field(s) for Switch widget.
  bool? _switchValue7;
  set switchValue7(bool? value) {
    _switchValue7 = value;
    debugLogWidgetClass(this);
  }

  bool? get switchValue7 => _switchValue7;

  // State field(s) for Slider widget.
  double? _sliderValue;
  set sliderValue(double? value) {
    _sliderValue = value;
    debugLogWidgetClass(this);
  }

  double? get sliderValue => _sliderValue;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    debugLogWidgetClass(this);
  }

  @override
  void dispose() {}

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
    widgetStates: {
      'switchValue1': debugSerializeParam(
        switchValue1,
        ParamType.bool,
        link:
        'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=uiBuilder&page=alertsPage',
        name: 'bool',
        nullable: true,
      ),
      'switchValue2': debugSerializeParam(
        switchValue2,
        ParamType.bool,
        link:
        'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=uiBuilder&page=alertsPage',
        name: 'bool',
        nullable: true,
      ),
      'switchValue3': debugSerializeParam(
        switchValue3,
        ParamType.bool,
        link:
        'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=uiBuilder&page=alertsPage',
        name: 'bool',
        nullable: true,
      ),
      'switchValue4': debugSerializeParam(
        switchValue4,
        ParamType.bool,
        link:
        'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=uiBuilder&page=alertsPage',
        name: 'bool',
        nullable: true,
      ),
      'switchValue5': debugSerializeParam(
        switchValue5,
        ParamType.bool,
        link:
        'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=uiBuilder&page=alertsPage',
        name: 'bool',
        nullable: true,
      ),
      'switchValue6': debugSerializeParam(
        switchValue6,
        ParamType.bool,
        link:
        'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=uiBuilder&page=alertsPage',
        name: 'bool',
        nullable: true,
      ),
      'choiceChipsValue': debugSerializeParam(
        choiceChipsValue,
        ParamType.String,
        link:
        'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=uiBuilder&page=alertsPage',
        name: 'String',
        nullable: true,
      ),
      'switchValue7': debugSerializeParam(
        switchValue7,
        ParamType.bool,
        link:
        'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=uiBuilder&page=alertsPage',
        name: 'bool',
        nullable: true,
      ),
      'sliderValue': debugSerializeParam(
        sliderValue,
        ParamType.double,
        link:
        'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=uiBuilder&page=alertsPage',
        name: 'double',
        nullable: true,
      )
    },
    generatorVariables: debugGeneratorVariables,
    backendQueries: debugBackendQueries,
    componentStates: {
      ...widgetBuilderComponents.map(
            (key, value) => MapEntry(
          key,
          value.toWidgetClassDebugData(),
        ),
      ),
    }.withoutNulls,
    link:
    'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o/tab=uiBuilder&page=alertsPage',
    searchReference: 'reference=OgphbGVydHNQYWdlUAFaCmFsZXJ0c1BhZ2U=',
    widgetClassName: 'alertsPage',
  );
}
