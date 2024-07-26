import 'package:flutter/material.dart';

class Config {
  static String baseUrl = 'https://mediprocomputers.com/mediprowebapi/';

  //'http://192.168.15.126/medipro.api.medipro';

  //'https://bluecross.com.np/MediproWebApi';

  // 'https://pharmacy.norvichospital.com/mediprowebapi/';

  static bool noProductHide = false;

  static int minimumDelivery = 500;
  static int discount500To1000 = 0;
  static int discount1000Above = 7;

  static String esewaMerchantCode = 'NP-ES-NORVI';

  static Color primaryColor = const Color.fromARGB(255, 116, 135, 255);

  // static Color primaryColor = Colors.black;
  static Color bgColor = Color.fromRGBO(240, 238, 238, 1);
  // static Color bgColor = Color.fromARGB(255, 199, 141, 34);
  static double defaultHeight = 856.707;
  static double defaultWidth = 392.727;

  static var apiUrl;
}
