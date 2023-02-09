import 'package:biometric_auth_concept/features/home/home.dart';
import 'package:biometric_auth_concept/global/session_provider.dart';
import 'package:biometric_auth_concept/utils/biometric_auth_util.dart';
import 'package:flutter/material.dart';

class LoginNotifier with ChangeNotifier {
  late BiometricAuthUtil _biometricAuthUtil;
  late SessionNotifier _sessionNotifier;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  bool isLoading = false;
  bool supportBiometric = false;
  bool hasBiometricEnable = false;

  /// Se inicializan las variables de control que permiten mostrar en pantalla
  /// la opcion para habilitar/deshabilitar y su estado actual
  LoginNotifier(
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

  @override
  void dispose() {
    usernameCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  /// Realiza la autenticacion biométrica, si es correcta se accede a las credenciales
  /// almacenadas del secure storage para continuar con el inicio de sesion
  void biometricAuth(BuildContext context) async {
    if (hasBiometricEnable && supportBiometric) {
      if (await _biometricAuthUtil.biometricAuthenticate()) {
        String username = await _biometricAuthUtil
                .getValueFromSecureStorage(_biometricAuthUtil.usernameKey) ??
            '';
        String password = await _biometricAuthUtil
                .getValueFromSecureStorage(_biometricAuthUtil.passwordKey) ??
            '';

        if (username.isNotEmpty && password.isNotEmpty) {
          handlelogin(context, username: username, password: password);
        }
      } else {
        print('Autenticacion fallida');
      }
    } else {
      print('No es posible la autenticacion biometrica');
    }
  }

  /// Valida el campo de texto para que no esté vacío
  String? validateField(String? value) {
    String? errorMessage;
    if (value == null || value.isEmpty) {
      errorMessage = 'El campo es obligatorio';
    }
    return errorMessage;
  }

  /// Controla el inicio de sesion para validar si es por credenciales o por biometria
  /// Si recibe las credenciales, es un inicio por biometria
  void handlelogin(
    BuildContext context, {
    String username = '',
    String password = '',
  }) {
    if (username.isNotEmpty && password.isNotEmpty) {
      if (username == 'admin' && password == 'admin') {
        loginAction(context, username, password);
      }
    } else if (formKey.currentState!.validate()) {
      if (usernameCtrl.text == 'admin' && passwordCtrl.text == 'admin') {
        loginAction(context, usernameCtrl.text, passwordCtrl.text);
      }
    }
  }

  /// Se realiza el inicio de sesion, se simula una llamada a un servicio
  Future<void> loginAction(
    BuildContext context,
    String username,
    String password,
  ) async {
    isLoading = true;
    notifyListeners();

    /// Simula la llamada al servicio de autenticación
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      isLoading = true;
      notifyListeners();

      /// Se almacena temporalmente en un provider las credenciales del usuario
      _sessionNotifier.updateCredentials(username, password);
      Navigator.pushReplacement(context, HomePage.route());
    });
  }
}
