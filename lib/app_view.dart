import 'package:demoapp/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:demoapp/screens/auth/welcome_screen.dart';
import 'package:demoapp/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth',
      theme: ThemeData(
          colorScheme: const ColorScheme.light(
              primary: Color.fromRGBO(189, 57, 212, 1),
              onPrimary: Colors.black,
              secondary: Color.fromRGBO(244, 141, 177, 1),
              onSecondary: Colors.white,
              tertiary: Color.fromRGBO(255, 204, 128, 1),
              error: Colors.red,
              surface: Colors.white,
              onSurface: Colors.black87,
              outline: Color(0xFF424242))),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationState.authenticated) {
            return const HomeScreen();
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}
