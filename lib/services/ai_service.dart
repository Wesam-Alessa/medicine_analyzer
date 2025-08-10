import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AIService {
  static const String _apiKey = 'YOUR API KEY';

  Future<String> analyzeImage(Uint8List imageBytes) async {
    try {
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: _apiKey);

      const prompt = 'قم بتحليل هذه الصورة للدواء وقدم معلومات شاملة باللغة العربية تتضمن اسم الدواء والاستخدامات وطريقة الاستعمال والآثار الجانبية والتحذيرات';

      final content = [
        Content.multi([TextPart(prompt), DataPart('image/jpeg', imageBytes)]),
      ];

      final response = await model.generateContent(content);

      return response.text ?? 'لم أتمكن من تحليل الصورة';
    } catch (e) {
      throw Exception('فشل في تحليل الصورة: \$e');
    }
  }
}
