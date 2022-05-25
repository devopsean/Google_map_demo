import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_map_flutter/data/constants/enums.dart';

import 'package:google_map_flutter/data/utils/styles.dart';
import 'package:google_map_flutter/logic/map/cubit/map_cubit.dart';

class MenuDrawer extends StatefulWidget {
  MenuDrawer({Key? key, this.context}) : super(key: key);
  final BuildContext? context;

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  List<RadioListTile> mapStyleTiles() {
    List<RadioListTile> styleTiles = [];
    for (MapStyle style in MapStyle.values) {
      styleTiles.add(
        RadioListTile<MapStyle>(
          title:
              Text('${style.name[0].toUpperCase() + style.name.substring(1)}'),
          value: style,
          groupValue: context.watch<MapCubit>().state,
          onChanged: (MapStyle? value) {
            context.read<MapCubit>().updateMapStyle(value!);
          },
        ),
      );
    }

    return styleTiles;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 200,
        height: 400,
 
        child: ClipRRect(  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          child: Drawer(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '     Map Theme',
                          style: robotoGradient_1,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: mapStyleTiles(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
