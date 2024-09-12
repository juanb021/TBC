import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:foodie/data/dummy_data.dart';
import 'package:foodie/providers/plates_provider.dart';

class Collections extends ConsumerWidget {
  const Collections({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final coleccion in colecciones.entries)
            Tooltip(
              message: 'Coleccion ${coleccion.key}',
              child: InkWell(
                onTap: () => ref
                    .read(platosProvider.notifier)
                    .filterByColeccion(coleccion.key),
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 125,
                        width: 190,
                        child: Image.asset(
                          coleccion.value.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: const Color.fromARGB(255, 58, 171, 72),
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Column(
                            children: [
                              Text(
                                coleccion.key,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
