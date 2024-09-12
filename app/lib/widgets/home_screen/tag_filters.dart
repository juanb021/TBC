import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:foodie/models/plato.dart';
import 'package:foodie/providers/plates_provider.dart';

class TagFilters extends ConsumerWidget {
  const TagFilters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final tag in Tags.values)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Tooltip(
                message: 'Filtro ${tag.name}',
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(platosProvider.notifier).filterByTag(tag);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    backgroundColor: const Color.fromARGB(255, 249, 176, 20),
                  ),
                  child: Text(
                    tag.name.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
