import '/backend/schema/enums/enums.dart';
import '/components/subscription_list/subscription_list_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'subscription_widget.dart' show SubscriptionWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SubscriptionModel extends FlutterFlowModel<SubscriptionWidget> {
  ///  State fields for stateful widgets in this page.

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

  @override
  void initState(BuildContext context) {
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
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    subscriptionListModel1.dispose();
    subscriptionListModel2.dispose();
    subscriptionListModel3.dispose();
    subscriptionListModel4.dispose();
    subscriptionListModel5.dispose();
  }
}
