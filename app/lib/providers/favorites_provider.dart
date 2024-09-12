import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:foodie/models/plato.dart';

class FavoritesNotifier extends StateNotifier<List<Plato>> {
  FavoritesNotifier() : super([]);

  void toogleFavorite(Plato plato) {
    if (state.contains(plato)) {
      state = state.where((item) => item != plato).toList();
    } else {
      state = [...state, plato];
    }
  }

  bool isFavorite(Plato plato) {
    if (state.contains(plato)) {
      return true;
    } else {
      return false;
    }
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<Plato>>(
  (ref) => FavoritesNotifier(),
);
