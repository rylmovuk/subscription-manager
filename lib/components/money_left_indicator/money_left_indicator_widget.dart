import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'money_left_indicator_model.dart';
export 'money_left_indicator_model.dart';

class MoneyLeftIndicatorWidget extends StatefulWidget {
  const MoneyLeftIndicatorWidget({
    super.key,
    required this.moneyLeft,
  });

  final double? moneyLeft;

  @override
  State<MoneyLeftIndicatorWidget> createState() =>
      _MoneyLeftIndicatorWidgetState();
}

class _MoneyLeftIndicatorWidgetState extends State<MoneyLeftIndicatorWidget> {
  late MoneyLeftIndicatorModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MoneyLeftIndicatorModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (widget.moneyLeft! >= 0.0) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 6.0, 0.0),
                child: Text(
                  FFLocalizations.of(context).getText(
                    'sqzscqi9' /* SAFE TO SPEND: */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Lexend',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 16.0, 0.0),
                child: Text(
                  formatNumber(
                    widget.moneyLeft,
                    formatType: FormatType.custom,
                    currency: '€',
                    format: '###0.##',
                    locale: '',
                  ),
                  textAlign: TextAlign.end,
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Lexend',
                        color: FlutterFlowTheme.of(context).tertiary,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
            ],
          );
        } else {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 6.0, 0.0),
                child: Text(
                  FFLocalizations.of(context).getText(
                    'nym42hxf' /* OVERSPENDING: */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Lexend',
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 16.0, 0.0),
                child: Text(
                  formatNumber(
                    widget.moneyLeft,
                    formatType: FormatType.custom,
                    currency: '€',
                    format: '###0.##',
                    locale: '',
                  ),
                  textAlign: TextAlign.end,
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Lexend',
                        color: FlutterFlowTheme.of(context).errorRed,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
