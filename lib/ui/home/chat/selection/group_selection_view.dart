import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_order/ui/home/chat/selection/group_selection_cubit.dart';

import 'friends_selection_cubit.dart';

class GroupSelectionView extends StatelessWidget {
  GroupSelectionView(this.selectedUsers);
  final List<ChatUserState> selectedUsers;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupSelectionCubit(selectedUsers),
          child: BlocConsumer<GroupSelectionCubit, GroupSelectionState>(
            listener: (context, snapshot) {

            },
            builder: (context, snapshot) {
              return Scaffold(
        body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Mi Perfil'),
                  Placeholder(
                    fallbackHeight: 100,
                    fallbackWidth: 100,
                  ),
                  IconButton(
                    icon: Icon(Icons.photo),
                    onPressed: () {},
                    //onPressed: () => context.read<ProfileVerifyCubit>().pickImage()
                  ),
                  TextField(
                    controller: context.read<GroupSelectionCubit>().nameTextController,
                    decoration: InputDecoration(hintText: 'Nombre del Grupo'),
                  ),
                  Wrap(
                      children: List.generate(
                          selectedUsers.length,
                          (index) => Column(
                                children: [
                                  CircleAvatar(), 
                                  Text(selectedUsers[index].chatUser.name)
                                ],
                              ))),
                  ElevatedButton(
                    onPressed: () {},
                    //onPressed: () => context.read<ProfileVerifyCubit>().startChatting(),
                    child: Text('Next'),
                  )
                ],
              ),
        ),
      );
            }
          ),
    );
  }
}
