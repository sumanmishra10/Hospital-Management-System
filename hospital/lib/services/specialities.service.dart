import 'dart:convert';
import 'package:hospital/models/department.dart';
import 'package:http/http.dart' as http;

import '../configs/config.dart';

class SpecialistiesServices {
  static String url = Config.baseUrl;

  // 'https://mediprocomputers.com/mediprowebapi/api/bedrack/select';

  static Future<List<filter_SpecialityDt>> getCategories(String? search) async {
    String apiURL = "$url/api/getwebspeciality";
    apiURL = (search == null) ? apiURL : "$apiURL?search=$search";

    // String apiURL = "$url/api/RefererSetup/SpecialitySearch";

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
    List<SpecialityDt> users = (json.decode(response.body) as List)
        .map((data) => SpecialityDt.fromJson(data))
        .toList();

    List<String> imageUrl = [
      'images/surgeon.png',
      'images/urology.jpg',
      'images/laparoscopic.png',
      'images/gastroenterologist.png',
      'images/psychiatrist.png',
      'images/gastroenterologist.png',
      'images/pulmonology.png',
      'images/gastroenterologist.png',
      'images/endocrine.png',
      'images/ortopedic.png',
      'images/psychiatrist.png',
      'images/cardiothoracic.png',
      'images/vascular-surgery.png',
      'images/nephrologist.png',
      'images/paediatrician.png',
      'images/pediatrics.png',
      'images/neurologist.png',
      'images/oncologist.png',
      'images/ENT SURGEON.png',
      'images/endoscopy.png',
      'images/dermatologist.png',
      'images/emergency-kit.png',
      'images/general surgeon.png',
      'images/pathologist.png',
      'images/radiologist.png',
      'images/anesthesia.png',
    ];

    List<filter_SpecialityDt> filteredData = [];
    for (int index = 0; index < users.length; index++) {
      filter_SpecialityDt item = filter_SpecialityDt(
          sp_id: users[index].spId,
          image: imageUrl[index],
          detail: users[index].detail);
      // filter_SpecialityDt item = [
      //   'sp_id': users[index].spId,
      //   'image': imageUrl[index],
      //   'detail': users[index].detail,
      // ];
      filteredData.add(item);
      print(filteredData);
    }
    // print(users);
    return filteredData;
  }
}
