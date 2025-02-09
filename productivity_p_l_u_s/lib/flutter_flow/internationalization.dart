import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['fr', 'en', 'es'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? frText = '',
    String? enText = '',
    String? esText = '',
  }) =>
      [frText, enText, esText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // PageAccueil
  {
    'xfjxt5wm': {
      'fr': 'Aujourd\'hui...',
      'en': 'Today...',
      'es': 'Hoy...',
    },
    'n2ty6bht': {
      'fr': 'Progression du jour',
      'en': 'Progress of the day',
      'es': 'Progreso del día',
    },
    '9x9bftcy': {
      'fr': '',
      'en': '',
      'es': '',
    },
    'hy8dtv3v': {
      'fr': 'Tâches du jour',
      'en': 'Today\'s tasks',
      'es': 'Tareas de hoy',
    },
    '2nx23pl7': {
      'fr': 'A effectuer le ',
      'en': 'To be carried out on',
      'es': 'Para llevarse a cabo el',
    },
    '63b0zxl3': {
      'fr': ' à ',
      'en': 'has',
      'es': 'tiene',
    },
    '9uaot6ik': {
      'fr': 'Terminées',
      'en': 'Completed',
      'es': 'Terminado',
    },
    'ouesz96l': {
      'fr': 'A effectuer le ',
      'en': 'To be carried out on',
      'es': 'Para llevarse a cabo el',
    },
    '6oj012cq': {
      'fr': ' à ',
      'en': 'has',
      'es': 'tiene',
    },
  },
  // GestionTache
  {
    'cds9fzkg': {
      'fr': 'Nouvelle Tâche',
      'en': 'New Task',
      'es': 'Nueva tarea',
    },
    'o1vmluq1': {
      'fr': 'Détails de la tâche',
      'en': 'Task details',
      'es': 'Detalles de la tarea',
    },
    'c30a9lhv': {
      'fr': 'Ajoutez un titre, une description ou les deux (obligatoire)',
      'en': 'Add a title, description, or both (required)',
      'es': 'Agregue un título, una descripción o ambos (obligatorio)',
    },
    '9c9msy3f': {
      'fr': 'Titre de la tâche',
      'en': 'Task Title',
      'es': 'Título de la tarea',
    },
    'g6njlfs2': {
      'fr': 'Description',
      'en': 'Description',
      'es': 'Descripción',
    },
    'h8sx47ka': {
      'fr': 'Date et Heure',
      'en': 'Date and Time',
      'es': 'Fecha y hora',
    },
    'mvfqwnkp': {
      'fr': 'Choisissez un jour et une heure (obligatoire)',
      'en': 'Choose a day and time (required)',
      'es': 'Elija un día y hora (obligatorio)',
    },
    '964br6kd': {
      'fr': 'Sélectionner',
      'en': 'Select',
      'es': 'Seleccionar',
    },
    'eqpcanhy': {
      'fr': 'Date et heure',
      'en': 'Date and time',
      'es': 'Fecha y hora',
    },
    'f6r56f37': {
      'fr': 'Catégorie',
      'en': 'Category',
      'es': 'Categoría',
    },
    '32ynmbv3': {
      'fr': 'Choisissez une catégorie (facultatif)',
      'en': 'Choose a category (optional)',
      'es': 'Elija una categoría (opcional)',
    },
    'xlcta7zr': {
      'fr': 'Travail',
      'en': 'Work',
      'es': 'Trabajar',
    },
    'nl3p98i6': {
      'fr': 'Personnel',
      'en': 'Staff',
      'es': 'Personal',
    },
    '3oyr85nw': {
      'fr': 'Santé',
      'en': 'Health',
      'es': 'Salud',
    },
    'umsfc4j8': {
      'fr': 'Loisirs',
      'en': 'Hobbies',
      'es': 'Pasatiempos',
    },
    'l6pc01lh': {
      'fr': 'Études',
      'en': 'Studies',
      'es': 'Estudios',
    },
    'ql7ckgaq': {
      'fr': 'Autre',
      'en': 'Other',
      'es': 'Otro',
    },
    '08tnykub': {
      'fr': 'Créer la tâche',
      'en': 'Create the task',
      'es': 'Crear la tarea',
    },
  },
  // updateTask
  {
    'vr73um1x': {
      'fr': 'Modifier la Tâche',
      'en': 'Edit Task',
      'es': 'Editar tarea',
    },
    'xyzxjk0j': {
      'fr': 'Détails de la tâche',
      'en': 'Task details',
      'es': 'Detalles de la tarea',
    },
    'lusjeny8': {
      'fr': 'Modifiez le titre ou la description',
      'en': 'Edit the title or description',
      'es': 'Editar el título o la descripción',
    },
    'rkpronjw': {
      'fr': 'Titre de la tâche',
      'en': 'Task Title',
      'es': 'Título de la tarea',
    },
    '0myvcxes': {
      'fr': 'Description',
      'en': 'Description',
      'es': 'Descripción',
    },
    'lgqosowt': {
      'fr': 'Catégorie',
      'en': 'Category',
      'es': 'Categoría',
    },
    '54w2kv9j': {
      'fr': 'Modifiez la catégorie',
      'en': 'Change the category',
      'es': 'Cambiar la categoría',
    },
    'kj636uqz': {
      'fr': 'Travail',
      'en': 'Work',
      'es': 'Trabajar',
    },
    'bjffldql': {
      'fr': 'Personnel',
      'en': 'Staff',
      'es': 'Personal',
    },
    'jh4okrsr': {
      'fr': 'Santé',
      'en': 'Health',
      'es': 'Salud',
    },
    'bl3pmw7c': {
      'fr': 'Loisirs',
      'en': 'Hobbies',
      'es': 'Pasatiempos',
    },
    '1fl1jcmt': {
      'fr': 'Études',
      'en': 'Studies',
      'es': 'Estudios',
    },
    'oq7cshh0': {
      'fr': 'Autre',
      'en': 'Other',
      'es': 'Otro',
    },
    't9rgfni7': {
      'fr': 'Enregistrer les modifications',
      'en': 'Save changes',
      'es': 'Guardar cambios',
    },
  },
  // notationPage
  {
    'vte30x0s': {
      'fr': 'Vous aimez To-Do List Minimaliste ?',
      'en': 'Do you like Minimalist To-Do List?',
      'es': '¿Te gusta la lista de tareas minimalista?',
    },
    'ymkb6dt5': {
      'fr':
          'Si vous appréciez notre application, prenez un instant pour la noter. Votre avis compte et nous aide à améliorer ce projet !',
      'en':
          'If you like our app, please take a moment to rate it. Your feedback matters and helps us improve this project!',
      'es':
          'Si te gusta nuestra aplicación, tómate un momento para calificarla. ¡Tu opinión importa y nos ayuda a mejorar este proyecto!',
    },
    'pel4xhu8': {
      'fr': 'Noter sur l\'App Store',
      'en': 'Rate on the App Store',
      'es': 'Calificar en la App Store',
    },
  },
  // Miscellaneous
  {
    'h5bpneat': {
      'fr': '',
      'en': '',
      'es': '',
    },
    'im9m9x4f': {
      'fr': '',
      'en': '',
      'es': '',
    },
    'if2s9a93': {
      'fr': '',
      'en': '',
      'es': '',
    },
    'an030cmp': {
      'fr': '',
      'en': '',
      'es': '',
    },
    'b65gosnp': {
      'fr': '',
      'en': '',
      'es': '',
    },
    'q7pn9ktq': {
      'fr': '',
      'en': '',
      'es': '',
    },
    '9jqc8383': {
      'fr': '',
      'en': '',
      'es': '',
    },
    'an2yyxnl': {
      'fr': '',
      'en': '',
      'es': '',
    },
    'ar1jal9s': {
      'fr': '',
      'en': '',
      'es': '',
    },
    'zs93lqkd': {
      'fr': '',
      'en': '',
      'es': '',
    },
    'rcu2ssfe': {
      'fr': '',
      'en': '',
      'es': '',
    },
    'jvndmpis': {
      'fr': '',
      'en': '',
      'es': '',
    },
    'upeurinv': {
      'fr': '',
      'en': '',
      'es': '',
    },
    'tfr9wmvb': {
      'fr': '',
      'en': '',
      'es': '',
    },
    '5bcq8ybi': {
      'fr': '',
      'en': '',
      'es': '',
    },
    'z5bvy4s6': {
      'fr': '',
      'en': '',
      'es': '',
    },
    'tn1wu4xf': {
      'fr': '',
      'en': '',
      'es': '',
    },
    '6a7ho7pz': {
      'fr': '',
      'en': '',
      'es': '',
    },
    '1nuw7gvf': {
      'fr': '',
      'en': '',
      'es': '',
    },
    'ptq795ba': {
      'fr': '',
      'en': '',
      'es': '',
    },
    '1b3kcibt': {
      'fr': '',
      'en': '',
      'es': '',
    },
    'hb8sctby': {
      'fr': '',
      'en': '',
      'es': '',
    },
    'ipar6p40': {
      'fr': '',
      'en': '',
      'es': '',
    },
    'a83uqkf2': {
      'fr': '',
      'en': '',
      'es': '',
    },
    'wwythqu4': {
      'fr': '',
      'en': '',
      'es': '',
    },
  },
].reduce((a, b) => a..addAll(b));
