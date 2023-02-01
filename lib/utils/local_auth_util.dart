import 'package:local_auth/local_auth.dart';

class LocalAuthUtil {
  final LocalAuthentication auth = LocalAuthentication();

  /// Verifica si el dispositivo soporta biometria
  Future<bool> deviceSupportBiometric() async {
    return await auth.isDeviceSupported();
  }

  /// Verifica si el dispositivo tiene configurado información biométrica
  Future<bool> canCheckBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  /// Obtiene la lista de opciones biometricas para usar (Facial, dactilar, iris)
  Future<List<BiometricType>> getAvailableBiometrics() async {
    return await auth.getAvailableBiometrics();
  }

  /// Autenticación, valida le información biométrica con la configurada del dispositivo.
  Future<bool> authenticate() async {
    try {
      return await auth.authenticate(
        localizedReason: 'Usa tu información biométrica para iniciar sesión',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }
}
