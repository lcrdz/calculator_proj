extension StringExtensions on String {
  String removeLastChar() {
    if (isEmpty) return this;
    return substring(0, length - 1);
  }

  bool isNumber() {
    if (isEmpty) return false;
    return RegExp(_Constants.numberRegex).hasMatch(this);
  }

  bool lastCharIsNumber() {
    if (isEmpty) return false;
    final lastChar = this[length - 1];
    return lastChar.isNumber();
  }

  bool firstCharIsNumber() {
    if (isEmpty) return false;
    final firstChar = this[0];
    return firstChar.isNumber();
  }

  String formatExpression() {
    return replaceAll("x", "*");
  }
}

class _Constants {
  static const String numberRegex = r'^-?\d+$';
}
