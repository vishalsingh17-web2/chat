import 'package:hive/hive.dart';
part 'conversation.g.dart';

@HiveType(typeId: 1)
class ChatModel extends HiveObject {
  @HiveField(0)
  final bool sentByMe;
  @HiveField(1)
  final String message;
  @HiveField(2)
  final String time;

  ChatModel(
      {required this.sentByMe, required this.message, required this.time});
}
