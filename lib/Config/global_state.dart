import 'package:shared_preferences/shared_preferences.dart';

class GlobalState {
  // Singleton instance
  static final GlobalState _instance = GlobalState._internal();

  // Private constructor
  GlobalState._internal();

  // Factory constructor to return the singleton instance
  factory GlobalState() {
    return _instance;
  }

  // User ID key for SharedPreferences
  static const String _userIdKey = 'user_id';

  // Store the user ID in memory
  String? _userId;

  // Track initialization state
  bool _isInitialized = false;

  // Getter for user ID
  String? get userId => _userId;

  // Setter for user ID with async save operation
  Future<void> setUserId(String? value) async {
    _userId = value;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value != null) {
      // Save the user ID to SharedPreferences
      await prefs.setString(_userIdKey, value);
    } else {
      // Remove the user ID from SharedPreferences
      await prefs.remove(_userIdKey);
    }

    print('User ID set to: ${value ?? "null"}');
  }

  // Initialize GlobalState and load user ID
  Future<void> initialize() async {
    if (_isInitialized) return; // Prevent reinitialization

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Load the existing user ID, if any
      _userId = prefs.getString(_userIdKey);

      if (_userId == null) {
        print('No User ID found. Waiting for it to be set manually.');
      } else {
        print('Loaded existing User ID: $_userId');
      }

      _isInitialized = true;
    } catch (e) {
      print('Error in GlobalState initialization: $e');
      rethrow;
    }
  }
}
