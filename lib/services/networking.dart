import 'dart:convert';

import 'package:http/http.dart' as http;

class Networking {
  String url;
  Networking({this.url});

  Future<dynamic> getData() async {
    print('url inside Networking $url');
    http.Response response = await http.get(Uri.parse(url));
    print('response inside Networking ${response.body}');
    print('statusCode inside Networking ${response.statusCode}');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
