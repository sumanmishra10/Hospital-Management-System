import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../configs/config.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordService {
  static String baseUrl = Config.baseUrl;

  static Future<int> postForgotPassword(String email) async {
    String apiURL = baseUrl + "api/accounts/generateresetpasswordcode";

    final uri = Uri.parse(apiURL);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    Map<String, dynamic> body = {
      "email": email,
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    final response = await http.post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );
    int statusCode = response.statusCode;
    String responseBody = response.body;

    return statusCode;
  }
}
