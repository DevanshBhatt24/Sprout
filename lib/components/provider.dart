import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  bool? isuser = true;
  bool? isselected = false;
  void toggle(bool? selected) {
    isselected = selected!;
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
}
