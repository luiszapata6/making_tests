bool isValidEmail(String email) => emailRegex.hasMatch(email);

bool isValidPassword(String password) => validPasswordRegex.hasMatch(password);

final emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

final validPasswordRegex = RegExp(r'^[a-zA-Z0-9]{8,}$');
