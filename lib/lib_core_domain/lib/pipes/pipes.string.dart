class PipesString {
  static String stringShort(String label, int length,
      {String overflow = '...'}) {
    if (label.length > length) {
      return label.substring(0, length) + overflow;
    }
    return label;
  }
}
