import 'package:chata_pp/components/buttoncard.dart';
import 'package:chata_pp/components/contactCard.dart';
import 'package:chata_pp/model.dart/chatmodel.dart';
import 'package:chata_pp/screens/createGroup.dart';
import 'package:flutter/material.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({super.key});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {
    List<ChatModel> contacts = [
      ChatModel(
          name: "Prachi",
          isGroup: false,
          time: '12:02',
          currentMsg: 'hello',
          id: 1,
          status: 'cute'),
      ChatModel(
          name: "Tomar",
          isGroup: false,
          time: '08:43',
          currentMsg: 'yoho',
          id: 1,
          status: 'sexy'),
      ChatModel(
          name: "Anshu",
          isGroup: false,
          time: '03:33',
          currentMsg: 'blah blah',
          id: 1,
          status: '!'),
      ChatModel(
          name: "Dev",
          isGroup: false,
          time: '11:11',
          currentMsg: 'hihii',
          id: 1,
          status: 'art'),
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Column(
            children: [
              Text(
                'Select Contact',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Text(
                '256 contacts',
                style: TextStyle(
                  fontSize: 13,
                ),
              )
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          ],
        ),
        body: ListView.builder(
            itemCount: contacts.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => CraeteGroup()));
                    },
                    child: ButtonCard(name: "New group", icon: Icons.group));
              } else if (index == 1) {
                return ButtonCard(name: "New Contact", icon: Icons.person_add);
              }
              return ContactCard(contact: contacts[index - 2]);
            }));
  }
}
