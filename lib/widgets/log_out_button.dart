import 'package:dest_bucket/components/blocs/authentication/authentication_bloc.dart';
import 'package:dest_bucket/components/blocs/authentication/authentication_event.dart';
import 'package:dest_bucket/components/blocs/common/bloc_provider.dart';
import 'package:flutter/material.dart';

class LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      onPressed: () {
        bloc.emitEvent(AuthenticationEventLogout());
      },
    );
  }
}
