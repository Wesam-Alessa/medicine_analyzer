import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/medicine_controller.dart';

class ImageDisplaySection extends StatelessWidget {
  const ImageDisplaySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'الصورة المختارة',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Consumer<MedicineController>(
                builder: (context, controller, child) {
                  return _buildImageDisplay(controller);
                },
              ),
            ),
            const SizedBox(height: 16),
            Consumer<MedicineController>(
              builder: (context, controller, child) {
                return ElevatedButton.icon(
                  onPressed: controller.isLoading ? null : controller.analyzeImage,
                  icon: const Icon(Icons.analytics),
                  label: const Text('تحليل الدواء'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageDisplay(MedicineController controller) {
    if (kIsWeb && controller.imageBytes != null) {
      return Image.memory(
        Uint8List.fromList(controller.imageBytes!),
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else if (!kIsWeb && controller.imagePath != null) {
      return Image.file(
        File(controller.imagePath!),
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }

    return const SizedBox.shrink();
  }
}
