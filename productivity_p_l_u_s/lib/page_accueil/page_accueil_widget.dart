import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_ad_banner.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_language_selector.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'page_accueil_model.dart';
export 'page_accueil_model.dart';

class PageAccueilWidget extends StatefulWidget {
  const PageAccueilWidget({super.key});

  @override
  State<PageAccueilWidget> createState() => _PageAccueilWidgetState();
}

class _PageAccueilWidgetState extends State<PageAccueilWidget> {
  late PageAccueilModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PageAccueilModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().userID == null || FFAppState().userID == '') {
        FFAppState().userID = random_data.randomString(
          36,
          36,
          true,
          false,
          false,
        );
        safeSetState(() {});
      }
      _model.complete = await queryTasksRecordOnce(
        queryBuilder: (tasksRecord) => tasksRecord
            .where(
              'status',
              isEqualTo: true,
            )
            .where(
              'date',
              isGreaterThanOrEqualTo:
                  functions.getDayStart(getCurrentTimestamp),
            )
            .where(
              'date',
              isLessThanOrEqualTo: functions.getDayEnd(getCurrentTimestamp),
            )
            .where(
              'userID',
              isEqualTo: FFAppState().userID,
            ),
      );
      _model.completedTasks = _model.complete!.length;
      safeSetState(() {});
      if ((FFAppState().lastTimeNoteTodo == null) ||
          (functions.daysSince(FFAppState().lastTimeNoteTodo!) >= 8)) {
        context.pushNamed('notationPage');
      }
    });

    _model.switchValue = false;
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: Color(0xFFD090D4),
          automaticallyImplyLeading: false,
          title: Text(
            FFLocalizations.of(context).getText(
              'xfjxt5wm' /* Aujourd'hui... */,
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Inter Tight',
                  color: Colors.white,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [
            FlutterFlowIconButton(
              buttonSize: 48.0,
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.white,
                size: 24.0,
              ),
              onPressed: () async {
                context.pushNamed(
                  'GestionTache',
                  extra: <String, dynamic>{
                    kTransitionInfoKey: TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.scale,
                      alignment: Alignment.bottomCenter,
                    ),
                  },
                );
              },
            ),
            Switch.adaptive(
              value: _model.switchValue!,
              onChanged: (newValue) async {
                safeSetState(() => _model.switchValue = newValue!);
                if (newValue!) {
                  setDarkModeSetting(context, ThemeMode.dark);
                } else {
                  setDarkModeSetting(context, ThemeMode.light);
                }
              },
              activeColor: Color(0xFFB869D1),
              activeTrackColor: Color(0xFFB869D1),
              inactiveTrackColor: Colors.white,
              inactiveThumbColor: Color(0xFFB869D1),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Stack(
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Stack(
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, -1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    18.0, 0.0, 18.0, 0.0),
                                child: SingleChildScrollView(
                                  primary: false,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FlutterFlowAdBanner(
                                        width: 320.0,
                                        height: 50.0,
                                        showsTestAd: false,
                                        iOSAdUnitID:
                                            'ca-app-pub-5902757634604822/3838914525',
                                        androidAdUnitID:
                                            'ca-app-pub-5902757634604822/4090649246',
                                      ),
                                      FlutterFlowLanguageSelector(
                                        width: 200.0,
                                        height: 40.0,
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                        borderColor: Colors.transparent,
                                        dropdownIconColor: Colors.white,
                                        borderRadius: 8.0,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                        hideFlags: false,
                                        flagSize: 24.0,
                                        flagTextGap: 8.0,
                                        currentLanguage:
                                            FFLocalizations.of(context)
                                                .languageCode,
                                        languages: FFLocalizations.languages(),
                                        onChanged: (lang) =>
                                            setAppLanguage(context, lang),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4.0, 0.0, 4.0, 0.0),
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 2.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 20.0, 20.0, 20.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'n2ty6bht' /* Progression du jour */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter Tight',
                                                                  fontSize:
                                                                      24.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                          StreamBuilder<
                                                              List<
                                                                  TasksRecord>>(
                                                            stream:
                                                                queryTasksRecord(
                                                              queryBuilder:
                                                                  (tasksRecord) =>
                                                                      tasksRecord
                                                                          .where(
                                                                            'date',
                                                                            isGreaterThanOrEqualTo:
                                                                                functions.getDayStart(getCurrentTimestamp),
                                                                          )
                                                                          .where(
                                                                            'date',
                                                                            isLessThanOrEqualTo:
                                                                                functions.getDayEnd(getCurrentTimestamp),
                                                                          )
                                                                          .where(
                                                                            'userID',
                                                                            isEqualTo:
                                                                                FFAppState().userID,
                                                                          ),
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 50.0,
                                                                    height:
                                                                        50.0,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      valueColor:
                                                                          AlwaysStoppedAnimation<
                                                                              Color>(
                                                                        Color(
                                                                            0xFFB869D1),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              List<TasksRecord>
                                                                  textTasksRecordList =
                                                                  snapshot
                                                                      .data!;

                                                              return Text(
                                                                (int total,
                                                                        int
                                                                            complete) {
                                                                  return total ==
                                                                          0
                                                                      ? "Aucune tâche pour aujourd'hui"
                                                                      : (complete / total) <=
                                                                              0
                                                                          ? "Réalisez une tâche simple"
                                                                          : (complete / total) <= 0.25
                                                                              ? "Un quart déjà complété !"
                                                                              : (complete / total) <= 0.5
                                                                                  ? "Vous êtes à mi-chemin !"
                                                                                  : (complete / total) <= 0.75
                                                                                      ? "Presque terminé !"
                                                                                      : "C'est parfait !";
                                                                }(
                                                                    textTasksRecordList
                                                                        .length,
                                                                    _model
                                                                        .completedTasks),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Inter',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        width: 60.0,
                                                        height: 60.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFB869D1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: StreamBuilder<
                                                                List<
                                                                    TasksRecord>>(
                                                              stream:
                                                                  queryTasksRecord(
                                                                queryBuilder: (tasksRecord) =>
                                                                    tasksRecord
                                                                        .where(
                                                                          'date',
                                                                          isGreaterThanOrEqualTo:
                                                                              functions.getDayStart(getCurrentTimestamp),
                                                                        )
                                                                        .where(
                                                                          'date',
                                                                          isLessThanOrEqualTo:
                                                                              functions.getDayEnd(getCurrentTimestamp),
                                                                        )
                                                                        .where(
                                                                          'userID',
                                                                          isEqualTo:
                                                                              FFAppState().userID,
                                                                        ),
                                                              ),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          50.0,
                                                                      height:
                                                                          50.0,
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        valueColor:
                                                                            AlwaysStoppedAnimation<Color>(
                                                                          Color(
                                                                              0xFFB869D1),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<TasksRecord>
                                                                    textTasksRecordList =
                                                                    snapshot
                                                                        .data!;

                                                                return Text(
                                                                  formatNumber(
                                                                    (int total,
                                                                            int
                                                                                complete) {
                                                                      return total >
                                                                              0
                                                                          ? (complete /
                                                                              total)
                                                                          : 0.0;
                                                                    }(
                                                                        textTasksRecordList
                                                                            .length,
                                                                        _model
                                                                            .completedTasks),
                                                                    formatType:
                                                                        FormatType
                                                                            .percent,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'Inter Tight',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            14.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  StreamBuilder<
                                                      List<TasksRecord>>(
                                                    stream: queryTasksRecord(
                                                      queryBuilder:
                                                          (tasksRecord) =>
                                                              tasksRecord
                                                                  .where(
                                                                    'date',
                                                                    isGreaterThanOrEqualTo:
                                                                        functions
                                                                            .getDayStart(getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'date',
                                                                    isLessThanOrEqualTo:
                                                                        functions
                                                                            .getDayEnd(getCurrentTimestamp),
                                                                  )
                                                                  .where(
                                                                    'userID',
                                                                    isEqualTo:
                                                                        FFAppState()
                                                                            .userID,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 50.0,
                                                            height: 50.0,
                                                            child:
                                                                CircularProgressIndicator(
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                      Color>(
                                                                Color(
                                                                    0xFFB869D1),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      List<TasksRecord>
                                                          progressBarTasksRecordList =
                                                          snapshot.data!;

                                                      return LinearPercentIndicator(
                                                        percent: (int total,
                                                                int complete) {
                                                          return total > 0
                                                              ? (complete /
                                                                  total)
                                                              : 0.0;
                                                        }(
                                                            progressBarTasksRecordList
                                                                .length,
                                                            _model
                                                                .completedTasks),
                                                        lineHeight: 20.0,
                                                        animation: true,
                                                        animateFromLastPercent:
                                                            true,
                                                        progressColor:
                                                            Color(0xFFB869D1),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .accent4,
                                                        barRadius:
                                                            Radius.circular(
                                                                20.0),
                                                        padding:
                                                            EdgeInsets.zero,
                                                      );
                                                    },
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 16.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'hy8dtv3v' /* Tâches du jour */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .override(
                                              fontFamily: 'Inter Tight',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4.0, 0.0, 4.0, 0.0),
                                        child: StreamBuilder<List<TasksRecord>>(
                                          stream: queryTasksRecord(
                                            queryBuilder: (tasksRecord) =>
                                                tasksRecord
                                                    .where(
                                                      'userID',
                                                      isEqualTo:
                                                          FFAppState().userID,
                                                    )
                                                    .where(
                                                      'status',
                                                      isEqualTo: false,
                                                    )
                                                    .where(
                                                      'date',
                                                      isGreaterThanOrEqualTo:
                                                          functions.getDayStart(
                                                              getCurrentTimestamp),
                                                    )
                                                    .where(
                                                      'date',
                                                      isLessThanOrEqualTo:
                                                          functions.getDayEnd(
                                                              getCurrentTimestamp),
                                                    ),
                                          )..listen((snapshot) {
                                              List<TasksRecord>
                                                  listViewTasksRecordList =
                                                  snapshot;
                                              if (_model.listViewPreviousSnapshot1 !=
                                                      null &&
                                                  !const ListEquality(
                                                          TasksRecordDocumentEquality())
                                                      .equals(
                                                          listViewTasksRecordList,
                                                          _model
                                                              .listViewPreviousSnapshot1)) {
                                                () async {}();
                                              }
                                              _model.listViewPreviousSnapshot1 =
                                                  snapshot;
                                            }),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      Color(0xFFB869D1),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            List<TasksRecord>
                                                listViewTasksRecordList =
                                                snapshot.data!;

                                            return ListView.separated(
                                              padding: EdgeInsets.zero,
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: listViewTasksRecordList
                                                  .length,
                                              separatorBuilder: (_, __) =>
                                                  SizedBox(height: 10.0),
                                              itemBuilder:
                                                  (context, listViewIndex) {
                                                final listViewTasksRecord =
                                                    listViewTasksRecordList[
                                                        listViewIndex];
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 10.0),
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    elevation: 2.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    child: Container(
                                                      width: 100.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            14.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        await listViewTasksRecord
                                                                            .reference
                                                                            .delete();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            30.0,
                                                                        height:
                                                                            30.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          borderRadius:
                                                                              BorderRadius.circular(12.0),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            width:
                                                                                2.0,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Icon(
                                                                            Icons.delete_forever,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                18.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        context
                                                                            .pushNamed(
                                                                          'updateTask',
                                                                          queryParameters:
                                                                              {
                                                                            'titreTache':
                                                                                serializeParam(
                                                                              listViewTasksRecord.title,
                                                                              ParamType.String,
                                                                            ),
                                                                            'descriptionTache':
                                                                                serializeParam(
                                                                              listViewTasksRecord.description,
                                                                              ParamType.String,
                                                                            ),
                                                                            'categoryTache':
                                                                                serializeParam(
                                                                              listViewTasksRecord.category,
                                                                              ParamType.String,
                                                                            ),
                                                                            'refTache':
                                                                                serializeParam(
                                                                              listViewTasksRecord.reference,
                                                                              ParamType.DocumentReference,
                                                                            ),
                                                                          }.withoutNulls,
                                                                        );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            30.0,
                                                                        height:
                                                                            30.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0xFFB869D1),
                                                                          borderRadius:
                                                                              BorderRadius.circular(12.0),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Color(0xFFB869D1),
                                                                            width:
                                                                                2.0,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              FaIcon(
                                                                            FontAwesomeIcons.pencilAlt,
                                                                            color:
                                                                                Colors.white,
                                                                            size:
                                                                                18.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          10.0)),
                                                                ),
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children:
                                                                          [
                                                                        Text(
                                                                          listViewTasksRecord
                                                                              .title,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .override(
                                                                                fontFamily: 'Inter',
                                                                                fontSize: 18.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                        ),
                                                                        if (listViewTasksRecord.category !=
                                                                                null &&
                                                                            listViewTasksRecord.category !=
                                                                                '')
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              borderRadius: BorderRadius.circular(20.0),
                                                                            ),
                                                                            child:
                                                                                Align(
                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(7.0, 1.0, 7.0, 1.0),
                                                                                child: Text(
                                                                                  listViewTasksRecord.category,
                                                                                  textAlign: TextAlign.center,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'Inter',
                                                                                        color: Colors.white,
                                                                                        fontSize: 14.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                      ].divide(SizedBox(
                                                                              width: 10.0)),
                                                                    ),
                                                                    Text(
                                                                      listViewTasksRecord
                                                                          .description
                                                                          .maybeHandleOverflow(
                                                                        maxChars:
                                                                            30,
                                                                        replacement:
                                                                            '…',
                                                                      ),
                                                                      maxLines:
                                                                          3,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            '2nx23pl7' /* A effectuer le  */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                fontFamily: 'Inter',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14.0,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          dateTimeFormat(
                                                                            "d/M",
                                                                            listViewTasksRecord.date!,
                                                                            locale:
                                                                                FFLocalizations.of(context).languageCode,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Inter',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14.0,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            '63b0zxl3' /*  à  */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Inter',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          dateTimeFormat(
                                                                            "Hm",
                                                                            listViewTasksRecord.date!,
                                                                            locale:
                                                                                FFLocalizations.of(context).languageCode,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Inter',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14.0,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          5.0)),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 16.0)),
                                                            ),
                                                            Theme(
                                                              data: ThemeData(
                                                                checkboxTheme:
                                                                    CheckboxThemeData(
                                                                  visualDensity:
                                                                      VisualDensity
                                                                          .compact,
                                                                  materialTapTargetSize:
                                                                      MaterialTapTargetSize
                                                                          .shrinkWrap,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4.0),
                                                                  ),
                                                                ),
                                                                unselectedWidgetColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                              ),
                                                              child: Checkbox(
                                                                value: _model
                                                                        .checkboxValueMap1[
                                                                    listViewTasksRecord] ??= false,
                                                                onChanged:
                                                                    (newValue) async {
                                                                  safeSetState(() =>
                                                                      _model.checkboxValueMap1[
                                                                              listViewTasksRecord] =
                                                                          newValue!);
                                                                  if (newValue!) {
                                                                    await listViewTasksRecord
                                                                        .reference
                                                                        .update(
                                                                            createTasksRecordData(
                                                                      status:
                                                                          true,
                                                                    ));
                                                                    if (listViewTasksRecord
                                                                            .status ==
                                                                        true) {
                                                                      _model.completedTasks =
                                                                          _model.completedTasks +
                                                                              -1;
                                                                      safeSetState(
                                                                          () {});
                                                                    } else {
                                                                      _model.completedTasks =
                                                                          _model.completedTasks +
                                                                              1;
                                                                      safeSetState(
                                                                          () {});
                                                                    }
                                                                  }
                                                                },
                                                                side:
                                                                    BorderSide(
                                                                  width: 2,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                ),
                                                                activeColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                checkColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      FlutterFlowAdBanner(
                                        width: 320.0,
                                        height: 50.0,
                                        showsTestAd: false,
                                        iOSAdUnitID:
                                            'ca-app-pub-5902757634604822/5638818021',
                                        androidAdUnitID:
                                            'ca-app-pub-5902757634604822/1121946379',
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          '9uaot6ik' /* Terminées */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .override(
                                              fontFamily: 'Inter Tight',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4.0, 0.0, 4.0, 0.0),
                                        child: StreamBuilder<List<TasksRecord>>(
                                          stream: queryTasksRecord(
                                            queryBuilder: (tasksRecord) =>
                                                tasksRecord
                                                    .where(
                                                      'userID',
                                                      isEqualTo:
                                                          FFAppState().userID,
                                                    )
                                                    .where(
                                                      'status',
                                                      isEqualTo: true,
                                                    )
                                                    .where(
                                                      'date',
                                                      isGreaterThanOrEqualTo:
                                                          functions.getDayStart(
                                                              getCurrentTimestamp),
                                                    )
                                                    .where(
                                                      'date',
                                                      isLessThanOrEqualTo:
                                                          functions.getDayEnd(
                                                              getCurrentTimestamp),
                                                    ),
                                          )..listen((snapshot) {
                                              List<TasksRecord>
                                                  listViewTasksRecordList =
                                                  snapshot;
                                              if (_model.listViewPreviousSnapshot2 !=
                                                      null &&
                                                  !const ListEquality(
                                                          TasksRecordDocumentEquality())
                                                      .equals(
                                                          listViewTasksRecordList,
                                                          _model
                                                              .listViewPreviousSnapshot2)) {
                                                () async {}();
                                              }
                                              _model.listViewPreviousSnapshot2 =
                                                  snapshot;
                                            }),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      Color(0xFFB869D1),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            List<TasksRecord>
                                                listViewTasksRecordList =
                                                snapshot.data!;

                                            return ListView.separated(
                                              padding: EdgeInsets.zero,
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: listViewTasksRecordList
                                                  .length,
                                              separatorBuilder: (_, __) =>
                                                  SizedBox(height: 10.0),
                                              itemBuilder:
                                                  (context, listViewIndex) {
                                                final listViewTasksRecord =
                                                    listViewTasksRecordList[
                                                        listViewIndex];
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 10.0),
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    elevation: 2.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    child: Container(
                                                      width: 100.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            14.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  width: 24.0,
                                                                  height: 24.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12.0),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      width:
                                                                          2.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children:
                                                                          [
                                                                        Text(
                                                                          listViewTasksRecord
                                                                              .title,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .override(
                                                                                fontFamily: 'Inter',
                                                                                fontSize: 18.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                        ),
                                                                        if (listViewTasksRecord.category !=
                                                                                null &&
                                                                            listViewTasksRecord.category !=
                                                                                '')
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                7.0,
                                                                                0.0,
                                                                                7.0,
                                                                                0.0),
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                borderRadius: BorderRadius.circular(20.0),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(7.0, 1.0, 7.0, 1.0),
                                                                                child: Text(
                                                                                  listViewTasksRecord.category,
                                                                                  textAlign: TextAlign.center,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'Inter',
                                                                                        color: Colors.white,
                                                                                        fontSize: 14.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.normal,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                      ].divide(SizedBox(
                                                                              width: 10.0)),
                                                                    ),
                                                                    Text(
                                                                      listViewTasksRecord
                                                                          .description
                                                                          .maybeHandleOverflow(
                                                                        maxChars:
                                                                            30,
                                                                        replacement:
                                                                            '…',
                                                                      ),
                                                                      maxLines:
                                                                          3,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'ouesz96l' /* A effectuer le  */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                fontFamily: 'Inter',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14.0,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          dateTimeFormat(
                                                                            "d/M",
                                                                            listViewTasksRecord.date!,
                                                                            locale:
                                                                                FFLocalizations.of(context).languageCode,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Inter',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14.0,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            '6oj012cq' /*  à  */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Inter',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          dateTimeFormat(
                                                                            "Hm",
                                                                            listViewTasksRecord.date!,
                                                                            locale:
                                                                                FFLocalizations.of(context).languageCode,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Inter',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14.0,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          5.0)),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 16.0)),
                                                            ),
                                                            Theme(
                                                              data: ThemeData(
                                                                checkboxTheme:
                                                                    CheckboxThemeData(
                                                                  visualDensity:
                                                                      VisualDensity
                                                                          .compact,
                                                                  materialTapTargetSize:
                                                                      MaterialTapTargetSize
                                                                          .shrinkWrap,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4.0),
                                                                  ),
                                                                ),
                                                                unselectedWidgetColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                              ),
                                                              child: Checkbox(
                                                                value: _model
                                                                        .checkboxValueMap2[
                                                                    listViewTasksRecord] ??= true,
                                                                onChanged:
                                                                    listViewTasksRecord
                                                                            .status
                                                                        ? null
                                                                        : (newValue) async {
                                                                            safeSetState(() =>
                                                                                _model.checkboxValueMap2[listViewTasksRecord] = newValue!);
                                                                          },
                                                                side:
                                                                    BorderSide(
                                                                  width: 2,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                ),
                                                                activeColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      FlutterFlowAdBanner(
                                        width: 320.0,
                                        height: 50.0,
                                        showsTestAd: false,
                                        iOSAdUnitID:
                                            'ca-app-pub-5902757634604822/2472732660',
                                        androidAdUnitID:
                                            'ca-app-pub-5902757634604822/2954667134',
                                      ),
                                    ].divide(SizedBox(height: 24.0)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
