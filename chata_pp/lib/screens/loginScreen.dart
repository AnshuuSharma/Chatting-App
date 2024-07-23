import 'package:chata_pp/components/buttoncard.dart';
import 'package:chata_pp/model.dart/chatmodel.dart';
import 'package:chata_pp/screens/homeScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;
  List<ChatModel> chats = [
    ChatModel(
        id: 1,
        name: 'Dev Sharma',
        isGroup: false,
        time: "11:11",
        currentMsg: 'hello didi',
        status: ''),
    ChatModel(
        id: 2,
        name: 'prachi',
        isGroup: false,
        time: "09:00",
        currentMsg: 'hihi hiho hoho',
        status: ''),
    ChatModel(
      id: 3,
      name: 'Anshu Sharma',
      isGroup: false,
      time: "11:11",
      currentMsg: 'hello ',
    ),
    ChatModel(
      id: 4,
      name: 'Yashwini Tomar',
      isGroup: false,
      time: "11:11",
      currentMsg: 'skibidi tiolet ',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) => InkWell(
              onTap: () {
                sourceChat = chats.removeAt(index);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => HomeScreen(
                              sourcechat: sourceChat,
                              chatmodel: chats,
                            )));
              },
              child: ButtonCard(
                  name: chats[index].name.toString(), icon: Icons.person))),
    );
  }
}
