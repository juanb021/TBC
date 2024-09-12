import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/models/plato.dart';

class ShoppingCartNotifier extends StateNotifier<Map<Plato, int>> {
  ShoppingCartNotifier() : super({});

  void addToCart(Plato plato) {
    if (state.containsKey(plato)) {
      state = {
        ...state,
        plato: state[plato]! + 1,
      };
    } else {
      state = {
        ...state,
        plato: 1,
      };
    }
  }

  void removeFromCart(Plato plato) {
    if (state.containsKey(plato)) {
      final currentQuantity = state[plato]!;
      if (currentQuantity > 1) {
        state = {
          ...state,
          plato: currentQuantity - 1,
        };
      } else {
        final newState = Map<Plato, int>.from(state);
        newState.remove(plato);
        state = newState;
      }
    }
  }

  void clearCart() {
    state = {};
  }

  double totalCost() {
    double total = 0.0;
    state.forEach((plato, quantity) {
      total += plato.cost * quantity;
    });
    return total;
  }
}

final shoppingCartProvider =
    StateNotifierProvider<ShoppingCartNotifier, Map<Plato, int>>(
  (ref) => ShoppingCartNotifier(),
);
