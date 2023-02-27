extension StringHelper on String {
  String firstLetterOfEveryWordToCapital() {
    return split(" ").map((e) => e[0].toUpperCase() + e.substring(1)).join(" ");
  }
}
