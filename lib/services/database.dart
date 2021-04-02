import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_time_tracker/pages/home/models/job.dart';
import 'package:flutter_app_time_tracker/services/api_path.dart';

import 'firestore_service.dart';

abstract class Database {
  Future<void> createJob(Job job);

  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase implements Database {
  final String uid;
  final _service = FirestoreService.instance;

  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  Future<void> createJob(Job job) => _service.setData(
        path: APIPath.job(uid, 'job_abc'),
        data: job.toMap(),
      );



  Stream<List<Job>> jobsStream() {
    _service.collectionStream(
      path: APIPath.jobs(uid),
      builder: (data) => Job.fromMap(data),
    );
  }
}
