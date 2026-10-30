import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'offline_session_model.g.dart';

@HiveType(typeId: 0, adapterName: 'OfflineSessionAdapter')
@JsonSerializable()
class OfflineSession extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String filePath;

  @HiveField(2)
  String archiveTimestamp;

  @HiveField(3)
  String? sessionName;

  @HiveField(4)
  bool isActive;

  @HiveField(5)
  String audioDuration;

  @HiveField(6)
  String? sessionDuration;

  @HiveField(7)
  String? completedOn;

  @HiveField(8)
  String createdOn;

  @HiveField(9)
  String? targetDuration;

  @HiveField(10)
  String topic;

  @HiveField(11)
  String? path;

  OfflineSession({
    required this.id,
    required this.filePath,
    required this.archiveTimestamp,
    required this.createdOn,
    required this.topic,
    this.sessionName,
    this.completedOn,
    this.targetDuration,
    this.path,
    required this.audioDuration,
    required this.sessionDuration,
    this.isActive = true,
  });

  /// JSON Serialization
  factory OfflineSession.fromJson(Map<String, dynamic> json) => _$OfflineSessionFromJson(json);

  Map<String, dynamic> toJson() => _$OfflineSessionToJson(this);


}
