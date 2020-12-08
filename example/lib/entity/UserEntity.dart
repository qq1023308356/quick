import 'package:tenant_app/entity/safe_convert.dart';

class UserEntity {
	String userId = "";
	String userName = "";
	String nickName = "";
	int userType = 0;
	int userRole = 0;
	String sysSessionId = "";
	int source = 0;

	UserEntity();

	UserEntity.fromJson(Map<String, dynamic> json)
			:	userId = SafeManager.parseString(json, 'userId'),
	userName = SafeManager.parseString(json, 'userName'),
	nickName = SafeManager.parseString(json, 'nickName'),
	userType = SafeManager.parseInt(json, 'userType'),
	userRole = SafeManager.parseInt(json, 'userRole'),
	sysSessionId = SafeManager.parseString(json, 'sysSessionId'),
	source = SafeManager.parseInt(json, 'source');

	Map<String, dynamic> toJson() => {
				'userId': this.userId,
				'userName': this.userName,
				'nickName': this.nickName,
				'userType': this.userType,
				'userRole': this.userRole,
				'sysSessionId': this.sysSessionId,
				'source': this.source,
			};
}
