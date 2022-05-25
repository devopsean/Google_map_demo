import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map_flutter/logic/internet_connection/bloc/connection_bloc.dart';
import 'package:google_map_flutter/logic/map/cubit/map_cubit.dart';

import 'package:google_map_flutter/view/pages/home/map_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(
      //  appRouter: AppRouter(),
      connectivity: Connectivity(),
    ),
  );
}

class MyApp extends StatelessWidget {
//  final AppRouter? appRouter;
  final Connectivity? connectivity;

  const MyApp({
    Key? key,
//    @required this.appRouter,
    @required this.connectivity,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MapCubit>(
          create: (BuildContext context) => MapCubit(),
        ),
        BlocProvider<ConnectionBloc>(
          create: (BuildContext context) => ConnectionBloc(),
        ),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: MapPage.id,
        routes: {
          MapPage.id: (context) => MapPage(),
        },
      ),
    );
  }
}
