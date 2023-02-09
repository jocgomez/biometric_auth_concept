import 'package:flutter/material.dart';
import 'package:biometric_auth_concept/features/login/provider/provider.dart';

/// {@template login_body}
/// Body of the LoginPage.
///
/// Add what it does
/// {@endtemplate}
class LoginBody extends StatelessWidget {
  /// {@macro login_body}
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(
      builder: (context, state, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Inicio de sesion'),
                const SizedBox(height: 32),
                Form(
                  key: state.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: state.usernameCtrl,
                        validator: state.validateField,
                        decoration: const InputDecoration(
                          labelText: 'Usuario',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: state.passwordCtrl,
                        validator: state.validateField,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Contraseña',
                          border: OutlineInputBorder(),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: state.isLoading
                      ? () {}
                      : () => state.handlelogin(context),
                  child: state.isLoading
                      ? const CircularProgressIndicator.adaptive()
                      : const Text('Iniciar sesión'),
                ),
                if (state.supportBiometric && state.hasBiometricEnable)
                  ElevatedButton(
                    onPressed: state.isLoading
                        ? () {}
                        : () => state.biometricAuth(context),
                    child: state.isLoading
                        ? const CircularProgressIndicator.adaptive()
                        : const Text('Inicio biométrico'),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
