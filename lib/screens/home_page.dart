import 'package:flutter/material.dart';
import 'landing_page.dart';

class HomePage extends StatefulWidget {
  final double? initialScore;
  const HomePage({super.key, this.initialScore});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? score;

  @override
  void initState() {
    super.initState();
    score = widget.initialScore;
  }

  void startTest() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LandingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ana Menü')),
      body: Center(
        child: score == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Seviyeni hemen ölç'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: startTest,
                    child: const Text('Teste Başla'),
                  ),
                ],
              )
            : Text('Skorunuz: ${score!.toStringAsFixed(1)}'),
      ),
    );
  }
}
