import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_time_tracker/pages/home/job/edit_job_page.dart';
import 'package:flutter_app_time_tracker/pages/home/job/empty_content.dart';
import 'package:flutter_app_time_tracker/pages/home/job/job_list_tile.dart';
import 'package:flutter_app_time_tracker/pages/home/job/list_items_builder.dart';
import 'package:flutter_app_time_tracker/pages/home/models/job.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/show_alert_dialog.dart';
import 'package:flutter_app_time_tracker/pages/signin/widgets/show_exception_alert_dialog.dart';
import 'package:flutter_app_time_tracker/services/auth.dart';
import 'package:flutter_app_time_tracker/services/database.dart';
import 'package:provider/provider.dart';

import '../../../services/database.dart';
import '../../signin/widgets/show_exception_alert_dialog.dart';
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

  void _creteeJob(BuildContext context) async {
    final database = Provider.of<Database>(context, listen: false);
    await database.setJob(Job(name: 'naoto', ratePerHour: 10));
    try {} on FirebaseException catch (e) {
      showExceptionAlertDialog(context,
          title: 'Operation failed', exception: e);
    }
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
          EditJobPage.show(context);
        },
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
      return ListItemsBuilder<Job>(
        snapshot: snapshot,
        itemBuilder: (context,job) => Dismissible(
          key: Key('job-${job.id}'),
          background: Container(color: Colors.red,),
          direction: DismissDirection.endToStart,
          onDismissed: (direction)=> _delete(context,job),
          child: JobListTile(job: job,onTap: (){
            EditJobPage.show(context,job: job);
          },),
        ),
      );
      },
    );
  }

Future<void>  _delete(BuildContext context, Job job) async{
    try{
      final database = Provider.of<Database>(context,listen: false);
      await database.deleteJob(job);
    }on FirebaseException catch(e) {
      showExceptionAlertDialog(context, title: 'Operation failed', exception: e);
    }

}
}
