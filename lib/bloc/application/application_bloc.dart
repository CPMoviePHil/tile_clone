import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tile_blue/setting/prefs.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(ApplicationInitial());

  @override
  Stream<ApplicationState> mapEventToState(
    ApplicationEvent event,
  ) async* {
    if (event is ApplicationInit) {
      final prefs = Prefs(preferences: await SharedPreferences.getInstance());
      prefs.getScanSetting();
      yield ApplicationSettingDone();
    }
  }
}
