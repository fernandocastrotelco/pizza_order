import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_order/ui/home/chat/selection/friends_selection_cubit.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class GroupSelectionState {
  const GroupSelectionState(this.file, {this.channel});
  final File file;
  final Channel channel;
}

class GroupSelectionCubit extends Cubit<GroupSelectionState> {
  GroupSelectionCubit(this.members) : super(null);

  final nameTextController = TextEditingController();
  final List<ChatUserState> members;

  void createGroup() async {
    emit(GroupSelectionState(state.file, channel: null));
  }

  void pickImage() async {
    emit(GroupSelectionState(null));
  }
}
