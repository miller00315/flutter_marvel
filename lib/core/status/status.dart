import 'package:equatable/equatable.dart';

class Status extends Equatable {
  const Status();

  @override
  List<Object?> get props => [];
}

class InProgress extends Status {}

class Idle extends Status {}

class Done extends Status {}

class Error extends Status {}
