import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:foodie/models/plato.dart';
import 'package:foodie/providers/shopping_cart_provider.dart';

class CartItem extends ConsumerWidget {
  const CartItem({super.key, required this.plato, required this.ammount});

  final Plato plato;
  final int ammount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 249, 176, 20),
            Color.fromARGB(255, 58, 171, 72),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: [
          Text(
            plato.name,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const Spacer(),
          Text(
            '${(plato.cost * ammount).toString()} \$',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              ref.read(shoppingCartProvider.notifier).removeFromCart(plato);
            },
            icon: const Icon(
              Icons.remove_circle_outline,
              color: Colors.white,
            ),
          ),
          Text(
            ammount.toString(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
          ),
          IconButton(
            onPressed: () {
              ref.read(shoppingCartProvider.notifier).addToCart(plato);
            },
            icon: const Icon(
              Icons.add_circle_outline,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
