import 'package:flutter/material.dart';
import 'package:pizza_order/data_utils.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class FriendsChat extends StatefulWidget {
  @override
  _FriendsChatState createState() => _FriendsChatState();
}

class _FriendsChatState extends State<FriendsChat> {
  final _keyChannels = GlobalKey<ChannelsBlocState>();
  Future<void> _onCreateChannel() async {
    final result = await showDialog(
        context: context,
        builder: (context) {
          final _channelController = TextEditingController();
          return AlertDialog(
            title: Text('Create Channel'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _channelController,
                  decoration: InputDecoration(
                    hintText: 'Channel Name',
                  ),
                ),
                ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pop(_channelController.text),
                    child: Text('Save')),
              ],
            ),
          );
        });
    if (result != null) {
      final client = StreamChat.of(context).client;
      final channel = client.channel('messaging',
          id: result, extraData: {'image': DataUtils.getUserImage('ch')});
      await channel.create();
      _keyChannels.currentState.queryChannels();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: _onCreateChannel, label: Text('Create Channel')),
      appBar: AppBar(
        title: Text('Pizza Chat'),
      ),
      body: ChannelsBloc(
        key: _keyChannels,
        child: ChannelListView(
          channelWidget: ChannelPage(),
        ),
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChannelHeader(),
      body: Column(
        children: [
          Expanded(
            child: MessageListView(),          
          ),
          MessageInput(),
        ],
      ),
    );
  }
}
