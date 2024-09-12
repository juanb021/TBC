import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/models/plato.dart';
import 'package:foodie/providers/plates_provider.dart';
import 'package:foodie/widgets/home_screen/dishes.dart';

// return Center(
// child: Text(tag.name),
// );

class FilteredPlates extends ConsumerWidget {
  const FilteredPlates({super.key, required this.tag});

  final Tags tag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dwith = MediaQuery.of(context).size.width;
    final platos = ref
        .read(platosProvider)
        .where((plato) => plato.tags.contains(tag))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
          width: dwith < 600 ? 200 : 300,
        ),
      ),
      body: Dishes(platos: platos),
    );
  }
}
