import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:foodie/models/plato.dart';
import 'package:foodie/data/dummy_data.dart';

class PlatosNotifier extends StateNotifier<List<Plato>> {
  PlatosNotifier() : super(platosDisponibles);

  void filterByTag(Tags tag) {
    state = platosDisponibles;
    state = state.where((plato) => plato.tags.contains(tag)).toList();
  }

  void filterByColeccion(String coleccion) {
    state = platosDisponibles;
    state =
        state.where((plato) => plato.coleccion.contains(coleccion)).toList();
  }

  void resetPlates() {
    state = platosDisponibles;
  }
}

final platosProvider = StateNotifierProvider<PlatosNotifier, List<Plato>>(
  (ref) => PlatosNotifier(),
);
