import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manek_tech/dash_board/dash_board_bloc.dart';
import 'package:manek_tech/themes/themes.dart';
import 'dash_board/dash_board_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>CartBloc()),
      ],
      child: MaterialApp(
        title: 'Manek Tech',
        theme: ThemeData(
          primarySwatch: ThemeColors.primaryColor,
        ),
        home: const DashBoardScreen(),
      ),
    );
  }
}

