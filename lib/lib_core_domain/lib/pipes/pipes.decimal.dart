class PipesNumber {
  static String unitsToDecimal(int units, int decimales) {
    double decimal = units / 100.0;
    return decimal.toStringAsFixed(decimales);
  }

  static int stringToUnits(String decimal) {
    try {
      return (double.parse(decimal) * 100).toInt();
    } catch (e) {
      return 0;
    }
  }
}
