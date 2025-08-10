import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/medicine_controller.dart';
import '../widgets/image_picker_section.dart';
import '../widgets/image_display_section.dart';
import '../widgets/analysis_result_section.dart';
import '../widgets/loading_section.dart';
import '../widgets/warning_section.dart';

class MedicineAnalyzerView extends StatelessWidget {
  const MedicineAnalyzerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('محلل الأدوية الذكي'),
        centerTitle: true,
        actions: [
          Consumer<MedicineController>(
            builder: (context, controller, child) {
              if (controller.hasImage || controller.hasAnalysis) {
                return IconButton(
                  onPressed: controller.clearResults,
                  icon: const Icon(Icons.clear),
                  tooltip: 'مسح النتائج',
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer<MedicineController>(
        builder: (context, controller, child) {
          // عرض رسالة الخطأ إذا وجدت
          if (controller.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showErrorDialog(context, controller.errorMessage!);
              controller.clearError();
            });
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const ImagePickerSection(),
                const SizedBox(height: 16),
                if (controller.hasImage) ...[
                  const ImageDisplaySection(),
                  const SizedBox(height: 16),
                ],
                if (controller.isLoading) ...[
                  const LoadingSection(),
                  const SizedBox(height: 16),
                ],
                if (controller.hasAnalysis) ...[
                  const AnalysisResultSection(),
                  const SizedBox(height: 16),
                ],
                const WarningSection(),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('خطأ'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('موافق'),
          ),
        ],
      ),
    );
  }
}
