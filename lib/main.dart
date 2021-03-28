import 'package:flutter/material.dart';
import 'package:pizza_order/ui/app_theme_cubit.dart';
import 'package:pizza_order/ui/splash/splash_view.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _streamChatClient = StreamChatClient('p868jwy8n24c');

  void connectFakeUser() async {
    await _streamChatClient.disconnect();
    _streamChatClient.connectUser(User(id: 'ferjmc'),
        '8fs6duhv8uaxxy7u2wrtbjtnendfzt2vu6je8wbad3pvx3tpqdudqv72bamyuq4q');
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [],
          child: BlocProvider(
            create: (_) => AppThemeCubit()..init(),
            child: BlocBuilder<AppThemeCubit, bool>(builder: (context, snapshot) {
              return MaterialApp(
                title: 'Pizza Delivery',
                debugShowCheckedModeBanner: false,
                home: SplashView(),
                theme: snapshot ? ThemeData.dark() : ThemeData.light(),
                builder: (context, child) {
                    return StreamChat(client: _streamChatClient, child: child);
                },
              );
            }),
          ),
    );
  }
}
