import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:foodie/models/plato.dart';
import 'package:foodie/providers/plates_provider.dart';
import 'package:foodie/widgets/home_screen/dishes.dart';
import 'package:foodie/widgets/home_screen/filters.dart';
import 'package:foodie/widgets/home_screen/descripcion.dart';

class Homestack extends ConsumerWidget {
  const Homestack({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Plato> platos = ref.watch(platosProvider);
    return Column(
      children: [
        const Filters(),
        const SizedBox(height: 16),
        const Descripcion(
            titulo: 'Recetas',
            subtitulo: 'Revisa nuestras recetas disponibles'),
        Expanded(
            child: Dishes(
          platos: platos,
        )),
      ],
    );
  }
}
