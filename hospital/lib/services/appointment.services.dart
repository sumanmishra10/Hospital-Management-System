import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentService {
  static Future<String> submitAppointment({
    required String pname,
    required String address,
    required String sex,
    required String contact,
    required String age,
    required String referer,
    required String speciality,
    required String date,
    required String time,
    required String email,
    required String remarks,
  }) async {
    try {
      // Create a JSON payload
      final Map<String, dynamic> payload = {
        'pname': pname,
        'address': address,
        'sex': sex,
        'mobile': contact,
        'age': age,
        'referer': referer,
        'speciality': speciality,
        'date': date,
        'time': time,
        'email': email,
        'remarks': remarks,
      };

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final String payloadJson = json.encode(payload);

      final Uri apiUrl = Uri.parse(
          'https://mediprocomputers.com/mediprowebapi/api/onlineappointment');

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Replace with your actual API token
      };

      final response = await http.post(
        apiUrl,
        headers: headers,
        body: payloadJson,
      );

      // Handle the response here
      if (response.statusCode == 200) {
        // Successful response
        return 'success';
      } else {
        // Handle other response codes or errors
        return 'An error occurred while submitting the appointment.';
      }
    } catch (error) {
      // Handle any exceptions that may occur
      return 'An error occurred: $error';
    }
  }
}
