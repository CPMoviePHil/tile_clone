import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tile_blue/app.dart';
import 'package:tile_blue/bloc/application/application_bloc.dart';
import 'package:tile_blue/bloc/dropdown/scan_dropdown_bloc.dart';
import 'package:tile_blue/bloc/dropdown_domains/domain_dropdown_bloc.dart';
import 'package:tile_blue/bloc/observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ApplicationBloc>(
          create: (BuildContext context) => ApplicationBloc(),
        ),
        BlocProvider<ScanDropdownBloc>(
          create: (BuildContext context) => ScanDropdownBloc(),
        ),
        BlocProvider<DomainDropdownBloc>(
          create: (BuildContext context) => DomainDropdownBloc(),
        ),
      ],
      child: App(),
    ),
  );
}
