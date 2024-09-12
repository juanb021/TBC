import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/models/plato.dart';
import 'package:foodie/providers/favorites_provider.dart';
import 'package:foodie/widgets/home_screen/descripcion.dart';
import 'package:foodie/widgets/home_screen/dishes.dart';

class FavoriteMealsScreen extends ConsumerWidget {
  const FavoriteMealsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Plato> platos = ref.watch(favoritesProvider);
    if (platos.isEmpty) {
      return const Center(
        child: Text('No tienes favoritos!'),
      );
    }
    return Column(
      children: [
        const Descripcion(
            titulo: 'Tu seleccion de recetas favoritas!', subtitulo: ''),
        Expanded(
          child: Dishes(platos: platos),
        ),
      ],
    );
  }
}
