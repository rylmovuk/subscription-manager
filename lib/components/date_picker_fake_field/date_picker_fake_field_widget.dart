import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'date_picker_fake_field_model.dart';
export 'date_picker_fake_field_model.dart';

class DatePickerFakeFieldWidget extends StatefulWidget {
  const DatePickerFakeFieldWidget({
    super.key,
    this.initDateString,
  });

  final String? initDateString;

  @override
  State<DatePickerFakeFieldWidget> createState() =>
      _DatePickerFakeFieldWidgetState();
}

class _DatePickerFakeFieldWidgetState extends State<DatePickerFakeFieldWidget> {
  late DatePickerFakeFieldModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DatePickerFakeFieldModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.dateString = widget.initDateString;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Stack(
        alignment: AlignmentDirectional(-1.0, -1.0),
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                final _datePickedDate = await showDatePicker(
                  context: context,
                  initialDate: getCurrentTimestamp,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2050),
                  builder: (context, child) {
                    return wrapInMaterialDatePickerTheme(
                      context,
                      child!,
                      headerBackgroundColor:
                          FlutterFlowTheme.of(context).primary,
                      headerForegroundColor: FlutterFlowTheme.of(context).info,
                      headerTextStyle:
                          FlutterFlowTheme.of(context).headlineLarge.override(
                                fontFamily: 'Poppins',
                                fontSize: 32.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                      pickerBackgroundColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      pickerForegroundColor:
                          FlutterFlowTheme.of(context).primaryText,
                      selectedDateTimeBackgroundColor:
                          FlutterFlowTheme.of(context).primary,
                      selectedDateTimeForegroundColor:
                          FlutterFlowTheme.of(context).info,
                      actionButtonForegroundColor:
                          FlutterFlowTheme.of(context).primaryText,
                      iconSize: 24.0,
                    );
                  },
                );

                if (_datePickedDate != null) {
                  safeSetState(() {
                    _model.datePicked = DateTime(
                      _datePickedDate.year,
                      _datePickedDate.month,
                      _datePickedDate.day,
                    );
                  });
                }
                if (_model.datePicked != null) {
                  setState(() {
                    _model.dateString = dateTimeFormat(
                      'd/M/y',
                      _model.datePicked,
                      locale: FFLocalizations.of(context).languageCode,
                    );
                  });
                }
              },
              child: Container(
                width: double.infinity,
                height: 58.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 2.0,
                  ),
                ),
                child: Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                    child: Text(
                      valueOrDefault<String>(
                        _model.dateString,
                        '0/0/0000',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Lexend',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
                child: Text(
                  FFLocalizations.of(context).getText(
                    '9mxrnph0' /* Renewal Date */,
                  ),
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Lexend',
                        fontSize: 10.0,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
