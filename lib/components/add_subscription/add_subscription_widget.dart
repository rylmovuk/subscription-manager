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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_subscription_model.dart';
export 'add_subscription_model.dart';

class AddSubscriptionWidget extends StatefulWidget {
  const AddSubscriptionWidget({
    super.key,
    this.defaultSub,
  });

  final DefaultSubscriptionsRecord? defaultSub;

  @override
  State<AddSubscriptionWidget> createState() => _AddSubscriptionWidgetState();
}

class _AddSubscriptionWidgetState extends State<AddSubscriptionWidget> {
  late AddSubscriptionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddSubscriptionModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.shownIconUrl = widget.defaultSub?.iconUrl;
      });
      setState(() {
        _model.subnameTextController?.text = widget.defaultSub!.name;
      });
      setState(() {
        _model.categoryTextController?.text = widget.defaultSub!.category;
      });
    });

    _model.subnameTextController ??= TextEditingController();
    _model.subnameFocusNode ??= FocusNode();

    _model.costTextController ??= TextEditingController();
    _model.costFocusNode ??= FocusNode();

    _model.categoryTextController ??= TextEditingController();
    _model.categoryFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 1.77,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Material(
                  color: Colors.transparent,
                  elevation: 6.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      width: 90.0,
                      height: 90.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).darkBackground,
                        borderRadius: BorderRadius.circular(16.0),
                        shape: BoxShape.rectangle,
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        children: [
                          if (_model.shownIconUrl == null ||
                              _model.shownIconUrl == '')
                            Icon(
                              Icons.image_search_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 80.0,
                            ),
                          if (_model.shownIconUrl != null &&
                              _model.shownIconUrl != '')
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: Image.network(
                                _model.shownIconUrl!,
                                width: 300.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    final selectedMedia = await selectMedia(
                      mediaSource: MediaSource.photoGallery,
                      multiImage: false,
                    );
                    if (selectedMedia != null &&
                        selectedMedia.every((m) =>
                            validateFileFormat(m.storagePath, context))) {
                      setState(() => _model.isDataUploading = true);
                      var selectedUploadedFiles = <FFUploadedFile>[];

                      var downloadUrls = <String>[];
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

                        downloadUrls = (await Future.wait(
                          selectedMedia.map(
                            (m) async =>
                                await uploadData(m.storagePath, m.bytes),
                          ),
                        ))
                            .where((u) => u != null)
                            .map((u) => u!)
                            .toList();
                      } finally {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        _model.isDataUploading = false;
                      }
                      if (selectedUploadedFiles.length ==
                              selectedMedia.length &&
                          downloadUrls.length == selectedMedia.length) {
                        setState(() {
                          _model.uploadedLocalFile =
                              selectedUploadedFiles.first;
                          _model.uploadedFileUrl = downloadUrls.first;
                        });
                        showUploadMessage(context, 'Success!');
                      } else {
                        setState(() {});
                        showUploadMessage(context, 'Failed to upload data');
                        return;
                      }
                    }

                    if (_model.uploadedFileUrl != null &&
                        _model.uploadedFileUrl != '') {
                      setState(() {
                        _model.shownIconUrl = _model.uploadedFileUrl;
                      });
                    }
                  },
                  text: FFLocalizations.of(context).getText(
                    'ep5f4h89' /* Change Image */,
                  ),
                  options: FFButtonOptions(
                    width: 140.0,
                    height: 40.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    textStyle: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Lexend',
                          letterSpacing: 0.0,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                child: TextFormField(
                  controller: _model.subnameTextController,
                  focusNode: _model.subnameFocusNode,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: FFLocalizations.of(context).getText(
                      '1x34bnf4' /* Subscription Name */,
                    ),
                    labelStyle: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Lexend',
                          letterSpacing: 0.0,
                        ),
                    hintText: FFLocalizations.of(context).getText(
                      'm3mm9wfb' /* i.e. Disney+ */,
                    ),
                    hintStyle: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Lexend',
                          letterSpacing: 0.0,
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    contentPadding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 20.0, 24.0),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Lexend',
                        letterSpacing: 0.0,
                      ),
                  validator: _model.subnameTextControllerValidator
                      .asValidator(context),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                child: wrapWithModel(
                  model: _model.datePickerFakeFieldModel,
                  updateCallback: () => setState(() {}),
                  updateOnChange: true,
                  child: DatePickerFakeFieldWidget(
                    initDateString: dateTimeFormat(
                      'd/M/y',
                      getCurrentTimestamp,
                      locale: FFLocalizations.of(context).languageCode,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                child: TextFormField(
                  controller: _model.costTextController,
                  focusNode: _model.costFocusNode,
                  onChanged: (_) => EasyDebounce.debounce(
                    '_model.costTextController',
                    Duration(milliseconds: 200),
                    () => setState(() {}),
                  ),
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: FFLocalizations.of(context).getText(
                      '9kfzbowv' /* Cost */,
                    ),
                    labelStyle: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Lexend',
                          letterSpacing: 0.0,
                        ),
                    alignLabelWithHint: false,
                    hintText: FFLocalizations.of(context).getText(
                      'j0rxbsvx' /* i.e. 4.99$ */,
                    ),
                    hintStyle: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Lexend',
                          letterSpacing: 0.0,
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).secondaryText,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).errorRed,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).errorRed,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    contentPadding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 20.0, 24.0),
                    prefixIcon: Icon(
                      Icons.euro,
                      color: (_model.costFocusNode?.hasFocus ?? false)
                          ? FlutterFlowTheme.of(context).tertiary
                          : FlutterFlowTheme.of(context).alternate,
                      size: 20.0,
                    ),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Lexend',
                        letterSpacing: 0.0,
                      ),
                  maxLength: 12,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  buildCounter: (context,
                          {required currentLength,
                          required isFocused,
                          maxLength}) =>
                      null,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator:
                      _model.costTextControllerValidator.asValidator(context),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9,.]'))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                child: TextFormField(
                  controller: _model.categoryTextController,
                  focusNode: _model.categoryFocusNode,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: FFLocalizations.of(context).getText(
                      'lncmykt5' /* Category */,
                    ),
                    labelStyle: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Lexend',
                          letterSpacing: 0.0,
                        ),
                    hintText: FFLocalizations.of(context).getText(
                      'ae2g6j44' /* i.e. Cinema */,
                    ),
                    hintStyle: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Lexend',
                          letterSpacing: 0.0,
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    contentPadding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 20.0, 24.0),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Lexend',
                        letterSpacing: 0.0,
                      ),
                  keyboardType: TextInputType.emailAddress,
                  validator: _model.categoryTextControllerValidator
                      .asValidator(context),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                child: FlutterFlowDropDown<RenewalType>(
                  controller: _model.dropDownValueController ??=
                      FormFieldController<RenewalType>(
                    _model.dropDownValue ??= RenewalType.day_of_month,
                  ),
                  options: List<RenewalType>.from(RenewalType.values),
                  optionLabels: [
                    FFLocalizations.of(context).getText(
                      '2btdbygr' /* Weekly */,
                    ),
                    FFLocalizations.of(context).getText(
                      'vx8hc4lx' /* Monthly */,
                    ),
                    FFLocalizations.of(context).getText(
                      'jsydafow' /* Annual */,
                    )
                  ],
                  onChanged: (val) =>
                      setState(() => _model.dropDownValue = val),
                  width: 300.0,
                  height: 56.0,
                  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Lexend',
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                      ),
                  hintText: FFLocalizations.of(context).getText(
                    'cx1c61us' /* Please select... */,
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 24.0,
                  ),
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  elevation: 2.0,
                  borderColor: FlutterFlowTheme.of(context).alternate,
                  borderWidth: 2.0,
                  borderRadius: 8.0,
                  margin: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                  hidesUnderline: true,
                  isOverButton: true,
                  isSearchable: false,
                  isMultiSelect: false,
                  labelText: FFLocalizations.of(context).getText(
                    'tgblm8u8' /* Renewal */,
                  ),
                  labelTextStyle:
                      FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                          ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        'paqtziyc' /* Shared Subscription? */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Lexend',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                    Theme(
                      data: ThemeData(
                        checkboxTheme: CheckboxThemeData(
                          visualDensity: VisualDensity.compact,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        unselectedWidgetColor:
                            FlutterFlowTheme.of(context).secondaryText,
                      ),
                      child: Checkbox(
                        value: _model.checkboxValue ??= false,
                        onChanged: (newValue) async {
                          setState(() => _model.checkboxValue = newValue!);
                        },
                        side: BorderSide(
                          width: 2,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                        activeColor: FlutterFlowTheme.of(context).primary,
                        checkColor: FlutterFlowTheme.of(context).info,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 32.0, 0.0),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Color(0x9AF06A6A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30.0,
                        buttonSize: 48.0,
                        icon: Icon(
                          Icons.close_rounded,
                          color: FlutterFlowTheme.of(context).errorRed,
                          size: 25.0,
                        ),
                        onPressed: () async {
                          context.safePop();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Color(0x4D39D2C0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30.0,
                        buttonSize: 48.0,
                        icon: Icon(
                          Icons.done,
                          color: FlutterFlowTheme.of(context).tertiary,
                          size: 25.0,
                        ),
                        onPressed: () async {
                          if (_model.shownIconUrl == null ||
                              _model.shownIconUrl == '') {
                            await SubscriptionsRecord.collection.doc().set({
                              ...createSubscriptionsRecordData(
                                name: _model.subnameTextController.text,
                                amount: double.tryParse(
                                    _model.costTextController.text),
                                isShared: _model.checkboxValue,
                                iconUrl: null,
                                user: currentUserReference,
                                category: functions.categoryFromString(
                                    _model.categoryTextController.text),
                                date: functions.parseDateWithFormat(
                                    'd/M/y',
                                    _model
                                        .datePickerFakeFieldModel.dateString!),
                                renewal: _model.dropDownValue,
                              ),
                              ...mapToFirestore(
                                {
                                  'created_at': FieldValue.serverTimestamp(),
                                },
                              ),
                            });
                          } else {
                            await SubscriptionsRecord.collection.doc().set({
                              ...createSubscriptionsRecordData(
                                name: _model.subnameTextController.text,
                                amount: double.tryParse(
                                    _model.costTextController.text),
                                isShared: _model.checkboxValue,
                                iconUrl: _model.shownIconUrl,
                                user: currentUserReference,
                                category: functions.categoryFromString(
                                    _model.categoryTextController.text),
                                date: functions.parseDateWithFormat(
                                    'd/M/y',
                                    _model
                                        .datePickerFakeFieldModel.dateString!),
                                renewal: _model.dropDownValue,
                              ),
                              ...mapToFirestore(
                                {
                                  'created_at': FieldValue.serverTimestamp(),
                                },
                              ),
                            });
                          }

                          context.goNamed('Subscription');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ]
                .addToStart(SizedBox(height: 16.0))
                .addToEnd(SizedBox(height: 16.0)),
          ),
        ),
      ),
    );
  }
}
