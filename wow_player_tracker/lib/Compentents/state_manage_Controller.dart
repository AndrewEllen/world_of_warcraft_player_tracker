import 'package:flutter/material.dart';

class StateManageController extends ChangeNotifier
{

  bool _open = false;

  bool get open => _open;

  void setOpenState()
  {
    _open = !_open;
    notifyListeners();
  }


}