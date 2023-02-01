import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUtils {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  /// Obtiene el valor del almacenamiento seguro a partir de una llave
  Future<String?> getValue(String key) async {
    return await _storage.read(key: key);
  }

  /// Asigna un valor a la llave correspondiente en el almacenamiento seguro
  Future<void> setValue(String key, String value) async {
    return _storage.write(key: key, value: value);
  }

  /// Elimina el valor de la clave definida en el almacenamiento seguro
  Future<void> deleteValue(String key) async {
    return _storage.delete(key: key);
  }
}
