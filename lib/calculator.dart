import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MathCalculator {
  double calculeExpression(String expression) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      return exp.evaluate(EvaluationType.REAL, cm);
    } catch (e) {
      debugPrint("Erro durante o cálculo da expressão: $e");
      return double.nan;
    }
  }
}
