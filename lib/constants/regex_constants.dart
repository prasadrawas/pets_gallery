class RegexConstants {
  static const String emailRegex =
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';

  static const String phoneRegex = r'^\d{10}$';

  static const String fullNameRegex = r'^[A-Za-z\s]+$';

  static const String sixCharacterPasswordRegex = r'^.{6,}$';

  static const String normalPasswordRegex = r'^.{8,}$';

  static const String nameRegex = r'^[A-Za-z\s]+$';

  static const String descriptionRegex = r'^[A-Za-z0-9\s\.,!?]+$';

  static const String colorRegex = r'^[A-Za-z0-9\s]+$';
}
