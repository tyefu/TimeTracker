import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_time_tracker/pages/home/models/job.dart';
import 'package:flutter_app_time_tracker/services/api_path.dart';
import 'package:provider/provider.dart';

import '../pages/home/models/job.dart';
import '../pages/home/models/job.dart';
import '../pages/home/models/job.dart';
import '../pages/home/models/job.dart';
import 'firestore_service.dart';

abstract class Database {

  Future<void> createJob(Job job);
}

class FirestoreDatabase implements Database {
  final String uid;
  final _service = FirestoreService.instance;

  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  Future<void> createJob(Job job){
    final path = 'users/$uid/jobs/jobabc';
    final documentReference = FirebaseFirestore.instance.doc(path);
    documentReference.set(job.toMap());
  }
}