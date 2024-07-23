import 'package:chata_pp/model.dart/chatmodel.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.contact});
  final ChatModel contact;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 53,
        width: 50,
        child: Stack(children: [
          const CircleAvatar(
            // backgroundColor: Colors.blueGrey.shade50,
            radius: 23,
            child: Icon(
              Icons.person,
              // color: Colors.blue.shade800,
            ),
          ),
          contact.select
              ? const Positioned(
                  bottom: 4,
                  right: 5,
                  child: CircleAvatar(
                      backgroundColor: Colors.deepPurpleAccent,
                      radius: 10,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18,
                      )))
              : Container()
        ]),
      ),
      title: Text(
        contact.name.toString(),
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        contact.status.toString(),
        style: TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }
}
