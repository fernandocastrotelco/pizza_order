import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_order/navigator_utils.dart';
import 'package:pizza_order/ui/home/home_cubit.dart';
import 'package:pizza_order/ui/home_chat.dart';

import 'chat/selection/friends_selection_view.dart';
import 'settings/settings_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: Column(
        children: [
          Expanded(
              child: BlocBuilder<HomeCubit, int>(builder: (context, snapshot) {
            return IndexedStack(
              index: snapshot,
              children: [
                HomeChat(),
                SettingsView(),
              ],
            );
          })),
          HomeNavigationBar(),
        ],
      ),
    );
  }
}

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                context.read<HomeCubit>().onChangeTab(0);
              },
              child: Text('Chats')),
          FloatingActionButton(
            onPressed: () {
              pushToPage(context, FriendsSelectionView());
            },
            child: Icon(Icons.add),
          ),
          ElevatedButton(
              onPressed: () {
                context.read<HomeCubit>().onChangeTab(1);
              },
              child: Text('Settings'))
        ],
      ),
    );
  }
}
