class Obscure {
  static String mobile(String mobile) {
    if (mobile.length < 8) return mobile;

    return mobile.substring(0, mobile.length - 8) + '****' + mobile.substring(mobile.length - 4);
  }

  static String email(String email) {
    int index = email.indexOf('@');
    if (index == -1) return email;

    String string = '';
    if (index > 3) {
      string += email.substring(0, 3);
    } else {
      string += email.substring(0, index);
    }
    string += '***@***';
    if (email.length - index > 4) {
      string += email.substring(email.length - 3);
    } else {
      string += email.substring(index + 1);
    }

    return string;
  }
}
