import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_order/domain/models/chat_user.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatUserState {
  const ChatUserState(this.chatUser, {this.selected = false});
  final ChatUser chatUser;
  final bool selected;
}

class FriendsSelectionCubit extends Cubit<List<ChatUserState>> {
  FriendsSelectionCubit() : super([]);

  //final StreamApiRepository streamApiRepository;

  List<ChatUserState> get selectedUsers =>
      state.where((element) => element.selected).toList();

  Future<void> init() async {
    //final list = users.map((e) => ChatUserState(e)).toList();
    final list = List.generate(
        10,
        (index) =>
            ChatUserState(ChatUser('Item :$index', id: index.toString())));
    emit(list);
  }

  void selectUser(ChatUserState chatUser) {
    final index = state
        .indexWhere((element) => element.chatUser.id == chatUser.chatUser.id);
    state[index] =
        ChatUserState(state[index].chatUser, selected: !chatUser.selected);
    emit(List<ChatUserState>.from(state));
  }

  Future<Channel> createFriendChannel(ChatUserState chatUserState) async {}
}

class FriendsGroupCubit extends Cubit<bool> {
  FriendsGroupCubit() : super(false);

  void changeToGroup() => emit(!state);
}
