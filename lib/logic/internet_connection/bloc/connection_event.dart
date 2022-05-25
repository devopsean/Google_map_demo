part of 'connection_bloc.dart';

@immutable
abstract class ConnectionEvent {}

class OnConnectedEvent extends ConnectionEvent{}

class OnNotConnectedEvent extends ConnectionEvent{}