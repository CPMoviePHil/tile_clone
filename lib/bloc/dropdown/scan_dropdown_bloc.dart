import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

part 'scan_dropdown_event.dart';
part 'scan_dropdown_state.dart';

class ScanDropdownBloc extends Bloc<ScanDropdownEvent, ScanDropdownState> {
  ScanDropdownBloc() : super(ScanDropdownInitial());

  @override
  Stream<ScanDropdownState> mapEventToState(
    ScanDropdownEvent event,
  ) async* {
    if (event is ScanDropdownChose) {
      yield ScanDropdownItem(mode: event.mode,);
    }
  }
}
