import 'package:chata_pp/components/messages.dart';
import 'package:chata_pp/components/reply.dart';
import 'package:chata_pp/model.dart/chatmodel.dart';
import 'package:chata_pp/model.dart/messageModel.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as Io;
import 'dart:convert';
import 'package:http/http.dart' as http;

class IndividualChat extends StatefulWidget {
  const IndividualChat(
      {super.key, required this.chatModel, required this.sourceChat});
  final ChatModel chatModel;
  final ChatModel sourceChat;
  @override
  State<IndividualChat> createState() => _IndividualChatState();
}

class _IndividualChatState extends State<IndividualChat> {
  bool show = false;
  FocusNode focusnode = FocusNode();
  Io.Socket? socket;
  bool sendButton = false;
  List<MessageModel> messages = [];
  TextEditingController _controller = new TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    connect();
    focusnode.addListener(() {
      if (focusnode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  void connect() {
    socket = Io.io("http://192.168.29.228:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket?.connect();
    socket?.emit("signin", widget.sourceChat.id);
    socket?.onConnect((data) {
      print('connected');
      socket?.on("message", (msg) {
        if (msg != null &&
            msg is Map<String, dynamic> &&
            msg.containsKey('message')) {
          setMessage("destination", msg['message']);
          Future.delayed(Duration(milliseconds: 200), () {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          });
        } else {
          print('Received unexpected data format: $data');
        }
        print({"message": msg['message']});
      });
    });
    print(socket?.connected);
  }

  void sendMessage(String message, int sourceId, int targetId) {
    final messageData = {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
    };
    print(messageData['message']);
    socket?.emit("message", messageData);
    setMessage("source", message);
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16));
    setState(() {
      messages.add(messageModel);
    });
    print(messages.last);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        backgroundColor: Colors.deepPurple[100],
        appBar: PreferredSize(
          preferredSize: Size.square(75),
          child: AppBar(
            leadingWidth: 95,
            backgroundColor: Colors.cyan,
            title: InkWell(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.chatModel.name.toString(),
                    style: const TextStyle(
                        fontSize: 18.5, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Last seen today at 12:12 pm',
                    style: TextStyle(fontSize: 13),
                  )
                ],
              ),
            ),
            leading: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                      CircleAvatar(
                          radius: 23,
                          child: Icon(widget.chatModel.isGroup
                              ? Icons.groups
                              : Icons.person)),
                    ],
                  ),
                )),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
              PopupMenuButton(
                  onSelected: (value) => print(value),
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (context) {
                    return const [
                      PopupMenuItem(
                        value: "view contact",
                        child: Text("view contact"),
                      ),
                      PopupMenuItem(
                        value: "Media, links, and docs",
                        child: Text("Media, links, and docs"),
                      ),
                      PopupMenuItem(
                        value: "search",
                        child: Text("search"),
                      ),
                      PopupMenuItem(
                        value: "Mute Notifications",
                        child: Text("Mute Notifications"),
                      ),
                      PopupMenuItem(
                        value: "Wallpaper",
                        child: Text("Wallpaper"),
                      ),
                    ];
                  })
            ],
          ),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Column(
                children: [
                  Expanded(
                    // height: MediaQuery.of(context).size.height - 140,
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        if (messages[index].type == "source") {
                          return MessageCard(
                              message: messages[index].message,
                              time: messages[index].time);
                        } else {
                          return Reply(
                              message: messages[index].message,
                              time: messages[index].time);
                        }
                      },
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        // height: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: Card(
                                    margin: const EdgeInsets.only(
                                        left: 2, bottom: 8, right: 2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          setState(() {
                                            sendButton = true;
                                          });
                                        } else {
                                          setState(() {
                                            sendButton = false;
                                          });
                                        }
                                      },
                                      controller: _controller,
                                      focusNode: focusnode,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                      minLines: 1,
                                      decoration: InputDecoration(
                                          hintText: "Type a message",
                                          border: InputBorder.none,
                                          prefixIcon: IconButton(
                                            icon: const Icon(
                                                Icons.emoji_emotions_outlined),
                                            onPressed: () {
                                              focusnode.unfocus();
                                              focusnode.canRequestFocus = false;
                                              setState(() {
                                                show = !show;
                                              });
                                            },
                                          ),
                                          suffixIcon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        context: context,
                                                        builder: (builder) =>
                                                            bottomSheet());
                                                  },
                                                  icon:
                                                      Icon(Icons.attach_file)),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.camera_alt)),
                                            ],
                                          ),
                                          contentPadding: EdgeInsets.all(5)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: CircleAvatar(
                                      child: IconButton(
                                    onPressed: () {
                                      if (sendButton) {
                                        sendMessage(
                                            _controller.text,
                                            widget.sourceChat.id,
                                            widget.chatModel.id);
                                        _controller.clear();
                                        sendButton = false;
                                        Future.delayed(
                                            Duration(milliseconds: 200), () {
                                          _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut,
                                          );
                                        });
                                      }
                                    },
                                    icon: Icon(sendButton
                                        ? (Icons.send)
                                        : (Icons.mic)),
                                  )),
                                )
                              ],
                            ),
                            show ? selectEmoji() : Container(),
                          ],
                        ),
                      ))
                ],
              ),
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            )),
      )
    ]);
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                iconCreation(
                    Icons.insert_drive_file, Colors.indigo, "Documnet"),
                iconCreation(Icons.camera_alt, Colors.pink, "camera"),
                iconCreation(Icons.insert_photo, Colors.purple, "gallery"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                iconCreation(Icons.headset, Colors.orange, "Audio"),
                iconCreation(Icons.location_pin, Colors.green, "Location"),
                iconCreation(Icons.person, Colors.blue, "Contact"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color c, String t) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: c,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          Text(t)
        ],
      ),
    );
  }

  Widget selectEmoji() {
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        print(emoji);
        setState(() {
          _controller.text = _controller.text + emoji.emoji;
        });
      },
    );
  }
}


