part of 'scan_dropdown_bloc.dart';

abstract class ScanDropdownEvent extends Equatable {
  const ScanDropdownEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ScanDropdownChose extends ScanDropdownEvent {
  final ScanMode mode;
  const ScanDropdownChose({this.mode});
  @override
  // TODO: implement props
  List<Object> get props => [this.mode,];
}
