import '/components/drone_a_ichat/drone_a_ichat_widget.dart';
import '/components/mobile_a_ichat/mobile_a_ichat_widget.dart';
import '/components/soilhealth_a_i/soilhealth_a_i_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'ai2_widget.dart' show Ai2Widget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Ai2Model extends FlutterFlowModel<Ai2Widget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDown widget.
  int? _dropDownValue;
  set dropDownValue(int? value) {
    _dropDownValue = value;
    debugLogWidgetClass(this);
  }

  int? get dropDownValue => _dropDownValue;

  FormFieldController<int>? dropDownValueController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Model for mobileAIchat component.
  late MobileAIchatModel mobileAIchatModel;
  // Model for droneAIchat component.
  late DroneAIchatModel droneAIchatModel;
  // Model for soilhealthAI component.
  late SoilhealthAIModel soilhealthAIModel;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    mobileAIchatModel = createModel(context, () => MobileAIchatModel());
    droneAIchatModel = createModel(context, () => DroneAIchatModel());
    soilhealthAIModel = createModel(context, () => SoilhealthAIModel());

    debugLogWidgetClass(this);
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    mobileAIchatModel.dispose();
    droneAIchatModel.dispose();
    soilhealthAIModel.dispose();
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        widgetStates: {
          'dropDownValue': debugSerializeParam(
            dropDownValue,
            ParamType.int,
            link:
                'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=uiBuilder&page=ai2',
            name: 'int',
            nullable: true,
          ),
          'textFieldText': debugSerializeParam(
            textController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o?tab=uiBuilder&page=ai2',
            name: 'String',
            nullable: true,
          )
        },
        generatorVariables: debugGeneratorVariables,
        backendQueries: debugBackendQueries,
        componentStates: {
          'mobileAIchatModel (mobileAIchat)':
              mobileAIchatModel?.toWidgetClassDebugData(),
          'droneAIchatModel (droneAIchat)':
              droneAIchatModel?.toWidgetClassDebugData(),
          'soilhealthAIModel (soilhealthAI)':
              soilhealthAIModel?.toWidgetClassDebugData(),
          ...widgetBuilderComponents.map(
            (key, value) => MapEntry(
              key,
              value.toWidgetClassDebugData(),
            ),
          ),
        }.withoutNulls,
        link:
            'https://app.flutterflow.io/project/vrinda-kriyeta4-tllf8o/tab=uiBuilder&page=ai2',
        searchReference: 'reference=OgNhaTJQAVoDYWky',
        widgetClassName: 'ai2',
      );
}
