import 'package:chat/hive/user/user_info.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'conversation/conversation.dart';

class Boxes{
  static init()async{
    Hive.registerAdapter(UserInfAdapter());
    Hive.registerAdapter(ChatModelAdapter());
    await Hive.openBox<UserInf>('userInfo');
    await Hive.openBox('theme');
    await openAllConversationBox();
  }

  static Box getThemeBox() => Hive.box('theme');

  static setdarkTheme() => getThemeBox().put('dark', true);
  static setlightTheme() => getThemeBox().put('dark', false);
  static getTheme() => getThemeBox().get('dark');
  

  // Setting user info list that is coming at Direct messages page 
  static const String userInfo = 'userInfo';
  static Box<UserInf> getUserInfoBox() => Hive.box<UserInf>(userInfo);

  static const String currentUser = 'currentUser';
  static UserInf? getCurrentUserInfo() => Hive.box<UserInf>(userInfo).get(currentUser);

  static deleteUserData({required String uid}) => Hive.box<UserInf>(userInfo).delete(uid);



  // Conversation Boxes

  static Future openAllConversationBox() async {
    getUserInfoBox().values.forEach((userInf)async{
      if(getCurrentUserInfo()?.uid != userInf.uid){
        print(userInf.name);
        await Hive.openBox<ChatModel>(userInf.uid);
      }
    });
  }

  static openConversationBox(String uid) async {
    if(Hive.isBoxOpen(uid)){
      return;
    }
    return await Hive.openBox<ChatModel>(uid);
  }

  static  getConversationBoxWithUser(String id) {
    return Hive.box<ChatModel>(id);
  }  

  static addCoversation({required ChatModel chatModel, required String id}) {
    Hive.box<ChatModel>(id).add(chatModel);
  }

  static ChatModel? getLastMessage(String id){
    if(Hive.isBoxOpen(id) && Hive.box<ChatModel>(id).length > 0){
      return Hive.box<ChatModel>(id).getAt(Hive.box<ChatModel>(id).length-1);
    }
  }

  static deleteUserConversation({required String uid}){
    Hive.box<ChatModel>(uid).clear();
    Hive.box<ChatModel>(uid).close();
  }
}