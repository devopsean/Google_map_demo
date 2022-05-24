import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_map_flutter/data/constants/enums.dart';
import 'package:google_map_flutter/data/utils/color_palette.dart';
import 'package:google_map_flutter/data/utils/dimensions.dart';
import 'package:google_map_flutter/data/utils/helpers.dart';
import 'package:google_map_flutter/data/utils/styles.dart';
import 'package:google_map_flutter/logic/map/cubit/map_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MenuDrawer extends StatefulWidget {
  MenuDrawer({Key? key, this.context}) : super(key: key);
  final BuildContext? context;

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  MapStyle _mapStyle = MapStyle.standard;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Stack(
          children: <Widget>[
            BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0), //this is dependent on the import statment above
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(
                    0.6,
                  ),
                ),
              ),
            ),
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
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Map Theme   ',
                      style: robotoGradient_1,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RadioListTile<MapStyle>(
                    title: const Text('Standard'),
                    value: MapStyle.standard,
                    groupValue: _mapStyle,
                    onChanged: (MapStyle? value) {
                      context.read<MapCubit>().updateMapStyle(value!);
                      setState(() {
                        _mapStyle = value;
                      });
                    },
                  ),
                  RadioListTile<MapStyle>(
                    title: const Text('Night'),
                    value: MapStyle.night,
                    groupValue: _mapStyle,
                    onChanged: (MapStyle? value) {
                      context.read<MapCubit>().updateMapStyle(value!);
                      setState(() {
                        _mapStyle = value;
                      });
                    },
                  ),
                  RadioListTile<MapStyle>(
                    title: const Text('Silver'),
                    value: MapStyle.silver,
                    groupValue: _mapStyle,
                    onChanged: (MapStyle? value) {
                      context.read<MapCubit>().updateMapStyle(value!);
                      setState(() {
                        _mapStyle = value;
                      });
                    },
                  ),
                  RadioListTile<MapStyle>(
                    title: const Text('Aubergine'),
                    value: MapStyle.aubergine,
                    groupValue: _mapStyle,
                    onChanged: (MapStyle? value) {
                      context.read<MapCubit>().updateMapStyle(value!);
                      setState(() {
                        _mapStyle = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
