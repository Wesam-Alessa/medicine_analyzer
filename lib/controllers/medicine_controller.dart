import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../models/medicine_analysis_model.dart';
import '../services/ai_service.dart';

class MedicineController extends ChangeNotifier {
  MedicineAnalysisModel _model = const MedicineAnalysisModel();
  final ImagePicker _picker = ImagePicker();
  final AIService _aiService = AIService();

  MedicineAnalysisModel get model => _model;

  bool get isLoading => _model.isLoading;
  bool get hasImage => _model.hasImage;
  bool get hasAnalysis => _model.hasAnalysis;
  bool get hasError => _model.hasError;
  String? get imagePath => _model.imagePath;
  List<int>? get imageBytes => _model.imageBytes;
  String? get analysisResult => _model.analysisResult;
  String? get errorMessage => _model.errorMessage;

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (image != null) {
        await _handleImageSelection(image);
      }
    } catch (e) {
      _setError('خطأ في التقاط الصورة: \$e');
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) {
        await _handleImageSelection(image);
      }
    } catch (e) {
      _setError('خطأ في اختيار الصورة: \$e');
    }
  }

  Future<void> _handleImageSelection(XFile image) async {
    try {
      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        _model = _model.copyWith(
          imageBytes: bytes,
          imagePath: null,
          analysisResult: null,
          errorMessage: null,
        );
      } else {
        _model = _model.copyWith(
          imagePath: image.path,
          imageBytes: null,
          analysisResult: null,
          errorMessage: null,
        );
      }
      notifyListeners();
    } catch (e) {
      _setError('خطأ في معالجة الصورة: \$e');
    }
  }

  Future<void> analyzeImage() async {
    if (!_model.hasImage) {
      _setError('يرجى اختيار صورة أولاً');
      return;
    }

    _setLoading(true);

    try {
      late Uint8List imageBytes;

      if (kIsWeb && _model.imageBytes != null) {
        imageBytes = Uint8List.fromList(_model.imageBytes!);
      } else if (_model.imagePath != null) {
        final file = XFile(_model.imagePath!);
        imageBytes = await file.readAsBytes();
      } else {
        throw Exception('لا توجد صورة للتحليل');
      }

      final result = await _aiService.analyzeImage(imageBytes);

      _model = _model.copyWith(
        analysisResult: result,
        isLoading: false,
        errorMessage: null,
      );
      notifyListeners();
    } catch (e) {
      _setLoading(false);
      if (e.toString().contains('API_KEY')) {
        _setError('يرجى إضافة مفتاح API صحيح في الكود');
      } else {
        _setError('خطأ في تحليل الصورة: \$e');
      }
    }
  }

  void clearResults() {
    _model = _model.clearData();
    notifyListeners();
  }

  void clearError() {
    _model = _model.copyWith(errorMessage: null);
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _model = _model.copyWith(isLoading: loading);
    notifyListeners();
  }

  void _setError(String error) {
    _model = _model.copyWith(
      errorMessage: error,
      isLoading: false,
    );
    notifyListeners();
  }
}
