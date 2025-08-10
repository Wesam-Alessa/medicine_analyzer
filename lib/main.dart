import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/medicine_controller.dart';
import 'views/medicine_analyzer_view.dart';

void main() {
  runApp(const MedicineAnalyzerApp());
}

class MedicineAnalyzerApp extends StatelessWidget {
  const MedicineAnalyzerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MedicineController(),
      child: MaterialApp(
        title: 'محلل الأدوية الذكي',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Cairo',
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        home: const MedicineAnalyzerView(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
