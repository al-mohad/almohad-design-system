class RegexPatterns {
  /// ✅ Singleton Getter
  static final RegexPatterns _instance = RegexPatterns._();

  /// ✅ Private constructor
  RegexPatterns._();

  /// ✅ Singleton accessor
  static RegexPatterns get regx => _instance;

  /// ✅ **Email validation**: Standard email format
  static final RegExp email = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );

  /// ✅ **Password validation**: Min 8 chars, at least 1 letter & 1 number
  static final RegExp password = RegExp(
    r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$",
  );

  /// ✅ **Strong password**: Min 8 chars, 1 uppercase, 1 lowercase, 1 number, 1 special character
  static final RegExp strongPassword = RegExp(
    r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$",
  );

  /// ✅ **Phone number**: Supports international format
  static final RegExp phone = RegExp(r"^\+?[1-9]\d{1,14}$");

  /// ✅ **Only numbers**: Digits only
  static final RegExp onlyNumbers = RegExp(r"^\d+$");

  /// ✅ **Only letters**: No numbers or special characters
  static final RegExp onlyLetters = RegExp(r"^[a-zA-Z]+$");

  /// ✅ **Alphanumeric**: Letters & numbers, no spaces or special characters
  static final RegExp alphanumeric = RegExp(r"^[a-zA-Z0-9]+$");

  /// ✅ **Username**: Letters, numbers, underscores, 3-16 characters
  static final RegExp username = RegExp(r"^[a-zA-Z0-9_]{3,16}$");

  /// ✅ **Full name**: Only letters & spaces, min 2 characters
  static final RegExp fullName = RegExp(r"^[a-zA-Z\s]{2,}$");

  /// ✅ **URL validation**: Supports HTTP/HTTPS
  static final RegExp url = RegExp(
    r"^(https?:\/\/)?(www\.)?[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(:\d+)?(\/\S*)?$",
  );

  /// ✅ **IPv4 Address**: Standard IPv4 format
  static final RegExp ipv4 = RegExp(r"^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$");

  /// ✅ **Hex color code**: Supports #RGB, #RRGGBB
  static final RegExp hexColor = RegExp(r"^#(?:[0-9a-fA-F]{3}){1,2}$");

  /// ✅ **Date (YYYY-MM-DD)**: Standard date format
  static final RegExp date = RegExp(r"^\d{4}-\d{2}-\d{2}$");

  /// ✅ **Time (HH:MM 24-hour format)**: 00:00 to 23:59
  static final RegExp time24Hour = RegExp(r"^(?:[01]\d|2[0-3]):[0-5]\d$");

  /// ✅ **Time (12-hour format with AM/PM)**: 12-hour format validation
  static final RegExp time12Hour = RegExp(
    r"^(0?[1-9]|1[0-2]):[0-5]\d\s?(AM|PM|am|pm)$",
  );

  /// ✅ **Postal Code (US ZIP Code format)**: 5-digit or ZIP+4
  static final RegExp zipCodeUS = RegExp(r"^\d{5}(-\d{4})?$");

  /// ✅ **Credit Card Number**: 13 to 19 digits
  static final RegExp creditCard = RegExp(r"^\d{13,19}$");

  /// ✅ **Base64 string**: Base64 encoding format
  static final RegExp base64 = RegExp(
    r"^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=)?$",
  );

  /// ✅ **HTML tag validation**: Detects basic HTML tags
  static final RegExp htmlTag = RegExp(r"<\/?[a-z][\s\S]*>");

  /// ✅ **UUID validation**: Matches UUID v4
  static final RegExp uuid = RegExp(
    r"^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$",
  );
}
