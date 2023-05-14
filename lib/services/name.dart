import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String hosturl = "https://sprout-plant-care-app.onrender.com/";

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

class order {
  final int? price;
  final String? currency;
  final String? receipt;
  final Map? notes;
  order({this.currency, this.notes, this.price, this.receipt});
  order.fromJson(Map<String, dynamic> json)
      : currency = json["currency"],
        price = json['amount'],
        receipt = json["receipt"],
        notes = json['notes'];
}

class shop {
  final int? price;
  final String? img;
  final String? name;
  final String? description;
  final String? category;
  shop({this.category, this.description, this.name, this.img, this.price});
  shop.fromJson(Map<String, dynamic> json)
      : img = json['image'],
        price = json['price'],
        category = json["category"],
        name = json['name'],
        description = json['description'];
}

class apiFetcher {
  Future<List<Name>> getplants(String value) async {
    String planturl = hosturl + "plant?name=";

    Uri url = Uri.parse(planturl + value);
    http.Response response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      List info = jsonDecode(response.body);
      // print(info);
      return info.map((data) => Name.fromJson(data)).toList();
    } else {
      throw Exception("Unexpected Error");
    }
  }

  Future<List<shop>> getshopdata() async {
    String url = hosturl + "shop";
    Uri ur = Uri.parse(url);
    http.Response response = await http.get(ur);

    if (response.statusCode == 200) {
      List info = jsonDecode(response.body);
      return info.map((data) => shop.fromJson(data)).toList();
    } else {
      throw Exception("Unexpected Error");
    }
  }

  Future<List<shop>> getindoorplantdata() async {
    String url = hosturl + "shop/category/Indoor";
    Uri ur = Uri.parse(url);
    http.Response response = await http.get(ur);

    if (response.statusCode == 200) {
      List info = jsonDecode(response.body);
      return info.map((data) => shop.fromJson(data)).toList();
    } else {
      throw Exception("Unexpected Error");
    }
  }

  Future<List<shop>> getoutdoorplantdata() async {
    String url = hosturl + "shop/category/Outdoor";
    Uri ur = Uri.parse(url);
    http.Response response = await http.get(ur);

    if (response.statusCode == 200) {
      List info = jsonDecode(response.body);
      print(info);
      return info.map((data) => shop.fromJson(data)).toList();
    } else {
      throw Exception("Unexpected Error");
    }
  }

  Future<List<shop>> getmedicinedata() async {
    String url = hosturl + "shop/category/Medicine";
    Uri ur = Uri.parse(url);
    http.Response response = await http.get(ur);

    if (response.statusCode == 200) {
      List info = jsonDecode(response.body);
      return info.map((data) => shop.fromJson(data)).toList();
    } else {
      throw Exception("Unexpected Error");
    }
  }
}
