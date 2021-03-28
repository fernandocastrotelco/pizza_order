import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_order/navigator_utils.dart';
import 'package:pizza_order/ui/profile_verify/profile_verify_view.dart';
import 'package:pizza_order/ui/sign_in/sign_in_cubit.dart';

import '../home_chat.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInCubit(),
      child:
          BlocConsumer<SignInCubit, SignInState>(listener: (context, snapshot) {
        if (snapshot == SignInState.none) {
          pushAndReplaceToPage(context, ProfileVerifyView());
        } else {
          pushAndReplaceToPage(context, HomeChat());
        }
      }, builder: (context, snapshot) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Bienvenido al Chat'),
                ElevatedButton(
                    child: Text('Ingresar'),
                    onPressed: () {
                      context.read<SignInCubit>().signIn();
                    })
              ],
            ),
          ),
        );
      }),
    );
  }
}
