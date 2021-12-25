import 'package:chat/models/user_info.dart';
import 'package:hive/hive.dart';

class HelperData {
  
  static Box? _x;
  static Future init() async {
    _x =  await Hive.openBox('data');
  }

  static void saveData(Map<String,String> user){
    _x!.put('currentUser', user);
  }

  static getData() {
    var data =  _x!.get('currentUser');
    print(data);
    // return UserInf.fromJson(data);
  }
}

