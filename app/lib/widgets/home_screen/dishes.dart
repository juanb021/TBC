import 'package:flutter/material.dart';

import 'package:foodie/widgets/home_screen/dish_card.dart';
import 'package:foodie/models/plato.dart';

class Dishes extends StatelessWidget {
  const Dishes({
    super.key,
    required this.platos,
  });

  final List<Plato> platos;

  @override
  Widget build(BuildContext context) {
    final dwith = MediaQuery.of(context).size.width;
    return dwith <= 600
        ? ListView.builder(
            itemCount: platos.length,
            itemBuilder: (context, index) {
              final plato = platos[index];
              return DishCard(plato: plato);
            },
          )
        : GridView.builder(
            padding: const EdgeInsets.all(50),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
            ),
            itemCount: platos.length,
            itemBuilder: (context, index) {
              final plato = platos[index];
              return DishCard(plato: plato);
            },
          );
  }
}
