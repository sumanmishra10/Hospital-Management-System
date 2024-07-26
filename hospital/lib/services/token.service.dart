import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

class TokenService {
  static Future<String?> getToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Return String
      String? token = prefs.getString('token');
      return token;
    } catch (e) {
      // Handle exceptions (e.g., SharedPreferences not initialized)
      print('Error getting token: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getTokenPayload() async {
    final String? token = await getToken();
    if (token != null) {
      return Jwt.parseJwt(token);
    }
    return null;
  }

  static Future<bool> isTokenExpired() async {
    final String? token = await getToken();
    if (token != null) {
      return Jwt.isExpired(token);
    }
    return true; // Token is considered expired if not found
  }
}
