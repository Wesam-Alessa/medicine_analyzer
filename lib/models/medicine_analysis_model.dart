class MedicineAnalysisModel {
  final String? imagePath;
  final List<int>? imageBytes;
  final String? analysisResult;
  final bool isLoading;
  final String? errorMessage;

  const MedicineAnalysisModel({
    this.imagePath,
    this.imageBytes,
    this.analysisResult,
    this.isLoading = false,
    this.errorMessage,
  });

  MedicineAnalysisModel copyWith({
    String? imagePath,
    List<int>? imageBytes,
    String? analysisResult,
    bool? isLoading,
    String? errorMessage,
  }) {
    return MedicineAnalysisModel(
      imagePath: imagePath ?? this.imagePath,
      imageBytes: imageBytes ?? this.imageBytes,
      analysisResult: analysisResult ?? this.analysisResult,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  MedicineAnalysisModel clearData() {
    return const MedicineAnalysisModel();
  }

  bool get hasImage => imagePath != null || imageBytes != null;
  bool get hasAnalysis => analysisResult != null && analysisResult!.isNotEmpty;
  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;
}
