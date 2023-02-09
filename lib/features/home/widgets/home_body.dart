import 'package:flutter/material.dart';
import 'package:biometric_auth_concept/features/home/provider/provider.dart';

/// {@template home_body}
/// Body of the HomePage.
///
/// Add what it does
/// {@endtemplate}
class HomeBody extends StatelessWidget {
  /// {@macro home_body}
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeNotifier>(
      builder: (context, state, child) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state.supportBiometric)
                ElevatedButton(
                  onPressed: state.handleBiometricAuth,
                  child: Text(
                    '${state.hasBiometricEnable ? 'Deshabilitar' : 'Habilitar'} autenticación biométrica',
                  ),
                ),
              ElevatedButton(
                onPressed: () => state.logOutAction(context),
                child: const Text('Cerrar sesión'),
              ),
            ],
          ),
        );
      },
    );
  }
}
