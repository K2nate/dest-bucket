
import 'package:dest_bucket/widgets/log_out_button.dart';
import 'package:flutter/material.dart';

class PortalPage extends StatelessWidget {
  //
  // prevents the use of the 'back' button
  //
  Future<bool> _onWillPopScope() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Portal Page'),
            leading: Container(),
            actions: <Widget>[
              LogOutButton(),
            ],
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: RaisedButton(
                    child: Text('Portal'),
//                    onPressed: ,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}