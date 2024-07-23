import 'package:chata_pp/model.dart/chatmodel.dart';
import 'package:chata_pp/screens/chatPage.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.chatmodel, required this.sourcechat});
  final List<ChatModel>? chatmodel;
  final ChatModel sourcechat;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chit-Chat'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          PopupMenuButton(
              onSelected: (value) => print(value),
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) {
                return const [
                  PopupMenuItem(
                    value: "New group",
                    child: Text('New group'),
                  ),
                  PopupMenuItem(
                    value: "New broadcast",
                    child: Text('New broadcast'),
                  ),
                  PopupMenuItem(
                    value: "settings",
                    child: Text('settings'),
                  ),
                ];
              })
        ],
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(
            icon: Icon(
              Icons.camera_alt,
            ),
          ),
          Tab(
            icon: Icon(Icons.message),
          ),
          Tab(
            icon: Icon(
              Icons.camera,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.call,
            ),
          )
        ]),
      ),
      body: TabBarView(controller: _tabController, children: [
        const Text('camera'),
        ChatPage(
          sourceChat: widget.sourcechat,
          chatmodels: widget.chatmodel!,
        ),
        const Text('status'),
        const Text('calls')
      ]),
    );
  }
}
