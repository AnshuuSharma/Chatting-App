import 'package:chata_pp/model.dart/chatmodel.dart';
import 'package:flutter/material.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({super.key, required this.contact});
  final ChatModel contact;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        child: Column(
          children: [
            const Stack(children: [
              CircleAvatar(
                // backgroundColor: Colors.blueGrey.shade50,
                radius: 23,
                child: Icon(
                  Icons.person,
                  // color: Colors.blue.shade900,
                ),
              ),
              Positioned(
                  bottom: 3,
                  right: 4,
                  child: CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      radius: 10,
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 18,
                      )))
            ]),
            Text(
              contact.name.toString(),
            )
          ],
        ));
  }
}
