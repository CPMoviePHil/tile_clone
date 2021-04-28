part of 'scan_dropdown_bloc.dart';

abstract class ScanDropdownState extends Equatable {
  const ScanDropdownState();
  @override
  List<Object> get props => [];
}

class ScanDropdownInitial extends ScanDropdownState {

}

class ScanDropdownItem extends ScanDropdownState {
  final ScanMode mode;
  ScanDropdownItem({this.mode});

  @override
  // TODO: implement props
  List<Object> get props => [this.mode,];
}