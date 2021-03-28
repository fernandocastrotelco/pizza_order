import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_order/navigator_utils.dart';
import 'package:pizza_order/ui/app_theme_cubit.dart';
import 'package:pizza_order/ui/home/settings/settings_cubit.dart';
import 'package:pizza_order/ui/sign_in/sign_in_view.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = StreamChat.of(context).client.state.user;
    final image = user?.extraData['image'];
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              SettingsSwitchCubit(context.read<AppThemeCubit>().isDark),
        ),
        BlocProvider(
          create: (_) => SettingsLogoutCubit(),
        ),
      ],
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              if (image == null) Image.network(image) else Placeholder(),
              BlocBuilder<SettingsSwitchCubit, bool>(
                  builder: (context, snapshot) {
                return Switch(
                  value: snapshot,
                  onChanged:
                      context.read<SettingsSwitchCubit>().onChangeDarkMode,
                );
              }),
              Builder(builder: (context) {
                  return BlocListener<SettingsLogoutCubit, void>(
                    listener: (context, snapshot) {
                      popAllAndPush(context, SignInView());
                    },
                    child: ElevatedButton(
                      child: Text('LOGOUT'),
                      onPressed: () {                   
                        context.read<SettingsLogoutCubit>().logOut();
                      },
                    ),
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
