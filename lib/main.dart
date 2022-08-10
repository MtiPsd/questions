void main() {
  int answer1 = getCentury(501);

  print("Answer 1 is: $answer1");

  bool answer2 = showString("aaabaaaa");

  print("Answer 2 is: $answer2");
}

// Question 1
int getCentury(int years) {
  double number = years / 100;

  int century = number.ceil();

  return century;
}

// Question 2
bool showString(String text) {
  String reversed = text.split("").reversed.join();

  bool result = reversed == text;

  return result;
}
