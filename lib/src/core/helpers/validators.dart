class Validator {
  static String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Email is required!";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid email ID!";
    } else {
      return null;
    }
  }

  static String? validateEmpty(String value) {
    if (value.isEmpty) {
      return "Field can't be empty!";
    }
    return null;
  }

  static String? validateLoginPassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Password is required!";
    } else if (!regExp.hasMatch(value)) {
      return "At least 1 digit, special case, capital letter required!";
    } else {
      return null;
    }
  }

  static String? validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return 'Please enter mobile number!';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number!';
    }
    return null;
  }

  static String? validateOptionalMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return null;
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number!';
    }
    return null;
  }

  String? validatePassword(String value) {
    String upperCase = '(?=.*[A-Z])';
    String lowerCase = '(?=.*[a-z])';
    String digit = '(?=.*?[0-9])';
    String specialChar = '(?=.*?[!@#\$&*~])';
    String passwordLength = '.{8,}';

    // String pattern =
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

    RegExp regExpUpperCase = RegExp(upperCase);
    RegExp regExpLowerCase = RegExp(lowerCase);
    RegExp regExpDigit = RegExp(digit);
    RegExp regExpSpecialChar = RegExp(specialChar);
    RegExp regExpPasswordLength = RegExp(passwordLength);

    if (value.isEmpty) {
      return "Password  is required!";
    } else if (!regExpUpperCase.hasMatch(value)) {
      return "Atleast one upper case letter required!";
    } else if (!regExpLowerCase.hasMatch(value)) {
      return "Atleast one Lower Case Required";
    } else if (!regExpDigit.hasMatch(value)) {
      return "Atleast one Digit Required";
    } else if (!regExpSpecialChar.hasMatch(value)) {
      return "Atleast one Special Char{@ ,*,# etc} Required";
    } else if (!regExpPasswordLength.hasMatch(value)) {
      return "Password length should be minimum 8 ";
    } else {
      return null;
    }
  }

  static String? validatePinCode(String value) {
    String digit = '(?=.*?[0-9])';

    RegExp regExp = RegExp(digit);
    if (value.isEmpty) {
      return 'Please enter pincode';
    } else if (value.length < 6) {
      return 'Please enter valid pincode';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid pincode';
    }
    return null;
  }
}
