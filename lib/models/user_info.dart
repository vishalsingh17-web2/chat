class UserInf{
  String email;
  String image;
  String name;
  String phone;
  String uid;
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