part of 'domain_dropdown_bloc.dart';

abstract class DomainDropdownState extends Equatable {
  const DomainDropdownState();
  @override
  List<Object> get props => [];
}

class DomainDropdownInitial extends DomainDropdownState {}

class DomainDropdownItem extends DomainDropdownState {
  final List<String> domains;

  DomainDropdownItem({
    @required this.domains,
  });

  @override
  List<Object> get props => [
    this.domains,
  ];
}

class DomainDropdownChosen extends DomainDropdownState {
  final String domain;
  final List<String> domains;

  DomainDropdownChosen({
    @required this.domain,
    @required this.domains,
  });

  @override
  List<Object> get props => [
    this.domain,
    this.domains,
  ];
}