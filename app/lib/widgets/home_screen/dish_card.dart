import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/models/plato.dart';
import 'package:foodie/providers/shopping_cart_provider.dart';
import 'package:foodie/screens/dish_details.dart';

class DishCard extends ConsumerWidget {
  const DishCard({
    super.key,
    required this.plato,
  });

  final Plato plato;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dwith = MediaQuery.of(context).size.width;

    return Tooltip(
      message: plato.name,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (contex) => DishDetails(plato: plato),
            ),
          );
        },
        child: Card(
          clipBehavior: Clip.hardEdge,
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Stack(
            children: [
              SizedBox(
                height: dwith < 600 ? 200 : double.infinity,
                width: double.infinity,
                child: Image.asset(
                  plato.previewImage,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: const Color.fromARGB(255, 58, 171, 72),
                  child: Column(
                    children: [
                      Text(
                        plato.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton.icon(
                            onPressed: () {},
                            label: Text(
                              '${plato.time.inMinutes.toString()} Mins',
                              style: const TextStyle(color: Colors.white),
                            ),
                            icon: const Icon(
                              Icons.timer_outlined,
                              color: Colors.white,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            label: Text(
                              plato.rating.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            icon: const Icon(
                              Icons.star,
                              color: Colors.white,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            label: Text(
                              plato.cost.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            icon: const Icon(
                              Icons.attach_money,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: Tooltip(
                  message: 'Añadir al carrito',
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 249, 176, 20),
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ref
                            .read(shoppingCartProvider.notifier)
                            .addToCart(plato);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('¡Agregado al Carrito!'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_shopping_cart_rounded),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
