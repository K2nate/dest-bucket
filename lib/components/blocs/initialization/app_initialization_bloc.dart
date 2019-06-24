import 'package:dest_bucket/components/blocs/common/bloc_event_state.dart';
import 'app_initialization_event.dart';
import 'app_initialization_state.dart';

class AppInitializationBloc extends BlocEventStateBase<AppInitializationEvent, AppInitializationState> {

  AppInitializationBloc() :
        super(initialState : AppInitializationState.notInitialized(),
      );

  @override
  Stream<AppInitializationState> eventHandler(
      AppInitializationEvent event, AppInitializationState currentState) async* {

    if (!currentState.isInitialized) {
      yield AppInitializationState.notInitialized();
    }

    if (event.type == AppInitializationEventType.start) {
      for (int progress = 0; progress < 101; progress += 10) {
        await Future.delayed(const Duration(milliseconds: 300));
        yield AppInitializationState.progressing(progress);
      }
    }

    if (event.type == AppInitializationEventType.initialized) {
      yield AppInitializationState.initialized();
    }
  }
}