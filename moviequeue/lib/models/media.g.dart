// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MediaAdapter extends TypeAdapter<Media> {
  @override
  final int typeId = 0;

  @override
  Media read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Media(
      type: fields[0] as String,
      id: fields[1] as int,
      title: fields[2] as String,
      name: fields[3] as String,
      backDropPath: fields[4] as String,
      posterPath: fields[5] as String,
      overview: fields[6] as String,
      releaseDateFilm: fields[7] as String,
      releaseDateTVSeries: fields[8] as String,
      voteAverage: fields[9] as double,
      isFavourite: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Media obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.backDropPath)
      ..writeByte(5)
      ..write(obj.posterPath)
      ..writeByte(6)
      ..write(obj.overview)
      ..writeByte(7)
      ..write(obj.releaseDateFilm)
      ..writeByte(8)
      ..write(obj.releaseDateTVSeries)
      ..writeByte(9)
      ..write(obj.voteAverage)
      ..writeByte(10)
      ..write(obj.isFavourite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
