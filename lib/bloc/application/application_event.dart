part of 'application_bloc.dart';

abstract class ApplicationEvent extends Equatable {
  const ApplicationEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ApplicationInit extends ApplicationEvent {}
