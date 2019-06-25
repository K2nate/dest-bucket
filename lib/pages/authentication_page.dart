import 'package:dest_bucket/components/blocs/common/bloc_provider.dart';
import 'package:dest_bucket/components/blocs/common/widgets/bloc_state_builder.dart';
import 'package:dest_bucket/components/blocs/authentication/authentication_bloc.dart';
import 'package:dest_bucket/components/blocs/authentication/authentication_event.dart';
import 'package:dest_bucket/components/blocs/authentication/authentication_state.dart';
import 'package:dest_bucket/widgets/pending_action.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends StatelessWidget {
  //
  // Prevents the use of "back" button
  //
  Future<bool> _onWillPopScope() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Authentication Page'),
            leading: Container(),
          ),
          body: Container(
            child: BlocEventStateBuilder<AuthenticationState>(
              bloc: bloc,
              builder: (BuildContext context, AuthenticationState state) {
                if (state.isAuthenticating) {
                  return PendingAction();
                }

                if (state.isAuthenticated) {
                  return Container();
                }

                List<Widget> children = <Widget>[];

                // Button to fake the authentication (success)
                children.add(
                  ListTile(
                    title: RaisedButton(
                      child: Text('Log in (success)'),
                      onPressed: () {
                        bloc.emitEvent(AuthenticationEventLogin(name: 'Didier'));
                      },
                    ),
                  )
                );

                // Button to redirect to the registration page
                children.add(
                  ListTile(
                    title: RaisedButton(
                      child: Text('Register'),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/register');
                      },
                    ),
                  )
                );

                // Display a text if the authentication failed
                if (state.hasFailed) {
                  children.add(
                    Text('Authentication failure!'),
                  );
                }

                return Column(
                  children: children,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}