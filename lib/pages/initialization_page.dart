import 'package:dest_bucket/components/blocs/common/widgets/bloc_state_builder.dart';
import 'package:dest_bucket/components/blocs/initialization/app_initialization_bloc.dart';
import 'package:dest_bucket/components/blocs/initialization/app_initialization_event.dart';
import 'package:dest_bucket/components/blocs/initialization/app_initialization_state.dart';
import 'package:flutter/material.dart';

class InitializationPage extends StatefulWidget {

  @override
  _InitializationPageState createState() => _InitializationPageState();

}

class _InitializationPageState extends State<InitializationPage> {

  AppInitializationBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = AppInitializationBloc();
    bloc.emitEvent(AppInitializationEvent());
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext pageContext) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: BlocEventStateBuilder<AppInitializationState>(
              bloc: bloc,
              builder: (BuildContext context, AppInitializationState state) {
                if (state.isInitialized) {
                  //
                  // Once the initialization is completed, let's move to another page
                  //
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushReplacementNamed('/decision');
                  });
                }
                return Text('Initialization in progress... ${state.progress}');
              },
            ),
          ),
        ),
      ),
    );
  }
}