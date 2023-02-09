import 'package:biometric_auth_concept/utils/biometric_auth_util.dart';
import 'package:flutter/material.dart';
import 'package:biometric_auth_concept/features/home/provider/provider.dart';
import 'package:biometric_auth_concept/features/home/widgets/home_body.dart';

/// {@template home_page}
/// A description for HomePage
/// {@endtemplate}
class HomePage extends StatelessWidget {
  /// {@macro home_page}
  const HomePage({super.key});

  /// The static route for HomePage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeNotifier(
        context,
        biometricAuthUtil: BiometricAuthUtil(),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: const HomeView(),
      ),
    );
  }
}

/// {@template home_view}
/// Displays the Body of HomeView
/// {@endtemplate}
class HomeView extends StatelessWidget {
  /// {@macro home_view}
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeBody();
  }
}
