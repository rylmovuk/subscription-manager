import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/schema/enums/enums.dart';
import '/components/date_picker_fake_field/date_picker_fake_field_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'add_subscription_widget.dart' show AddSubscriptionWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddSubscriptionModel extends FlutterFlowModel<AddSubscriptionWidget> {
  ///  Local state fields for this component.

  String? shownIconUrl;

  ///  State fields for stateful widgets in this component.

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for subname widget.
  FocusNode? subnameFocusNode;
  TextEditingController? subnameTextController;
  String? Function(BuildContext, String?)? subnameTextControllerValidator;
  // Model for datePickerFakeField component.
  late DatePickerFakeFieldModel datePickerFakeFieldModel;
  // State field(s) for cost widget.
  FocusNode? costFocusNode;
  TextEditingController? costTextController;
  String? Function(BuildContext, String?)? costTextControllerValidator;
  // State field(s) for category widget.
  FocusNode? categoryFocusNode;
  TextEditingController? categoryTextController;
  String? Function(BuildContext, String?)? categoryTextControllerValidator;
  // State field(s) for DropDown widget.
  RenewalType? dropDownValue;
  FormFieldController<RenewalType>? dropDownValueController;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;

  @override
  void initState(BuildContext context) {
    datePickerFakeFieldModel =
        createModel(context, () => DatePickerFakeFieldModel());
  }

  @override
  void dispose() {
    subnameFocusNode?.dispose();
    subnameTextController?.dispose();

    datePickerFakeFieldModel.dispose();
    costFocusNode?.dispose();
    costTextController?.dispose();

    categoryFocusNode?.dispose();
    categoryTextController?.dispose();
  }
}
