import 'package:dest_bucket/components/blocs/common/bloc_event_state.dart';
import 'package:meta/meta.dart';

class AppInitializationState extends BlocState {

    final bool isInitialized;
    final bool isInitializing;
    final int progress;

    AppInitializationState({
        @required this.isInitialized,
        this.isInitializing: false,
        this.progress: 0,
    });

    factory AppInitializationState.notInitialized() {
        return AppInitializationState(
            isInitialized: false,
        );
    }

    factory AppInitializationState.progressing(int progress) {
        return AppInitializationState(
            isInitialized: progress == 100,
            isInitializing: true,
            progress: progress,
        );
    }

    factory AppInitializationState.initialized() {
        return AppInitializationState(
            isInitialized: true,
            progress: 100,
        );
    }
}