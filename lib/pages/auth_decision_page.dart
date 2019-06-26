import 'package:dest_bucket/components/blocs/authentication/authentication_bloc.dart';
import 'package:dest_bucket/components/blocs/authentication/authentication_state.dart';
import 'package:dest_bucket/components/blocs/common/bloc_provider.dart';
import 'package:dest_bucket/components/blocs/common/widgets/bloc_event_state_builder.dart';
import 'package:dest_bucket/pages/authentication_page.dart';
import 'package:dest_bucket/pages/portal_page.dart';
import 'package:flutter/material.dart';

class AuthDecisionPage extends StatefulWidget {
  @override
  AuthDecisionPageState createState() {
    return new AuthDecisionPageState();
  }
}

class AuthDecisionPageState extends State<AuthDecisionPage> {
  AuthenticationState oldAuthenticationState;

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    return BlocEventStateBuilder<AuthenticationState>(
      bloc: bloc,
      builder: (BuildContext context, AuthenticationState state) {
        if (state != oldAuthenticationState) {
          oldAuthenticationState = state;

          if (state.isAuthenticated) {
            _redirectToPage(context, PortalPage());
          } else if (state.isAuthenticating || state.hasFailed) {
            // do nothing
          } else {
            _redirectToPage(context, AuthenticationPage());
          }
        }

        // This page does not need to display anything since it will
        // always remain behind any active page (and thus 'hidden')
        return Container();
      },
    );
  }

  void _redirectToPage(BuildContext context, Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MaterialPageRoute newRoute =
          MaterialPageRoute(builder: (BuildContext context) => page);

      Navigator.of(context)
          .pushAndRemoveUntil(newRoute, ModalRoute.withName('/decision'));
    });
  }
}
