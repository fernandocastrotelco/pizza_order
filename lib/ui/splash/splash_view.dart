import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_order/navigator_utils.dart';
import 'package:pizza_order/ui/home_chat.dart';
import 'package:pizza_order/ui/profile_verify/profile_verify_view.dart';
import 'package:pizza_order/ui/sign_in/sign_in_view.dart';
import 'package:pizza_order/ui/splash/splash_cubit.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..init(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, snapshot) {
          if (snapshot == SplashState.none) {
            pushAndReplaceToPage(context, SignInView());
          } else if (snapshot == SplashState.existing_user) {
            pushAndReplaceToPage(context, HomeChat());
          } else {
            pushAndReplaceToPage(context, ProfileVerifyView());
          }
        },
        child: Scaffold(
          backgroundColor: Colors.red,
          body: Center(
            child: ElevatedButton(onPressed: () {}, child: Text('Next')),
          ),
        ),
      ),
    );
  }
}
