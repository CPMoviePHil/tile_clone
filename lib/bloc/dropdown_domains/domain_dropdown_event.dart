part of 'domain_dropdown_bloc.dart';

abstract class DomainDropdownEvent extends Equatable {
  const DomainDropdownEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DomainDropdownInit extends DomainDropdownEvent {}

class DomainDropdownChose extends DomainDropdownEvent {
  final String? domain;

  DomainDropdownChose({
    @required this.domain,
  });
}