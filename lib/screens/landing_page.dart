import 'package:flutter/material.dart';
import 'home_page.dart';
import 'test_page.dart';
import '../models/question.dart';
import '../viewmodels/test_view_model.dart';
import '../controllers/test_controller.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.ac_unit, size: 48), // placeholder logo
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Seviyeni\nHemen Ölç!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Seviyeni bilmen bizim için çok önemli!\nTüm soruları doğru doldurduğundan emin ol!',
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final questions = List.generate(
                        10,
                        (index) => const Question(
                          text: 'Teniste aşağıdakilerden hangi seviyedesin?',
                          options: ['Başlangıç', 'Orta', 'Orta/Üst', 'İleri'],
                        ),
                      );
                      final vm = TestViewModel(questions);
                      final controller = TestController(vm);
                      final score = await Navigator.of(context).push<double>(
                        MaterialPageRoute(
                          builder: (_) => TestPage(controller: controller),
                        ),
                      );
                      if (context.mounted && score != null) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => HomePage(initialScore: score),
                          ),
                        );
                      }
                    },
                    child: const Text('Hemen Başla'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const HomePage()),
                      );
                    },
                    child: const Text('Daha Sonra'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
