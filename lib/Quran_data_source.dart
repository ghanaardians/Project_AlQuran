import 'basenetwork.dart';

class QuranDataSource {
  static QuranDataSource instance = QuranDataSource();
  Future<Map<String, dynamic>> loadQuran() {
    return BaseNetwork.get("surah");
  }
}
