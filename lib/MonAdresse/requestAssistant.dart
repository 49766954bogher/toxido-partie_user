import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestAssistant {
  static Future<String> getRequests(Uri s) async {
    http.Response response = await http.get(s);
    try {
      if (response.statusCode == 200) {
        String JsonData = response.body;
        var decodeData = jsonDecode(JsonData);
        return decodeData;
      } else {
        return "failled, no request";
      }
    } catch (exp) {
      return "failed";
    }
  }
}
