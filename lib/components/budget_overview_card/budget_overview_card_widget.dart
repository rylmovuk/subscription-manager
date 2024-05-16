import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/money_left_indicator/money_left_indicator_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'budget_overview_card_model.dart';
export 'budget_overview_card_model.dart';

class BudgetOverviewCardWidget extends StatefulWidget {
  const BudgetOverviewCardWidget({super.key});

  @override
  State<BudgetOverviewCardWidget> createState() =>
      _BudgetOverviewCardWidgetState();
}

class _BudgetOverviewCardWidgetState extends State<BudgetOverviewCardWidget> {
  late BudgetOverviewCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BudgetOverviewCardModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: StreamBuilder<UserBudgetsRecord>(
        stream: UserBudgetsRecord.getDocument(
            functions.getMainBudgetRef(currentUserReference!)!),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            );
          }
          final budgetUserBudgetsRecord = snapshot.data!;
          return Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10.0,
                  color: Color(0x33000000),
                  offset: Offset(
                    0.0,
                    0.0,
                  ),
                )
              ],
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: StreamBuilder<List<SubscriptionsRecord>>(
                stream: querySubscriptionsRecord(
                  queryBuilder: (subscriptionsRecord) =>
                      subscriptionsRecord.where(
                    'user',
                    isEqualTo: currentUserReference,
                  ),
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 40.0,
                        height: 40.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    );
                  }
                  List<SubscriptionsRecord> containerSubscriptionsRecordList =
                      snapshot.data!;
                  return Container(
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'egkywah6' /* Budget */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        fontFamily: 'Lexend',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Text(
                                  formatNumber(
                                    budgetUserBudgetsRecord.amount,
                                    formatType: FormatType.decimal,
                                    decimalType: DecimalType.automatic,
                                    currency: '€',
                                  ),
                                  textAlign: TextAlign.end,
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        fontFamily: 'Lexend',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        wrapWithModel(
                          model: _model.moneyLeftIndicatorModel,
                          updateCallback: () => setState(() {}),
                          child: MoneyLeftIndicatorWidget(
                            moneyLeft: budgetUserBudgetsRecord.amount -
                                functions.getMonthlyExpenses(
                                    containerSubscriptionsRecordList.toList()),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
