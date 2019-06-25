import 'package:dest_bucket/components/blocs/common/widgets/bloc_state_builder.dart';
import 'package:dest_bucket/components/blocs/signup/signup_bloc.dart';
import 'package:dest_bucket/components/blocs/signup/signup_event.dart';
import 'package:dest_bucket/components/blocs/signup/signup_form_bloc.dart';
import 'package:dest_bucket/components/blocs/signup/signup_state.dart';
import 'package:dest_bucket/widgets/pending_action.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _retypeController;
  SignUpFormBloc _signUpFormBloc;
  SignUpBloc _signUpBloc;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _retypeController = TextEditingController();
    _signUpFormBloc = SignUpFormBloc();
    _signUpBloc = SignUpBloc();
  }

  @override
  void dispose() {
    _signUpBloc?.dispose();
    _signUpFormBloc?.dispose();
    _emailController?.dispose();
    _passwordController?.dispose();
    _retypeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<SignUpState>(
        bloc: _signUpBloc,
        builder: (BuildContext context, SignUpState state) {
          if (state.isBusy) {
            return PendingAction();
          } else if (state.isSuccess) {
            return _buildSuccess();
          } else if (state.isFailure) {
            return _buildFailure();
          }
          return _buildForm();
        });
  }

  Widget _buildSuccess() {
    return Center(
      child: Text('Success'),
    );
  }

  Widget _buildFailure() {
    return Center(
      child: Text('Failure'),
    );
  }

  Widget _buildForm() {
    return Form(
      child: Column(
        children: <Widget>[
          StreamBuilder<String>(
              stream: _signUpFormBloc.email,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return TextField(
                  decoration: InputDecoration(
                    labelText: 'email',
                    errorText: snapshot.error,
                  ),
                  controller: _emailController,
                  onChanged: _signUpFormBloc.onEmailChanged,
                  keyboardType: TextInputType.emailAddress,
                );
              }),
          StreamBuilder<String>(
              stream: _signUpFormBloc.password,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return TextField(
                  decoration: InputDecoration(
                    labelText: 'password',
                    errorText: snapshot.error,
                  ),
                  controller: _passwordController,
                  obscureText: false,
                  onChanged: _signUpFormBloc.onPasswordChanged,
                );
              }),
          StreamBuilder<String>(
              stream: _signUpFormBloc.confirmPassword,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return TextField(
                  decoration: InputDecoration(
                    labelText: 'retype password',
                    errorText: snapshot.error,
                  ),
                  controller: _retypeController,
                  obscureText: false,
                  onChanged: _signUpFormBloc.onRetypePasswordChanged,
                );
              }),
          StreamBuilder<bool>(
              stream: _signUpFormBloc.registerValid,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                return RaisedButton(
                  child: Text('SignUp'),
                  onPressed: (snapshot.hasData && snapshot.data == true)
                      ? () {
                    _signUpBloc.emitEvent(SignUpEvent(
                        event: SignUpEventType.working,
                        email: _emailController.text,
                        password: _passwordController.text));
                  }
                      : null,
                );
              }),
        ],
      ),
    );
  }
}