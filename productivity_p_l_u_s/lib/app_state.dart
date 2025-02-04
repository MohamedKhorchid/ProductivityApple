import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _userID = prefs.getString('ff_userID') ?? _userID;
    });
    _safeInit(() {
      _isDarkMode = prefs.getBool('ff_isDarkMode') ?? _isDarkMode;
    });
    _safeInit(() {
      _lastTimeNoteTodo = prefs.containsKey('ff_lastTimeNoteTodo')
          ? DateTime.fromMillisecondsSinceEpoch(
              prefs.getInt('ff_lastTimeNoteTodo')!)
          : _lastTimeNoteTodo;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _userID = '';
  String get userID => _userID;
  set userID(String value) {
    _userID = value;
    prefs.setString('ff_userID', value);
  }

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  set isDarkMode(bool value) {
    _isDarkMode = value;
    prefs.setBool('ff_isDarkMode', value);
  }

  DateTime? _lastTimeNoteTodo;
  DateTime? get lastTimeNoteTodo => _lastTimeNoteTodo;
  set lastTimeNoteTodo(DateTime? value) {
    _lastTimeNoteTodo = value;
    value != null
        ? prefs.setInt('ff_lastTimeNoteTodo', value.millisecondsSinceEpoch)
        : prefs.remove('ff_lastTimeNoteTodo');
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
