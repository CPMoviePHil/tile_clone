import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tile_blue/app.dart';
import 'package:tile_blue/bloc/dropdown/scan_dropdown_bloc.dart';
import 'package:tile_blue/bloc/observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ScanDropdownBloc>(
          create: (BuildContext context) => ScanDropdownBloc(),
        ),
      ],
      child: App(),
    ),
  );
}
