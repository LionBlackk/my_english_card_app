import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_english_card_app/pages/lading_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: LandingPage());
  }
}
