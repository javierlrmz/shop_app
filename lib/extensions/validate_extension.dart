extension ExtString on String {

  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passRegExp = RegExp (r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    return passRegExp.hasMatch(this);
  }
  
}