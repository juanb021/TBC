import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/models/plato.dart';
import 'package:foodie/providers/favorites_provider.dart';
import 'package:foodie/providers/shopping_cart_provider.dart';
import 'package:foodie/widgets/dish_details/dish_image.dart';
import 'package:foodie/widgets/dish_details/dish_numbers.dart';
import 'package:foodie/widgets/dish_details/intercaled_list.dart';
import 'package:foodie/widgets/home_screen/descripcion.dart';

class DishDetails extends ConsumerWidget {
  const DishDetails({
    super.key,
    required this.plato,
  });

  final Plato plato;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Plato> favoritePlatos = ref.watch(favoritesProvider);
    bool isFavorite = favoritePlatos.contains(plato);
    final dwith = MediaQuery.of(context).size.width;

    void toogleFavorite() {
      ref.read(favoritesProvider.notifier).toogleFavorite(plato);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: isFavorite
              ? const Text('¡Eliminado de Favoritos!')
              : const Text('¡Agregado a Favoritos!'),
          duration: const Duration(seconds: 3),
        ),
      );
    }

    void agregarCarrito() {
      ref.read(shoppingCartProvider.notifier).addToCart(plato);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Agregado al Carrito!'),
          duration: Duration(seconds: 3),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
          width: dwith < 600 ? 200 : 300,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DishImage(path: plato.previewImage, swidth: dwith),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  plato.name,
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic),
                ),
                IconButton(
                  onPressed: toogleFavorite,
                  icon: isFavorite
                      ? const Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 249, 176, 20),
                        )
                      : const Icon(
                          Icons.star_border,
                          color: Color.fromARGB(255, 58, 171, 72),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DishNumbers(plato: plato),
            const SizedBox(height: 16),
            Tooltip(
              message: 'Añadir al carrito',
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton.icon(
                  label: const Text(
                    'Agregar al Carrito',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: agregarCarrito,
                  icon: const Icon(Icons.add_shopping_cart_outlined),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: const Color.fromARGB(255, 249, 176, 20),
                    iconColor: Colors.white,
                    minimumSize: const Size(double.infinity, 40),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                plato.description,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
                child: Descripcion(titulo: 'Ingredientes', subtitulo: '')),
            const SizedBox(height: 16),
            for (final ingrediente in plato.ingredients.keys)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 58, 171, 72),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 249, 176, 20),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.white, width: 2)),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      ingrediente,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    )
                  ],
                ),
              ),
            const SizedBox(height: 16),
            const Text(
              'Pasos',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            Tooltip(
              message: 'Video Receta',
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton.icon(
                  label: const Text(
                    'Ver la Videoreceta',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.ondemand_video),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: const Color.fromARGB(255, 249, 176, 20),
                    iconColor: Colors.white,
                    minimumSize: const Size(double.infinity, 40),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            IntercaledList(texts: plato.steps, images: plato.images),
            const SizedBox(height: 16),
            Tooltip(
              message: 'Añadir al carrito',
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton.icon(
                  label: const Text(
                    'Agregar al Carrito',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: agregarCarrito,
                  icon: const Icon(Icons.add_shopping_cart_outlined),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: const Color.fromARGB(255, 249, 176, 20),
                    iconColor: Colors.white,
                    minimumSize: const Size(double.infinity, 40),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
