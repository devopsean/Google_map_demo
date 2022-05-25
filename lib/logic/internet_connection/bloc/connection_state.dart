part of 'connection_bloc.dart';

@immutable
abstract class ConnectionState {}

class ConnectedInitialState extends ConnectionState {}

class ConnectedSucessState extends ConnectionState {}

class ConnectedFailureState extends ConnectionState {}