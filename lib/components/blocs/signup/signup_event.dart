import 'package:dest_bucket/components/blocs/common/bloc_event_state.dart';

class SignUpEvent extends BlocEvent {
  SignUpEvent({
    this.event,
    this.email,
    this.password,
  });

  final SignUpEventType event;
  final String email;
  final String password;
}

enum SignUpEventType {
  none,
  working,
}