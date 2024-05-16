import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/subscriptions_list_empty/subscriptions_list_empty_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'subscription_list_model.dart';
export 'subscription_list_model.dart';

class SubscriptionListWidget extends StatefulWidget {
  const SubscriptionListWidget({
    super.key,
    this.categoryFilter,
    this.isSharedFilter,
    this.renewalTypeFilter,
  });

  final SubscriptionCategory? categoryFilter;
  final bool? isSharedFilter;
  final RenewalType? renewalTypeFilter;

  @override
  State<SubscriptionListWidget> createState() => _SubscriptionListWidgetState();
}

class _SubscriptionListWidgetState extends State<SubscriptionListWidget> {
  late SubscriptionListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SubscriptionListModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // `categoryFilter` is used to show only the subscriptions whose category exactly matches the given string. If null, no filter is applied.
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
            child: PagedListView<DocumentSnapshot<Object?>?,
                SubscriptionsRecord>.separated(
              pagingController: _model.setListViewController(
                SubscriptionsRecord.collection
                    .where(
                      'user',
                      isEqualTo: currentUserReference,
                    )
                    .where(
                      'category',
                      isEqualTo: widget.categoryFilter?.serialize(),
                    )
                    .where(
                      'renewal',
                      isEqualTo: widget.renewalTypeFilter?.serialize(),
                    )
                    .where(
                      'is_shared',
                      isEqualTo: widget.isSharedFilter,
                    ),
              ),
              padding: EdgeInsets.symmetric(vertical: 4.0),
              shrinkWrap: true,
              reverse: false,
              scrollDirection: Axis.vertical,
              separatorBuilder: (_, __) => SizedBox(height: 4.0),
              builderDelegate: PagedChildBuilderDelegate<SubscriptionsRecord>(
                // Customize what your widget looks like when it's loading the first page.
                firstPageProgressIndicatorBuilder: (_) => Center(
                  child: SizedBox(
                    width: 40.0,
                    height: 40.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                ),
                // Customize what your widget looks like when it's loading another page.
                newPageProgressIndicatorBuilder: (_) => Center(
                  child: SizedBox(
                    width: 40.0,
                    height: 40.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                ),
                noItemsFoundIndicatorBuilder: (_) => Center(
                  child: SubscriptionsListEmptyWidget(),
                ),
                itemBuilder: (context, _, listViewIndex) {
                  final listViewSubscriptionsRecord =
                      _model.listViewPagingController!.itemList![listViewIndex];
                  return InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.pushNamed(
                        'editSubscription',
                        queryParameters: {
                          'subscription': serializeParam(
                            listViewSubscriptionsRecord,
                            ParamType.Document,
                          ),
                        }.withoutNulls,
                        extra: <String, dynamic>{
                          'subscription': listViewSubscriptionsRecord,
                        },
                      );
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.92,
                      height: 70.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            children: [
                              if (listViewSubscriptionsRecord.iconUrl != null &&
                                  listViewSubscriptionsRecord.iconUrl != '')
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    listViewSubscriptionsRecord.iconUrl,
                                    width: 50.0,
                                    height: 50.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              if (listViewSubscriptionsRecord.iconUrl == null ||
                                  listViewSubscriptionsRecord.iconUrl == '')
                                Icon(
                                  Icons.payments_outlined,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 28.0,
                                ),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      listViewSubscriptionsRecord.name
                                          .maybeHandleOverflow(
                                        maxChars: 20,
                                        replacement: '…',
                                      ),
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .override(
                                            fontFamily: 'Lexend',
                                            letterSpacing: 0.0,
                                          ),
                                      minFontSize: 16.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 2.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 4.0, 0.0, 0.0),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'qvf88vhv' /* Renews  */,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Lexend',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        fontSize: 10.0,
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 4.0, 0.0, 0.0),
                                            child: Text(
                                              dateTimeFormat(
                                                'd/M',
                                                listViewSubscriptionsRecord
                                                    .date!,
                                                locale:
                                                    FFLocalizations.of(context)
                                                        .languageCode,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Lexend',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        fontSize: 10.0,
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (listViewSubscriptionsRecord.isShared)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 10.0, 0.0),
                                    child: Icon(
                                      Icons.groups_sharp,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 28.0,
                                    ),
                                  ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 6.0, 0.0),
                                  child: Text(
                                    formatNumber(
                                      listViewSubscriptionsRecord.amount,
                                      formatType: FormatType.decimal,
                                      decimalType: DecimalType.automatic,
                                      currency: '€',
                                    ),
                                    textAlign: TextAlign.end,
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Lexend',
                                          color: FlutterFlowTheme.of(context)
                                              .tertiary,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right_outlined,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 28.0,
                                ),
                              ],
                            ),
                          ),
                        ].addToStart(SizedBox(width: 8.0)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
