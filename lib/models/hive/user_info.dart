import 'package:hive/hive.dart';
part 'user_info.g.dart';

@HiveType(typeId: 0)
class UserInf extends HiveObject {
  @HiveField(0) String email;
  @HiveField(1) String image;
  @HiveField(2) String name;
  @HiveField(3) String phone;
  @HiveField(4) String uid;

  UserInf({required this.name,required this.email,required this.phone,required this.image, required this.uid});

  factory UserInf.fromJson(Map<String,dynamic> json){
    return UserInf(
      name: json['displayName'].toString(),
      email: json['email'].toString(),
      phone: json['phoneNumber'].toString(),
      image: json['photoUrl'].toString(),
      uid: json['uid'].toString(),
    );
  }
  
}

class Boxes{
  static const String userInfo = 'userInfo';
  static Box<UserInf> getUserInfoBox() => Hive.box<UserInf>(userInfo);
  
}