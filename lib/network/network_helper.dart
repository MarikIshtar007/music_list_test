import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({ @required this.url});
  final String url;

  Future<dynamic> getData() async{
    http.Response response = await http.get(url);

    if (response.statusCode == 200){
      String data = response.body;
      return jsonDecode(data);

    }else{
      print(response.statusCode);
    }
  }
}