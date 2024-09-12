import 'package:firebase_auth/firebase_auth.dart';

class Usuario {
  final User user;
  final String id;
  final String cedula;
  final String telefono;
  final String direccion;
  final Map<String, int> pedido;

  Usuario({
    required this.user,
    required this.id,
    required this.cedula,
    required this.telefono,
    required this.direccion,
    required this.pedido,
  });

  Usuario copyWith({
    User? user,
    String? id,
    String? cedula,
    String? telefono,
    String? direccion,
    Map<String, int>? pedido,
  }) {
    return Usuario(
      user: user ?? this.user,
      id: id ?? this.id,
      cedula: cedula ?? this.cedula,
      telefono: telefono ?? this.telefono,
      direccion: direccion ?? this.direccion,
      pedido: pedido ?? this.pedido,
    );
  }
}
