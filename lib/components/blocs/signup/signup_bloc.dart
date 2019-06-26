import 'package:dest_bucket/components/blocs/common/bloc_event_state.dart';
import 'package:dest_bucket/components/blocs/signup/signup_event.dart';
import 'package:dest_bucket/components/blocs/signup/signup_state.dart';

class SignUpBloc extends BlocEventStateBase<SignUpEvent, SignUpState> {
  SignUpBloc()
      : super(
          initialState: SignUpState.noAction(),
        );

  @override
  Stream<SignUpState> eventHandler(
      SignUpEvent event, SignUpState currentState) async* {
    if (event.event == SignUpEventType.working) {
      yield SignUpState.busy();
      print('SignUp of ${event.email}/${event.password}');

      await Future.delayed(const Duration(seconds: 1));

      yield SignUpState.success();
    }
  }
}
