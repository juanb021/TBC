import 'package:flutter/material.dart';

class Boton extends StatelessWidget {
  const Boton({
    super.key,
    required this.texto,
    required this.color,
    required this.funcion,
    required this.icono,
  });

  final String texto;
  final Color color;
  final void Function() funcion;
  final IconData icono;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton.icon(
        onPressed: funcion,
        label: Text(
          texto,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        icon: Icon(
          icono,
          color: Colors.white,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          iconColor: Colors.white,
          minimumSize: const Size(double.infinity, 40),
        ),
      ),
    );
  }
}
