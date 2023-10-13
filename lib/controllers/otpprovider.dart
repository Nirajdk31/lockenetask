import 'package:flutter/cupertino.dart';

class AccountIdHandler with ChangeNotifier {
  int? _otp;

  int? get otpDummy => _otp;

  void setAccountId(int token) {
    _otp = token;
    notifyListeners();
  }
}