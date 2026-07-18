import 'package:flutter/material.dart';

void main() {
  runApp(const BmiApp());
}

class BmiApp extends StatelessWidget {
  const BmiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BmiCalculatorScreen(),
    );
  }
}

class BmiCalculatorScreen extends StatefulWidget {
  const BmiCalculatorScreen({super.key});

  @override
  State<BmiCalculatorScreen> createState() => _BmiCalculatorScreenState();
}

class _BmiCalculatorScreenState extends State<BmiCalculatorScreen> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  double bmiResult = 0.0;
  String healthStatus = '';

  void calculateBmi() {
    final double weight = double.tryParse(weightController.text) ?? 0.0;
    final double height = double.tryParse(heightController.text) ?? 0.0;

    setState(() {
      if (height > 0 && weight > 0) {
        bmiResult = weight / (height * height);

        if (bmiResult < 18.5) {
          healthStatus = 'Underweight';
        } else if (bmiResult <= 24.9) {
          healthStatus = 'Normal';
        } else {
          healthStatus = 'Overweight';
        }
      } else {
        bmiResult = 0.0;
        healthStatus = '';
      }
    });
  }

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Weight (kg)',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Height (m)',
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: calculateBmi,
                child: const Text('Calculate'),
              ),
              const SizedBox(height: 32),
              Card(
                elevation: 4,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const Text(
                        'BMI Result',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        bmiResult.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 32),
                      ),
                      if (healthStatus.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          healthStatus,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}