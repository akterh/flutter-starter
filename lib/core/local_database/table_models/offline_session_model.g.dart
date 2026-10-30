// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_session_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfflineSessionAdapter extends TypeAdapter<OfflineSession> {
  @override
  final int typeId = 0;

  @override
  OfflineSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OfflineSession(
      id: fields[0] as String,
      filePath: fields[1] as String,
      archiveTimestamp: fields[2] as String,
      createdOn: fields[8] as String,
      topic: fields[10] as String,
      sessionName: fields[3] as String?,
      completedOn: fields[7] as String?,
      targetDuration: fields[9] as String?,
      path: fields[11] as String?,
      audioDuration: fields[5] as String,
      sessionDuration: fields[6] as String?,
      isActive: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, OfflineSession obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.filePath)
      ..writeByte(2)
      ..write(obj.archiveTimestamp)
      ..writeByte(3)
      ..write(obj.sessionName)
      ..writeByte(4)
      ..write(obj.isActive)
      ..writeByte(5)
      ..write(obj.audioDuration)
      ..writeByte(6)
      ..write(obj.sessionDuration)
      ..writeByte(7)
      ..write(obj.completedOn)
      ..writeByte(8)
      ..write(obj.createdOn)
      ..writeByte(9)
      ..write(obj.targetDuration)
      ..writeByte(10)
      ..write(obj.topic)
      ..writeByte(11)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflineSessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfflineSession _$OfflineSessionFromJson(Map<String, dynamic> json) =>
    OfflineSession(
      id: json['id'] as String,
      filePath: json['filePath'] as String,
      archiveTimestamp: json['archiveTimestamp'] as String,
      createdOn: json['createdOn'] as String,
      topic: json['topic'] as String,
      sessionName: json['sessionName'] as String?,
      completedOn: json['completedOn'] as String?,
      targetDuration: json['targetDuration'] as String?,
      path: json['path'] as String?,
      audioDuration: json['audioDuration'] as String,
      sessionDuration: json['sessionDuration'] as String?,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$OfflineSessionToJson(OfflineSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filePath': instance.filePath,
      'archiveTimestamp': instance.archiveTimestamp,
      'sessionName': instance.sessionName,
      'isActive': instance.isActive,
      'audioDuration': instance.audioDuration,
      'sessionDuration': instance.sessionDuration,
      'completedOn': instance.completedOn,
      'createdOn': instance.createdOn,
      'targetDuration': instance.targetDuration,
      'topic': instance.topic,
      'path': instance.path,
    };
