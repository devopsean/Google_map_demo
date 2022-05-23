
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map_flutter/data/constants/enums.dart';

class   MapCubit extends Cubit<MapStyle>{
    MapCubit():super(MapStyle.standard);
    void updateMapStyle (MapStyle style) => emit(style);
}