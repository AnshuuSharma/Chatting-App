import 'package:flutter/material.dart';

class Reply extends StatelessWidget {
  const Reply({super.key, required this.message, required this.time});
  final String message;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Stack(
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 50, top: 5, bottom: 30),
                    child: Text(message)),
                 Positioned(
                  bottom: 4,
                  right: 10,
                  child: Text(time),
                )
              ],
            ),
          ),
        ));
  }
}
