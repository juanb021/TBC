import 'package:flutter/material.dart';
import 'package:foodie/models/plato.dart';

class DishNumbers extends StatelessWidget {
  const DishNumbers({
    super.key,
    required this.plato,
  });

  final Plato plato;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Tooltip(
          message: 'Tiempo de coccion',
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black45,
                ),
                borderRadius: BorderRadius.circular(5)),
            child: TextButton.icon(
              onPressed: () {},
              label: Text(
                plato.time.inMinutes.toString(),
                style: const TextStyle(
                  color: Colors.black45,
                  fontSize: 25,
                ),
              ),
              icon: const Icon(
                Icons.timer_outlined,
                size: 34,
                color: Colors.black45,
              ),
            ),
          ),
        ),
        Tooltip(
          message: 'Calificacion',
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black45,
                ),
                borderRadius: BorderRadius.circular(5)),
            child: TextButton.icon(
              onPressed: () {},
              label: Text(
                plato.rating.toString(),
                style: const TextStyle(
                  color: Colors.black45,
                  fontSize: 25,
                ),
              ),
              icon: const Icon(
                Icons.star,
                size: 34,
                color: Colors.black45,
              ),
            ),
          ),
        ),
        Tooltip(
          message: 'Precio',
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black45,
                ),
                borderRadius: BorderRadius.circular(5)),
            child: TextButton.icon(
              onPressed: () {},
              label: Text(
                plato.cost.toString(),
                style: const TextStyle(
                  color: Colors.black45,
                  fontSize: 25,
                ),
              ),
              icon: const Icon(
                Icons.attach_money,
                size: 34,
                color: Colors.black45,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
