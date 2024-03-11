import 'package:flutter/material.dart';
import 'package:patient_management_app/data/shared/shared_prefernce.dart';
import 'package:patient_management_app/screen/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Shared().loadPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(006837),
        ),
        useMaterial3: false,
      ),
      home: const LoginScreen(),
    );
  }
}
