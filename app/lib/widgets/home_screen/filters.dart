import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/providers/plates_provider.dart';

import 'package:foodie/widgets/home_screen/collections.dart';

class Filters extends ConsumerWidget {
  const Filters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Colecciones',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              TextButton.icon(
                onPressed: ref.read(platosProvider.notifier).resetPlates,
                label: const Text(
                  'Reiniciar filtros',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                icon: const Icon(
                  Icons.restart_alt_sharp,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Collections()
      ],
    );
  }
}
