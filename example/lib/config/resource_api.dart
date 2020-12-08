import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tenant_app/entity/UserEntity.dart';
import 'package:tenant_app/entity/requestData.dart';
part 'resource_api.g.dart';
// flutter pub run build_runner build
@RestApi()
abstract class ResourceApi {
  factory ResourceApi(Dio dio, {String baseUrl}) = _ResourceApi;

  @POST("/api/verifyCode/send")
  Future<RequestData<String>> sendVerifyCode({@Body() Map<String, dynamic> map,});

  @POST("/api/v2/session")
  Future<RequestData<UserEntity>> login({@Body() Map<String, dynamic> map,});
}
