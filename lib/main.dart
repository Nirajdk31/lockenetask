import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lockenedemo/screens/registrationscreen.dart';
import 'package:provider/provider.dart';

import 'controllers/otpprovider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AccountIdHandler()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: RegistrationPage(), // Replace with your registration screen
      ),
    );
  }
}


