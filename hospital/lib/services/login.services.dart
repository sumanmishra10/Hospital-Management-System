import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  static final String apiUrl = 'https://mediprocomputers.com/mediprowebapi/';

  static Future<String?> loginUser(String username, String password) async {
    try {
      final encodedUsername = Uri.encodeComponent(username);
      final encodedPassword = Uri.encodeComponent(password);

      var url = Uri.parse(apiUrl + 'token');
      var body = {
        'username': encodedUsername,
        'password': encodedPassword,
        'grant_type': 'password',
      };

      final response = await http.post(
        url,
        body: body,
      );

      if (response.statusCode == 200) {
        final user = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', user['access_token']);
        return user['access_token'];
      } else {
        return null; // Return null to indicate login failure
      }
    } catch (error) {
      return null; // Return null to indicate an error occurred
    }
  }
}
