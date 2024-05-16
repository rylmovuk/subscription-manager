import '/auth/firebase_auth/auth_util.dart';
import '/backend/schema/enums/enums.dart';
import '/components/budget_overview_card/budget_overview_card_widget.dart';
import '/components/subscription_list/subscription_list_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for budgetOverviewCard component.
  late BudgetOverviewCardModel budgetOverviewCardModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // Model for subscriptionList component.
  late SubscriptionListModel subscriptionListModel1;
  // Model for subscriptionList component.
  late SubscriptionListModel subscriptionListModel2;
  // Model for subscriptionList component.
  late SubscriptionListModel subscriptionListModel3;
  // Model for subscriptionList component.
  late SubscriptionListModel subscriptionListModel4;
  // Model for subscriptionList component.
  late SubscriptionListModel subscriptionListModel5;
  // Model for subscriptionList component.
  late SubscriptionListModel subscriptionListModel6;
  // Model for subscriptionList component.
  late SubscriptionListModel subscriptionListModel7;
  // Model for subscriptionList component.
  late SubscriptionListModel subscriptionListModel8;

  @override
  void initState(BuildContext context) {
    budgetOverviewCardModel =
        createModel(context, () => BudgetOverviewCardModel());
    subscriptionListModel1 =
        createModel(context, () => SubscriptionListModel());
    subscriptionListModel2 =
        createModel(context, () => SubscriptionListModel());
    subscriptionListModel3 =
        createModel(context, () => SubscriptionListModel());
    subscriptionListModel4 =
        createModel(context, () => SubscriptionListModel());
    subscriptionListModel5 =
        createModel(context, () => SubscriptionListModel());
    subscriptionListModel6 =
        createModel(context, () => SubscriptionListModel());
    subscriptionListModel7 =
        createModel(context, () => SubscriptionListModel());
    subscriptionListModel8 =
        createModel(context, () => SubscriptionListModel());
  }

  @override
  void dispose() {
    budgetOverviewCardModel.dispose();
    tabBarController?.dispose();
    subscriptionListModel1.dispose();
    subscriptionListModel2.dispose();
    subscriptionListModel3.dispose();
    subscriptionListModel4.dispose();
    subscriptionListModel5.dispose();
    subscriptionListModel6.dispose();
    subscriptionListModel7.dispose();
    subscriptionListModel8.dispose();
  }
}
