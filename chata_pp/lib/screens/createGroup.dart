import 'package:chata_pp/components/AvatarCard.dart';
import 'package:chata_pp/components/contactCard.dart';
import 'package:chata_pp/model.dart/chatmodel.dart';
import 'package:flutter/material.dart';

class CraeteGroup extends StatefulWidget {
  const CraeteGroup({super.key});

  @override
  State<CraeteGroup> createState() => _CraeteGroupState();
}

class _CraeteGroupState extends State<CraeteGroup> {
  List<ChatModel> contacts = [
    ChatModel(
      name: "Prachi",
      isGroup: false,
      time: '12:02',
      currentMsg: 'hello',
      id: 1,
      status: 'cute',
    ),
    ChatModel(
      name: "Tomar",
      isGroup: false,
      time: '08:43',
      currentMsg: 'yoho',
      id: 1,
      status: 'sexy',
    ),
    ChatModel(
      name: "Anshu",
      isGroup: false,
      time: '03:33',
      currentMsg: 'blah blah',
      id: 1,
      status: '!',
    ),
    ChatModel(
      name: "Dev",
      isGroup: false,
      time: '11:11',
      currentMsg: 'hihii',
      id: 1,
      status: 'art',
    ),
  ];
  List<ChatModel> group = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Column(
            children: [
              Text(
                'New Group',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Text(
                'Add Participants',
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
        body: Stack(
          children: [
            ListView.builder(
                itemCount: contacts.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      height: group.isNotEmpty ? 90 : 10,
                    );
                  }
                  return InkWell(
                      onTap: () {
                        if (contacts[index - 1].select == false) {
                          setState(() {
                            contacts[index - 1].select = true;
                            group.add(contacts[index - 1]);
                          });
                        } else {
                          setState(() {
                            contacts[index - 1].select = false;
                            group.remove(contacts[index - 1]);
                          });
                        }
                      },
                      child: ContactCard(contact: contacts[index - 1]));
                }),
            group.isNotEmpty
                ? Column(
                    children: [
                      Container(
                        height: 75,
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            if (contacts[index].select == true) {
                              return InkWell(
                                  onTap: () {
                                    setState(() {
                                      contacts[index].select = false;
                                      group.remove(contacts[index]);
                                    });
                                  },
                                  child: AvatarCard(
                                    contact: contacts[index],
                                  ));
                            } else {
                              return Container();
                            }
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      )
                    ],
                  )
                : Container()
          ],
        ));
  }
}
