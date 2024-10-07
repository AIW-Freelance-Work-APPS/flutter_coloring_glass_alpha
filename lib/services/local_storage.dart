import 'dart:convert';

import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _tokenKey = 'token';

  // set token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // get token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // remove toke
  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  //set language
  static Future<void> savelanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }

  //get language
  static Future<String?> getlanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('language');
  }

  //set darkmode
  static Future<void> savedarkmode(bool darkmode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkmode', darkmode);
  }

  //get darkmode
  static Future<bool?> getdarkmode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('darkmode');
  }

  //set subdomain
  static Future<void> savesubdomain(String subdomain) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('subdomain', subdomain);
  }

  //get subdomain
  static Future<String?> getsubdomain() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('subdomain');
  }

  //remove subdomain
  static Future<void> removesubdomain() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('subdomain');
  }

  //set isfirt time
  static Future<void> saveisfirsttime(bool isfirsttime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isfirsttime', isfirsttime);
  }

  //get isfirst time
  static Future<bool?> getisfirsttime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isfirsttime');
  }

  //save score
  static Future<void> savescore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('score', score);
  }

  //get score
  static Future<int?> getscore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('score');
  }

  //save mission done
  static Future<void> savemissiondone(List<String> mission) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('missiondone', mission);
  }

  //get mission done
  static Future<List<String>?> getmissiondone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('missiondone');
  }

  static Future<void> saveDrawingToLocal(
      DrawingController drawingController, String key) async {
    final List<Map<String, dynamic>> drawingJson =
        drawingController.getJsonList();
    final String jsonString = jsonEncode(drawingJson);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonString); // Save drawing JSON
  }

  static Future<void> removeDrawingFromLocal(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
  static Future<void> loadDrawingFromLocal(
      DrawingController drawingController, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(key); // Retrieve saved drawing
    if (jsonString != null) {
      // Decode the JSON string
      final List<dynamic> drawingJson = jsonDecode(jsonString);
      List<Map<String, dynamic>> result = convertToMap(drawingJson);
      for (var element in result) {
        drawingController.addContent(SimpleLine.fromJson(element));
      }
    }
  }

  static List<Map<String, dynamic>> convertToMap(List<dynamic> inputList) {
    List<Map<String, dynamic>> result = [];

    for (var item in inputList) {
      Map<String, dynamic> lineMap = {};

      lineMap['type'] = item['type'];

      // Handle path conversion
      Map<String, dynamic> pathMap = {};
      pathMap['fillType'] = item['path']['fillType'];

      // Convert steps to start and end points
      List<Map<String, dynamic>> steps = [];
      for (var step in item['path']['steps']) {
        steps.add({
          'type': step['type'],
          'x': step['x'],
          'y': step['y'],
        });
      }
      pathMap['steps'] = steps;
      lineMap['path'] = pathMap;

      // Handle paint conversion
      Map<String, dynamic> paintMap = {
        'blendMode': item['paint']['blendMode'],
        'color': item['paint']['color'],
        'filterQuality': item['paint']['filterQuality'],
        'invertColors': item['paint']['invertColors'],
        'isAntiAlias': item['paint']['isAntiAlias'],
        'strokeCap': item['paint']['strokeCap'],
        'strokeJoin': item['paint']['strokeJoin'],
        'strokeWidth': item['paint']['strokeWidth'],
        'style': item['paint']['style']
      };
      lineMap['paint'] = paintMap;

      result.add(lineMap);
    }

    return result;
  }
}
