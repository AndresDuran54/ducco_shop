class PipesDecimal {
  static String unitsToDecimal(int units, int decimales) {
    double decimal = units / 100.0;
    return decimal.toStringAsFixed(decimales);
  }
}
