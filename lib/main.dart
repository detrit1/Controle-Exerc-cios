import 'package:flutter/material.dart';
import 'pages/intro_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recordes de Treino',

      // 🔥 AGORA A TELA INICIAL É CHAMADA DIRETAMENTE
      home: const IntroPage(),

      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFA600),
          brightness: Brightness.dark,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Color(0xFFFFA600)),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(const Color(0xFFFFA600)),
            foregroundColor: WidgetStateProperty.all(Colors.black),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1E1E1E),
          labelStyle: const TextStyle(color: Color(0xFFFFA600)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFFFA600)),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFFFA600),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
