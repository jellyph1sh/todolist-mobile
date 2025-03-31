import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    int? id,
    required String task,
    @JsonKey(fromJson: _intToBool, toJson: _boolToInt)
    required bool isCompleted,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

// Fonction pour convertir un entier en booléen
bool _intToBool(int value) => value == 1;

// Fonction pour convertir un booléen en entier
int _boolToInt(bool value) => value ? 1 : 0;
