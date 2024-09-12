import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:foodie/models/plato.dart';
import 'package:foodie/screens/filtered_plates.dart';
import 'package:foodie/widgets/home_screen/descripcion.dart';

class GuidesScreen extends ConsumerWidget {
  const GuidesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Descripcion(
              titulo: 'Nuestros platos',
              subtitulo: '',
            ),
          ],
        ),
        for (final tag in Tags.values)
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => FilteredPlates(
                        tag: tag,
                      )));
            },
            child: Card(
              color: const Color.fromARGB(255, 58, 171, 72),
              elevation: 5,
              margin: const EdgeInsets.all(10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  tag.name.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
