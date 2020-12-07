import 'quick.dart';

class QuickConfig {
  factory QuickConfig() => _getInstance();
  static QuickConfig get instance => _getInstance();
  static QuickConfig _instance;

  QuickStyle Function() _setQuickStyle;

  Function(String tip) _errorTip;

  Function get errorTip => _errorTip;

  set errorTip(Function value) {
    _errorTip = value;
  }

  QuickConfig._internal(){
    _setQuickStyle = () => QuickStyle.dad();
  }

  static QuickConfig _getInstance() {
    if (_instance == null) {
      _instance = QuickConfig._internal();
    }
    return _instance;
  }

  QuickStyle get style => _setQuickStyle();

  set quickStyle(QuickStyle Function() value) {
    _setQuickStyle = value;
  }
}