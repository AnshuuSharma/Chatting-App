class ChatModel {
  String? name;
  bool isGroup;
  String? time;
  String? currentMsg;
  int id;
  String? status;
  bool select;
  ChatModel(
      {this.name,
      this.time,
      this.currentMsg,
      this.id = 0,
      this.status,
      required this.isGroup,
      this.select = false});
}
