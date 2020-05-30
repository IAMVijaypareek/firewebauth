import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firewebauth/enum/view_state.dart';

class ImageUploadProvider with ChangeNotifier {
  ViewState _viewState = ViewState.IDLE;
  ViewState get getViewState => _viewState;

  void setToLoading() {
    _viewState = ViewState.LOADING;
    CircularProgressIndicator();
    notifyListeners();
  }

  void setToIdle() {
    _viewState = ViewState.IDLE;
    notifyListeners();
  }
}
