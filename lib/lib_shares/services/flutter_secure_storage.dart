// ignore_for_file: constant_identifier_names
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageService {
  //+ Constructor nombrado
  FlutterSecureStorageService._internal();

  //+ Instancia única de la clase
  static final FlutterSecureStorageService _flutterSecureStorageService =
      FlutterSecureStorageService._internal();

  //+ Getter para la instancia única
  static FlutterSecureStorageService get flutterSecureStorageService =>
      _flutterSecureStorageService;

  //+ Guardar información
  Future<void> saveData(String key, String val) async {
    const secureStorage = FlutterSecureStorage();
    await secureStorage.write(key: key, value: val);
  }

  //+ Obtener información
  Future<String?> getData(String key) async {
    const secureStorage = FlutterSecureStorage();
    return await secureStorage.read(key: key);
  }
}
