import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key,required this.message,required this.time});
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            color: Color.fromARGB(255, 178, 235, 242),
            child:  Stack(
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 50, top: 5, bottom: 30),
                    child: Text(message)),
                Positioned(
                    bottom: 4,
                    right: 10,
                    child: Row(
                      children: [Text(time), Icon(Icons.done_all)],
                    ))
              ],
            ),
          ),
        ));
  }
}
