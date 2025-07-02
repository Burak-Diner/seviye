import '../models/question.dart';
import '../viewmodels/test_view_model.dart';

class TestController {
  final TestViewModel viewModel;

  TestController(this.viewModel);

  void next() {
    if (viewModel.currentIndex < viewModel.questions.length - 1) {
      viewModel.currentIndex++;
    }
  }

  void previous() {
    if (viewModel.currentIndex > 0) {
      viewModel.currentIndex--;
    }
  }

  void toggleOption(int optionIndex) {
    viewModel.toggleSelection(optionIndex);
  }
}
