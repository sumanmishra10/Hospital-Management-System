import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterService {
  static Future<String> registerUser({
    required String username,
    required String firstname,
    required String lastname,
    required String password,
    required String confirmPassword,
    required String email,
    required String mobile,
    required String address,
    required String refid,
  }) async {
    final Map<String, dynamic> userData = {
      'username': int.parse(username),
      'firstname': firstname,
      'lastName': lastname,
      'password': password,
      'confirmPassword': confirmPassword,
      'EmailAddress': email,
      'mobileNumber': int.parse(mobile.replaceAll(RegExp(r'[^\d]'), '')),
      'address': address,
      'refid': int.parse(refid),
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final Uri apiUrl =
        Uri.parse('http://192.168.15.126/medipro.api.medipro/api/userregister');
    final response = await http.post(
      apiUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(userData),
    );

    if (response.statusCode == 200) {
      // Save user data to shared preferences
      prefs.setInt('username', int.parse(username));
      prefs.setString('firstname', firstname);
      prefs.setString('lastname', lastname);
      prefs.setString('email', email);
      prefs.setInt('mobile', int.parse(mobile));
      prefs.setString('address', address);
      prefs.setInt('refid', int.parse(refid));

      return 'success';
    } else if (response.statusCode == 400) {
      // Registration failed due to invalid data
      return 'invalid_data';
    } else {
      // Registration failed due to an unexpected error
      return 'unexpected_error';
    }
  }
}
