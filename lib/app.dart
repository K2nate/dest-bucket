
import 'package:dest_bucket/components/blocs/authentication/authentication_bloc.dart';
import 'package:dest_bucket/components/blocs/common/bloc_provider.dart';
import 'package:dest_bucket/pages/auth_decision_page.dart';
import 'package:dest_bucket/pages/initialization_page.dart';
import 'package:dest_bucket/pages/signup_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: AuthenticationBloc(),
      child: MaterialApp(
        title: 'BLoC sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/decision': (BuildContext context) => AuthDecisionPage(),
          '/signup': (BuildContext context) => SignUpPage(),
        },
        home: InitializationPage(),
      ),
    );
  }

}