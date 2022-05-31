extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

String? validateEmail(String? value) {
  if (!value!.isValidEmail()) {
    return '*Check your email.';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value!.isEmpty) {
    return '*Password is required';
  } else if (value.length < 6) {
    return '*Password should be more than 6 characters.';
  }
  return null;
}
