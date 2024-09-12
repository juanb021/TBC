import 'package:flutter/material.dart';

class CartTotal extends StatelessWidget {
  const CartTotal({
    super.key,
    required this.ammount,
  });

  final double ammount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
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
          const Text(
            'Monto total:',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
          ),
          const Spacer(),
          Text(
            '$ammount\$',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
