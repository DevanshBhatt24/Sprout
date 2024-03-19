import 'dart:convert';

import 'package:Sprout/screens/zengarden.dart';
import 'package:Sprout/services/name.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  // Map<String, String> headers = {};
  // var header;
  // String? rawCookie;
  // var cookie;

  // Future<Map<String, String>> getHeader() async {
  //   // SharedPreferences pref = await SharedPreferences.getInstance();
  //   // print(pref.getString('auth-token'));
  //   var data;
  //   if (pref.getString('token') != null) {
  //     String? token = pref.getString('token');
  //     data = {'auth-token': token!};
  //   } else {
  //     print(pref.getString('token'));
  //   }
  //   return data;
  // }

  Future<Map> get(String url, var header) async {
    // var headers = await getHeader();
    // print(headers);
    http.Response response = await http.get(Uri.parse(url), headers: header);
    return json.decode(response.body);
  }

  Future<Map> post(String url, var data) async {
    http.Response response = await http.post(Uri.parse(url), body: data);
    return json.decode(response.body);
  }

  Future<Map> addplant(String url, var header) async {
    print(header);
    http.Response response = await http.post(Uri.parse(url), headers: header);
    return json.decode(response.body);
  }

  Future<Map> signout(String url, var header) async {
    // var header = await getHeader();
    print(header);
    http.Response response = await http.post(Uri.parse(url), headers: header);
    // print('login - ${response.headers}');
    return json.decode(response.body);
  }

  Future<List<Name>> post2(String url, var header) async {
    // var header = await getHeader();
    print(header);
    http.Response response = await http.get(Uri.parse(url), headers: header);
    print(response.body);
    // print(json.decode(response.body));
    if (response.statusCode == 200) {
      List info = jsonDecode(response.body);
      // print(info);
      return info.map((data) => Name.fromJson(data)).toList();
    } else {
      throw Exception("Unexpected Error");
    }
  }

  // void updateHeader(http.Response response) {
  //   if (response.headers != null) {
  //     headers['auth-token'] = response.headers['auth-token']!;
  //     setheader();
  //   }
  // }

  // String? getheader() {
  //   return header;
  // }

  // void setheader() {
  //   // print(headers['cookie']);
  //   header = headers['auth-token'];
  // }
}
