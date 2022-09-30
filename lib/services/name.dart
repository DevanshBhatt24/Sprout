import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String hosturl = "https://sprout-plant-care-app.herokuapp.com/";

class Name {
  final String? name;
  final String? image;
  final String? botname;
  final int? temp;
  final int? maxtemp;
  final int? soilmoist;
  final int? minsoilmoist;
  final int? humid;
  final int? maxhumid;
  final int? sunlight;
  final String? description;
  final String? pid;
  final String? id;
  Name(
      {this.name,
      this.image,
      this.temp,
      this.maxtemp,
      this.botname,
      this.humid,
      this.sunlight,
      this.minsoilmoist,
      this.soilmoist,
      this.maxhumid,
      this.description,
      this.pid,
      this.id});
  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
        soilmoist: json["max_soil_moist"],
        minsoilmoist: json["min_soil_moist"],
        humid: json["min_env_humid"],
        maxhumid: json["max_env_humid"],
        sunlight: json["max_light_mmol"],
        name: json['name'],
        image: json['image_url'],
        temp: json["min_temp"],
        botname: json['display_pid'],
        maxtemp: json['max_temp'],
        description: json["description"],
        id: json["_id"]);
  }
}

class apiFetcher {
  String planturl = hosturl + "plant?name=";
  Future<List<Name>> getdata(String value) async {
    Uri url = Uri.parse(planturl + value);
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      List info = jsonDecode(response.body);
      // print(info);
      return info.map((data) => Name.fromJson(data)).toList();
    } else {
      throw Exception("Unexpected Error");
    }
  }
}
