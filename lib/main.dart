import 'package:flutter/material.dart';

void main() => runApp(LoanCalculatorApp());

class LoanCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoanCalculatorScreen(),
    );
  }
}

class LoanCalculatorScreen extends StatefulWidget {
  @override
  _LoanCalculatorScreenState createState() => _LoanCalculatorScreenState();
}

class _LoanCalculatorScreenState extends State<LoanCalculatorScreen> {
  double _loanAmount = 1000;
  int _loanMonths = 12;
  double _interestRate = 0.0;
  double _monthlyPayment = 0.0;

  void _calculateMonthlyPayment() {
    setState(() {
      double interestFactor = 1 + (_interestRate / 100);
      _monthlyPayment = (_loanAmount * (interestFactor)) / _loanMonths;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loan Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amount: \$${_loanAmount.toStringAsFixed(2)}'),
            Slider(
              value: _loanAmount,
              min: 1000,
              max: 100000,
              divisions: 100,
              label: _loanAmount.round().toString(),
              onChanged: (value) {
                setState(() {
                  _loanAmount = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text('Months: $_loanMonths'),
            Slider(
              value: _loanMonths.toDouble(),
              min: 1,
              max: 60,
              divisions: 59,
              label: _loanMonths.toString(),
              onChanged: (value) {
                setState(() {
                  _loanMonths = value.toInt();
                });
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Interest rate (% per month)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _interestRate = double.tryParse(value) ?? 0.0;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateMonthlyPayment,
              child: Text('Calculate Monthly Payment'),
            ),
            SizedBox(height: 20),
            Text(
              'You will pay the approximate amount of \$${_monthlyPayment.toStringAsFixed(2)} monthly.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
