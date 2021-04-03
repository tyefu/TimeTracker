import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_time_tracker/pages/home/models/job.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/show_alert_dialog.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/show_exception_alert_dialog.dart';
import 'package:flutter_app_time_tracker/services/auth.dart';
import 'package:flutter_app_time_tracker/services/database.dart';
import 'package:provider/provider.dart';

import '../../../services/database.dart';
import '../models/job.dart';
import '../models/job.dart';

class JobPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
      print('success signout');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(context,
        title: 'Logout',
        content: 'Are you sure that you want to logout?',
        defaultActionText: 'Logout',
        cancelActionText: 'Cancel');
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

void _creteeJob(BuildContext context)async{
    final database = Provider.of<Database>(context,listen: false);
    await database.createJob(Job(name: 'naoto', ratePerHour: 10));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        actions: [
          ElevatedButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Logout',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          )
        ],
      ),
      body: _buildContents(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {


          _creteeJob(context);

        },
      ),
    );
  }


  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return Scaffold(appBar: AppBar(),);
  }
}
