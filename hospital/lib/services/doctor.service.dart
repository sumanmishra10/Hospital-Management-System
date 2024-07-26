import 'dart:convert';
import 'package:http/http.dart' as http;

import '../configs/config.dart';
import '../models/doctorslist.dart';

class DoctorServices {
  static String url = Config.baseUrl;

  static get spId => null;

  // 'https://mediprocomputers.com/mediprowebapi/api/bedrack/select';

  static Future<List<RefererSetupGetDt>> getDoctorsList(String? search) async {
    String apiURL = "$url/api/GetWebReferer";
    //apiURL = (search == null) ? apiURL : "$apiURL??spId=$spId";
    //apiURL = (search == null) ? url : '$url?search=$search';
    //String apiURL = "$url/api/RefererSetup/SpecialitySearch";
    apiURL = (search == null) ? apiURL : "$apiURL?search=$search";

    final uri = Uri.parse(apiURL);
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString('token');

    final headers = {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer $token',
    };

    final encoding = Encoding.getByName('utf-8');

    final response = await http.get(
      uri,
      headers: headers,
    );

    List<RefererSetupGetDt> users = (json.decode(response.body) as List)
        .map((data) => RefererSetupGetDt.fromJson(data))
        .toList();

    // print(users);
    return users;
  }
}
