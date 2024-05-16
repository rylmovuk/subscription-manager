import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/money_left_indicator/money_left_indicator_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'budget_overview_card_widget.dart' show BudgetOverviewCardWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BudgetOverviewCardModel
    extends FlutterFlowModel<BudgetOverviewCardWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for moneyLeftIndicator component.
  late MoneyLeftIndicatorModel moneyLeftIndicatorModel;

  @override
  void initState(BuildContext context) {
    moneyLeftIndicatorModel =
        createModel(context, () => MoneyLeftIndicatorModel());
  }

  @override
  void dispose() {
    moneyLeftIndicatorModel.dispose();
  }
}
