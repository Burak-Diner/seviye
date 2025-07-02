import 'package:flutter/material.dart';
import '../controllers/test_controller.dart';
import '../viewmodels/test_view_model.dart';

class TestPage extends StatefulWidget {
  final TestController controller;
  const TestPage({super.key, required this.controller});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  TestViewModel get vm => widget.controller.viewModel;

  @override
  Widget build(BuildContext context) {
    final question = vm.questions[vm.currentIndex];
    final progress = (vm.currentIndex + 1) / vm.questions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 8),
            Text('${(vm.currentIndex + 1).toString().padLeft(2, '0')}/${vm.questions.length.toString().padLeft(2, '0')}'),
            const SizedBox(height: 24),
            Text(question.text, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            Column(
              children: List.generate(question.options.length, (i) {
                final option = question.options[i];
                final selected = vm.isSelected(i);
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selected ? Colors.blue : null,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.controller.toggleOption(i);
                      });
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(option),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 8),
            const Text('Birden fazla seçim işaretleyebilirsiniz'),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: vm.currentIndex == 0
                        ? null
                        : () {
                            setState(() {
                              widget.controller.previous();
                            });
                          },
                    child: const Text('Geri'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (vm.isLastQuestion) {
                        final score = vm.computeScore();
                        Navigator.of(context).pop(score);
                      } else {
                        setState(() {
                          widget.controller.next();
                        });
                      }
                    },
                    child: Text(vm.isLastQuestion ? 'Bitir' : 'İleri'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
