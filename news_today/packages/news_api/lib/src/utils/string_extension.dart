extension StringExtensions on String? {
  // Returns an empty string if the value is null
  String get valueOrEmpty {
    return this ?? '';
  }

  // Returns true if the string is null or empty
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }
}
