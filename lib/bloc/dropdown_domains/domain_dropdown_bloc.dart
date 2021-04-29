import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tile_blue/setting/prefs.dart';

part 'domain_dropdown_event.dart';
part 'domain_dropdown_state.dart';

class DomainDropdownBloc extends Bloc<DomainDropdownEvent, DomainDropdownState> {
  DomainDropdownBloc() : super(DomainDropdownInitial());

  @override
  Stream<DomainDropdownState> mapEventToState(
    DomainDropdownEvent event,
  ) async* {
    if (event is DomainDropdownInit) {
      Prefs prefs = Prefs(preferences: await SharedPreferences.getInstance());
      List<String> listOfDomains = prefs.getBackEndDomains();
      yield DomainDropdownItem(
        domains: listOfDomains,
      );
    }
    if (event is DomainDropdownChose) {
      Prefs prefs = Prefs(preferences: await SharedPreferences.getInstance());
      List<String> listOfDomains = prefs.getBackEndDomains();
      yield DomainDropdownChosen(
        domain: event.domain,
        domains: listOfDomains,
      );
    }
  }
}
