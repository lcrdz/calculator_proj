import 'package:calculator_proj/calculator.dart';
import 'package:calculator_proj/extensions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: const ColorScheme.dark()),
      home: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text('calculator')),
        body: const Center(child: Calculator()),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _expression = "";
  String _result = "";
  final MathCalculator _calculator = MathCalculator();

  void inputText(String char) {
    setState(() {
      if (!_expression.lastCharIsNumber() && !char.isNumber()) {
        deleteLastChar();
        _expression = _expression + char;
      } else {
        _expression = _expression + char;
      }
    });
  }

  void deleteLastChar() {
    setState(() {
      _expression = _expression.removeLastChar();
    });
  }

  void clearFields() {
    setState(() {
      _expression = "";
      _result = "";
    });
  }

  void calcule() {
    setState(() {
      var result =
          _calculator.calculeExpression(_expression.formatExpression());
      if (result.isNaN) {
        showAlert(context, text: "o valor não é um número");
      } else if (result.isInfinite) {
        showAlert(context, text: "o resultado é infinito");
      } else {
        _result = result.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Text(
            _expression,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 32.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
          child: Text(
            _result,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 32.0),
          ),
        ),
        const Expanded(flex: 1, child: Padding(padding: EdgeInsets.all(8.0))),
        Expanded(
          flex: 4,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //1° coluna de botões
                    CalculatorButton(
                        buttonText: "7", action: (p) => inputText(p)),
                    CalculatorButton(
                      buttonText: "8",
                      action: (p) => inputText(p),
                    ),
                    CalculatorButton(
                      buttonText: "9",
                      action: (p) => inputText(p),
                    ),
                    CalculatorButton(
                      buttonText: "C",
                      isBold: true,
                      textColor: Colors.red,
                      action: (char) => deleteLastChar(),
                    ),
                    CalculatorButton(
                      buttonText: "AC",
                      isBold: true,
                      textColor: Colors.red,
                      action: (p) => clearFields(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //2° coluna de botões
                    CalculatorButton(
                      buttonText: "4",
                      action: (p) => inputText(p),
                    ),
                    CalculatorButton(
                      buttonText: "5",
                      action: (p) => inputText(p),
                    ),
                    CalculatorButton(
                      buttonText: "6",
                      action: (p) => inputText(p),
                    ),
                    CalculatorButton(
                      buttonText: "+",
                      isBold: true,
                      textColor: Colors.white,
                      action: (p) => setOperation(p),
                    ),
                    CalculatorButton(
                      buttonText: "-",
                      isBold: true,
                      textColor: Colors.white,
                      action: (p) => setOperation(p),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //3° coluna de botões
                    CalculatorButton(
                      buttonText: "1",
                      action: (p) => inputText(p),
                    ),
                    CalculatorButton(
                      buttonText: "2",
                      action: (p) => inputText(p),
                    ),
                    CalculatorButton(
                      buttonText: "3",
                      action: (p) => inputText(p),
                    ),
                    CalculatorButton(
                      buttonText: "x",
                      isBold: true,
                      textColor: Colors.white,
                      action: (p) => setOperation(p),
                    ),
                    CalculatorButton(
                      buttonText: "/",
                      isBold: true,
                      textColor: Colors.white,
                      action: (p) => setOperation(p),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 4° coluna de botões
                    CalculatorButton(
                      buttonText: "0",
                      action: (p) => inputText(p),
                    ),
                    CalculatorButton(
                      buttonText: ".",
                      action: (p) => setOperation(p),
                    ),
                    CalculatorButton(
                      buttonText: "00",
                      action: (p) => inputText(p),
                    ),
                    CalculatorButton(
                      buttonText: "=",
                      isBold: true,
                      textColor: Colors.white,
                      action: (p) => calcule(),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void setOperation(String char) {
    if (_expression.isNotEmpty) {
      inputText(char);
    } else {
      showAlert(context);
    }
  }

  Future<void> showAlert(BuildContext context,
      {String text = 'digite um número para continuar'}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('operação inválida'),
            content: Text(text),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('fechar'),
              ),
            ],
          );
        });
  }
}

class CalculatorButton extends StatelessWidget {
  final String buttonText;
  final Color textColor;
  final Function(String)? action;
  final bool isBold;

  const CalculatorButton(
      {super.key,
      required this.buttonText,
      this.textColor = Colors.black,
      this.action,
      this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          action?.call(buttonText);
          debugPrint("botao!");
        },
        child: Ink(
          color: Colors.grey,
          child: Center(
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: textColor,
                  fontWeight: isBold ? FontWeight.bold : null),
            ),
          ),
        ),
      ),
    );
  }
}
