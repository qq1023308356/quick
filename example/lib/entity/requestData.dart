import 'package:tenant_app/entity/safe_convert.dart';

import 'UserEntity.dart';

class RequestData<T> {
  int code = 0;
  String error = "";
  T data;

  RequestData({
    this.code,
    this.error,
    this.data,
  });

  static T generateOBJ<T>(json) {
    var flag = T.toString();
    if (flag == "String")
      return SafeManager.parseString(json, 'data') as T;
    else if (flag == "int")
      return SafeManager.parseInt(json, 'data') as T;
    else if (flag == "bool")
      return SafeManager.parseBoolean(json, 'data') as T;
    else if (flag == "double")
      return SafeManager.parseDouble(json, 'data') as T;
    else if(flag == "UserEntity"){
      return  UserEntity.fromJson(json['data']) as T;
    }else {
      return null;
    }
  }

  RequestData.fromJson(Map<String, dynamic> json) {
    code = SafeManager.parseInt(json, 'code');
    error = SafeManager.parseString(json, 'error');
    data = RequestData.generateOBJ(json);
  }

  Map<String, dynamic> toJson() => {
        'code': this.code,
        'error': this.error,
        'data': this.data,
      };
}
