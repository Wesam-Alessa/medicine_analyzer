import 'package:flutter/material.dart';

class WarningSection extends StatelessWidget {
  const WarningSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(Icons.warning, color: Colors.orange, size: 32),
            const SizedBox(height: 8),
            const Text(
              'تحذير مهم',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'هذا التطبيق للأغراض التعليمية فقط ولا يغني عن استشارة الطبيب المختص. يجب عليك دائماً مراجعة الطبيب أو الصيدلي قبل تناول أي دواء.',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
