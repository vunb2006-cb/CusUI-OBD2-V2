import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_texts.dart';

class LocaleProvider extends ChangeNotifier {
  String _currentLang = 'vi';

  String get currentLang => _currentLang;
  bool get isVietnamese => _currentLang == 'vi';

  LocaleProvider() {
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString('app_locale');
      if (saved != null && AppTexts.supportedLanguages.contains(saved)) {
        _currentLang = saved;
        AppTexts.setLocale(saved);
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Lỗi tải ngôn ngữ: $e');
    }
  }

  Future<void> setLocale(String langCode) async {
    if (!AppTexts.supportedLanguages.contains(langCode)) return;
    _currentLang = langCode;
    AppTexts.setLocale(langCode);
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('app_locale', langCode);
    } catch (e) {
      debugPrint('Lỗi lưu ngôn ngữ: $e');
    }
  }

  String t(String key) => AppTexts.t(key);
}
