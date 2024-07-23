import 'package:chata_pp/model.dart/chatmodel.dart';
import 'package:chata_pp/screens/individualChat.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  CustomCard({Key? key, required this.chatModel,required this.sourceChat}) : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourceChat;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => IndividualChat(
              sourceChat: sourceChat,
              chatModel: chatModel,)));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Icon(chatModel.isGroup ? Icons.groups : Icons.person),
            ),
            title: Text(chatModel.name.toString()),
            subtitle: Row(
              children: [
                Icon(Icons.done_all_rounded),
                Text(chatModel.currentMsg.toString())
              ],
            ),
            trailing: Text(chatModel.time.toString()),
          )
        ],
      ),
    );
  }
}
