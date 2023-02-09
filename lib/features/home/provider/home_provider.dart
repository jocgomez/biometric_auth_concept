import 'package:biometric_auth_concept/features/login/login.dart';
import 'package:biometric_auth_concept/global/session_provider.dart';
import 'package:biometric_auth_concept/utils/biometric_auth_util.dart';
import 'package:flutter/material.dart';

class HomeNotifier with ChangeNotifier {
  late BiometricAuthUtil _biometricAuthUtil;
  late SessionNotifier _sessionNotifier;

  bool supportBiometric = false;
  bool hasBiometricEnable = false;

  /// Se inicializan las variables de control que permiten mostrar en pantalla
  /// la opcion para habilitar/deshabilitar y su estado actual
  HomeNotifier(
    BuildContext context, {
    required BiometricAuthUtil biometricAuthUtil,
  }) {
    _sessionNotifier = context.read<SessionNotifier>();
    _biometricAuthUtil = biometricAuthUtil;

    _biometricAuthUtil.isBiometricSupported().then((value) {
      supportBiometric = value;
      notifyListeners();
    });
    _biometricAuthUtil.hasEnabledBiometricAuth().then((value) {
      hasBiometricEnable = value;
      notifyListeners();
    });
  }

  /// Se encarga de habilitar/deshabilitar la autenticacion biometrica
  void handleBiometricAuth() {
    if (hasBiometricEnable) {
      _biometricAuthUtil.disableBiometricAuth();
      hasBiometricEnable = false;
    } else {
      String username = _sessionNotifier.username;
      String password = _sessionNotifier.password;

      if (username.isNotEmpty && password.isNotEmpty) {
        _biometricAuthUtil.enableBiometricAuth(username, password);
        hasBiometricEnable = true;
      }
    }
    notifyListeners();
  }

  /// Cierra la sesion
  void logOutAction(BuildContext context) {
    /// Se eliminan las credenciales almacenadas temporalmente
    _sessionNotifier.updateCredentials('', '');
    Navigator.pushReplacement(context, LoginPage.route());
  }
}
