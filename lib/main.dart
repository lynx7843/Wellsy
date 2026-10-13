import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/create_account.dart' show SignInScreen;
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const WellsyApp());
}

class WellsyApp extends StatelessWidget {
  const WellsyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wellsy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SignInScreen(),
    );
  }
}
