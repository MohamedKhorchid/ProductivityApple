import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_ad_banner.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'page_accueil_widget.dart' show PageAccueilWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class PageAccueilModel extends FlutterFlowModel<PageAccueilWidget> {
  ///  Local state fields for this page.

  int completedTasks = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in PageAccueil widget.
  List<TasksRecord>? complete;
  // State field(s) for Switch widget.
  bool? switchValue;
  List<TasksRecord>? listViewPreviousSnapshot1;
  // State field(s) for Checkbox widget.
  Map<TasksRecord, bool> checkboxValueMap1 = {};
  List<TasksRecord> get checkboxCheckedItems1 => checkboxValueMap1.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

  List<TasksRecord>? listViewPreviousSnapshot2;
  // State field(s) for Checkbox widget.
  Map<TasksRecord, bool> checkboxValueMap2 = {};
  List<TasksRecord> get checkboxCheckedItems2 => checkboxValueMap2.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
