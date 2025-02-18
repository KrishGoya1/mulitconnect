class EntryValidator {
  static String? validateEntry(Map<String, dynamic> entry) {
    if (entry['name']?.isEmpty ?? true) return 'Name required';
    if (entry['id']?.isEmpty ?? true) return 'ID required';
    return null;
  }
} 