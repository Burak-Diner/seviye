import '../models/question.dart';

class TestViewModel {
  final List<Question> questions;
  final List<List<int>> selections = [];
  int currentIndex = 0;

  TestViewModel(this.questions) {
    for (var _ in questions) {
      selections.add([]);
    }
  }

  void toggleSelection(int optionIndex) {
    final list = selections[currentIndex];
    if (list.contains(optionIndex)) {
      list.remove(optionIndex);
    } else {
      list.add(optionIndex);
    }
  }

  bool isSelected(int optionIndex) {
    return selections[currentIndex].contains(optionIndex);
  }

  bool get isLastQuestion => currentIndex == questions.length - 1;

  double computeScore() {
    int total = 0;
    for (var answerIndices in selections) {
      if (answerIndices.isEmpty) continue;
      // sum point values (1..4) per selected option
      total += answerIndices.fold(0, (p, e) => p + (e + 1));
    }
    int maxScore = questions.length * 4;
    return (total / maxScore) * 10;
  }
}
