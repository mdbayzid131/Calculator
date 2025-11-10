import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userInput = '';
  String answer = '0';

  final List<String> _buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffA7C7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xff6278E3),
        title: const Text(
          'Calculator',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Display Area
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff6278E3), Color(0xffA7C7FA)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    userInput,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    answer,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Button Area
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: GridView.builder(
                  itemCount: _buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final btn = _buttons[index];

                    // Clear Button
                    if (btn == 'C') {
                      return MyButton(
                        buttonText: btn,
                        color: Colors.white38,
                        textcolor: Colors.black,
                        buttontap: () {
                          setState(() {
                            userInput = '';
                            answer = '0';
                          });
                        },
                      );
                    }
                    // +/- Button
                    else if (btn == '+/-') {
                      return MyButton(
                        buttonText: btn,
                        color: Colors.white38,
                        textcolor: Colors.black,
                        buttontap: () {
                          setState(() {
                            if (userInput.isNotEmpty) {
                              if (userInput.startsWith('-')) {
                                userInput = userInput.substring(1);
                              } else {
                                userInput = '-$userInput';
                              }
                            }
                          });
                        },
                      );
                    }
                    // Delete Button
                    else if (btn == 'DEL') {
                      return MyButton(
                        buttonText: btn,
                        color: Colors.white38,
                        textcolor: Colors.black,
                        buttontap: () {
                          setState(() {
                            if (userInput.isNotEmpty) {
                              userInput = userInput.substring(
                                0,
                                userInput.length - 1,
                              );
                            }
                          });
                        },
                      );
                    }
                    // Equal Button
                    else if (btn == '=') {
                      return MyButton(
                        buttonText: btn,
                        color: Colors.orange[700],
                        textcolor: Colors.white,
                        buttontap: () {
                          setState(() {
                            _evaluateExpression();
                          });
                        },
                      );
                    }
                    // Other Buttons
                    else {
                      return MyButton(
                        buttonText: btn,
                        color: _isOperator(btn)
                            ? Colors.blueAccent
                            : Colors.white,
                        textcolor: _isOperator(btn)
                            ? Colors.white
                            : Colors.blueAccent,
                        buttontap: () {
                          setState(() {
                            userInput += btn;
                          });
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isOperator(String x) {
    return (x == '/' ||
        x == 'x' ||
        x == '-' ||
        x == '+' ||
        x == '=' ||
        x == '%');
  }

  void _evaluateExpression() {
    try {
      String finalInput = userInput.replaceAll('x', '*');
      Parser p = Parser();
      Expression exp = p.parse(finalInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      answer = eval.toString();
    } catch (e) {
      answer = 'Error';
    }
  }
}
