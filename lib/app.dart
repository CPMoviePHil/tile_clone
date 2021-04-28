import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tile_blue/bloc/application/application_bloc.dart';
import 'package:tile_blue/screen/export.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<ApplicationBloc>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'bluetooth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<ApplicationBloc, ApplicationState>(
        builder: (context, state) {
          if (state is ApplicationInitial) {
            appBloc.add(ApplicationInit());
            return CircularProgressIndicator();
          } else {
            return MainPage();
          }
        },
      ),
    );
  }
}