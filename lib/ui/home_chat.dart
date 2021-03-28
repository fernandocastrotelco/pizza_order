import 'package:flutter/material.dart';
import 'package:pizza_order/data_utils.dart';
import 'package:pizza_order/navigator_utils.dart';
import 'package:pizza_order/ui/friends_chat.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class HomeChat extends StatefulWidget {
  @override
  _HomeChatState createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  final _usernameController = TextEditingController();
  String _usernameError;

  Future<void> _onGoPressed() async {
    final username = _usernameController.text;
    if (username.isNotEmpty) {
      final client = StreamChat.of(context).client;
      await client.connectUser(
        User(
            id: username,
            extraData: {'image': DataUtils.getUserImage(username)}),
        client.devToken(username),
      );
      pushToPage(context, FriendsChat());
    } else {
      setState(() {
        _usernameError = "Username is not valid";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream Chat'),
      ),
      body: Center(
        child: Card(
          elevation: 11,
          margin: const EdgeInsets.all(15.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Welcome to Pizza Chat'),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    errorText: _usernameError,
                    hintText: 'Username',
                  ),
                ),
                ElevatedButton(onPressed: _onGoPressed, child: Text('Go')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
