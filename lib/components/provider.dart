import 'package:Sprout/services/name.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  bool? isuser = true;
  bool? isselected = false;
  bool? isloading = false;
  bool? cart = false;
  double? price;
  double? totalprice;
  List<Product>? items = [];

  void toggle(bool? selected) {
    isselected = selected!;
    notifyListeners();
  }

  void set() {
    cart = !cart!;
    notifyListeners();
  }

  void setItems(var prod) {
    items = prod;
    notifyListeners();
  }

  void setPrice(double price) {
    totalprice = price;
    notifyListeners();
  }

  void unsetUser() {
    isuser = false;
    notifyListeners();
  }

  void setUser() {
    isuser = true;
    notifyListeners();
  }

  void setLoading() {
    isloading = true;
    notifyListeners();
  }

  void unsetLoading() {
    isloading = false;
    notifyListeners();
  }
}
