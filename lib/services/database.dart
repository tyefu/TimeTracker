
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_time_tracker/pages/home/models/job.dart';
import 'package:flutter_app_time_tracker/services/api_path.dart';

import '../pages/home/models/job.dart';
import 'api_path.dart';

import 'firestore_service.dart';

abstract class Database {
  Future<void> setJob(Job job);
  Stream<List<Job>> jobsStream();
  Future<void> deleteJob(Job job);
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  Future<void> setJob(Job job) => _service.setData(
    path: APIPath.job(uid, documentIdFromCurrentDate()),
    data: job.toMap(),
  );

  Stream<List<Job>> jobsStream() => _service.collectionStream(
    path: APIPath.jobs(uid),
    builder: (data,documentId) => Job.fromMap(data,documentId),
  );
  Future<void> deleteJob(Job job) async{
  _service.deleteData(path: APIPath.job(uid, job.id));
  }

}
