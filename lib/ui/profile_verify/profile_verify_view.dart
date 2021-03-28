import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_order/navigator_utils.dart';
import 'package:pizza_order/ui/home_chat.dart';
import 'package:pizza_order/ui/profile_verify/profile_verify_cubit.dart';

class ProfileVerifyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ProfileVerifyCubit(),
        child: BlocConsumer<ProfileVerifyCubit, ProfileState>(
            listener: (context, snapshot) {
          if (snapshot.success) {
            pushAndReplaceToPage(context, HomeChat());
          }
        }, builder: (context, snapshot) {
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
                    onPressed: () => context.read<ProfileVerifyCubit>().pickImage()
                  ),
                  Text('Nombre'),
                  TextField(
                    decoration: InputDecoration(hintText: 'o cómo te dicen'),
                  ),
                  ElevatedButton(
                    onPressed: () => context.read<ProfileVerifyCubit>().startChatting(),
                    child: Text('Empezar chat'),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
