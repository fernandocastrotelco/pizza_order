import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_order/domain/models/chat_user.dart';
import 'package:pizza_order/navigator_utils.dart';
import 'package:pizza_order/ui/home/chat/selection/friends_selection_cubit.dart';

class FriendsSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FriendsSelectionCubit()..init()),
        BlocProvider(create: (_) => FriendsGroupCubit()),
      ],
      child: BlocBuilder<FriendsGroupCubit, bool>(builder: (context, isGroup) {
        return BlocBuilder<FriendsSelectionCubit, List<ChatUserState>>(
            builder: (context, snapshot) {
          final selectedUsers =
              context.read<FriendsSelectionCubit>().selectedUsers;
          return Scaffold(
            floatingActionButton: isGroup && selectedUsers.isNotEmpty
                ? FloatingActionButton(onPressed: () {
                    print('Display group');
                    //pushAndReplaceToPage(context, GroupSelectionGroup());
                  })
                : null,
            body: Column(
              children: [
                if (isGroup)
                  Row(
                    children: [
                      BackButton(
                        onPressed: () {
                          context.read<FriendsGroupCubit>().changeToGroup();
                        },
                      ),
                      Text('new group'),
                    ],
                  )
                else
                  Row(
                    children: [
                      BackButton(
                        onPressed: Navigator.of(context).pop,
                      ),
                      Text('people'),
                    ],
                  ),
                if (!isGroup)
                  ElevatedButton(
                    child: Text('Create Group'),
                    onPressed: () {
                      print('create group');
                      context.read<FriendsGroupCubit>().changeToGroup();
                    },
                  )
                else if (isGroup && selectedUsers.isEmpty)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(),
                      Text('Add a friend'),
                    ],
                  )
                else
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedUsers.length,
                        itemBuilder: (context, index) {
                          final chatUserState = selectedUsers[index];
                          return Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(),
                                  Text(chatUserState.chatUser.name),
                                ],
                              ),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    print('select user');
                                    context
                                        .read<FriendsSelectionCubit>()
                                        .selectUser(chatUserState);
                                  })
                            ],
                          );
                        }),
                  ),
                Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.length,
                        itemBuilder: (context, index) {
                          final chatUserState = snapshot[index];
                          return ListTile(
                            onTap: () {
                              print('select user');
                            },
                            leading: CircleAvatar(),
                            title: Text(chatUserState.chatUser.name),
                            trailing: isGroup
                                ? Checkbox(
                                    value: chatUserState.selected,
                                    onChanged: (val) {
                                      print('select user group');
                                      context
                                          .read<FriendsSelectionCubit>()
                                          .selectUser(chatUserState);
                                    })
                                : null,
                          );
                        }))
              ],
            ),
          );
        });
      }),
    );
  }
}
