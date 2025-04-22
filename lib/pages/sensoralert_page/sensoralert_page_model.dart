import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'sensoralert_page_widget.dart' show SensoralertPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SensoralertPageModel extends FlutterFlowModel<SensoralertPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Slider widget.
  double? _sliderValue1;
  set sliderValue1(double? value) {
    _sliderValue1 = value;
    debugLogWidgetClass(this);
  }

  double? get sliderValue1 => _sliderValue1;

  // State field(s) for Slider widget.
  double? _sliderValue2;
  set sliderValue2(double? value) {
    _sliderValue2 = value;
    debugLogWidgetClass(this);
  }

  double? get sliderValue2 => _sliderValue2;

  // State field(s) for Slider widget.
  double? _sliderValue3;
  set sliderValue3(double? value) {
    _sliderValue3 = value;
    debugLogWidgetClass(this);
  }

  double? get sliderValue3 => _sliderValue3;

  // State field(s) for Slider widget.
  double? _sliderValue4;
  set sliderValue4(double? value) {
    _sliderValue4 = value;
    debugLogWidgetClass(this);
  }

  double? get sliderValue4 => _sliderValue4;

  // State field(s) for Switch widget.
  bool? _switchValue;
  set switchValue(bool? value) {
    _switchValue = value;
    debugLogWidgetClass(this);
  }

  bool? get switchValue => _switchValue;

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
          'sliderValue1': debugSerializeParam(
            sliderValue1,
            ParamType.double,
            link:
                'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=uiBuilder&page=sensoralertPage',
            name: 'double',
            nullable: true,
          ),
          'sliderValue2': debugSerializeParam(
            sliderValue2,
            ParamType.double,
            link:
                'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=uiBuilder&page=sensoralertPage',
            name: 'double',
            nullable: true,
          ),
          'sliderValue3': debugSerializeParam(
            sliderValue3,
            ParamType.double,
            link:
                'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=uiBuilder&page=sensoralertPage',
            name: 'double',
            nullable: true,
          ),
          'sliderValue4': debugSerializeParam(
            sliderValue4,
            ParamType.double,
            link:
                'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=uiBuilder&page=sensoralertPage',
            name: 'double',
            nullable: true,
          ),
          'switchValue': debugSerializeParam(
            switchValue,
            ParamType.bool,
            link:
                'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=uiBuilder&page=sensoralertPage',
            name: 'bool',
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
            'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o/tab=uiBuilder&page=sensoralertPage',
        searchReference:
            'reference=Og9zZW5zb3JhbGVydFBhZ2VQAVoPc2Vuc29yYWxlcnRQYWdl',
        widgetClassName: 'sensoralertPage',
      );
}
