import 'package:dest_bucket/components/blocs/common/bloc_event_state.dart';

class SignUpState extends BlocState {
  SignUpState({
    this.isBusy: false,
    this.isSuccess: false,
    this.isFailure: false,
  });

  final bool isBusy;
  final bool isSuccess;
  final bool isFailure;

  factory SignUpState.noAction() {
    return SignUpState();
  }

  factory SignUpState.busy(){
    return SignUpState(isBusy: true,);
  }

  factory SignUpState.success(){
    return SignUpState(isSuccess: true,);
  }

  factory SignUpState.failure(){
    return SignUpState(isFailure: true,);
  }

}