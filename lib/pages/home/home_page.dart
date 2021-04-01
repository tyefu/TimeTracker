
import 'package:flutter/material.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/show_alert_dialog.dart';
import 'package:flutter_app_time_tracker/services/auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  Future<void> _signOut(BuildContext context)async{
    try{
      final auth = Provider.of<AuthBase>(context,listen: false);
      await auth.signOut();
      print('success signout');
    }catch(e){
      print(e.toString());
    }
  }
  Future<void> _confirmSignOut(BuildContext context)async{
    final didRequestSignOut = await showAlertDialog(context, title: 'Logout', content: 'Are you sure that you want to logout?', defaultActionText: 'Logout',
    cancelActionText: 'Cancel');
    if(didRequestSignOut == true){
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        actions: [
          ElevatedButton(onPressed:() => _confirmSignOut(context), child: Text('Logout',style: TextStyle(
            fontSize: 18.0,
            color: Colors.white
          ),),

          )
        ],
      ),
    );
  }
}
