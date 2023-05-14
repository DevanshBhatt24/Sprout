import 'dart:convert';

import 'package:Sprout/screens/zengarden.dart';
import 'package:Sprout/services/name.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Session {
  Map<String, String> headers = {};
  String? rawCookie;
  var cookie;
  Future<Map> get(String url) async {
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    // updateCookie(response);
    return json.decode(response.body);
  }

  Future<Map> post(String url, var data) async {
    http.Response response =
        await http.post(Uri.parse(url), body: data, headers: headers);
    updateCookie(response);

    // print(json.decode(response.body));
    return json.decode(response.body);
  }

  Future<List<Name>> post2(String url, var data) async {
    print(headers);
    http.Response response =
        await http.post(Uri.parse(url), body: data, headers: headers);
    updateCookie(response);
    print(response.statusCode);
    // print(json.decode(response.body));
    if (response.statusCode == 200) {
      List info = jsonDecode(response.body);
      // print(info);
      return info.map((data) => Name.fromJson(data)).toList();
    } else {
      throw Exception("Unexpected Error");
    }
  }

  void updateCookie(http.Response response) {
    rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie!.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie! : rawCookie!.substring(0, index);
      setcookie();
    }
  }

  String? getcookie() {
    return cookie;
  }

  void setcookie() {
    // print(headers['cookie']);
    cookie = headers['cookie'];
  }
}
