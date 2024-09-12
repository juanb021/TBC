import 'package:flutter/foundation.dart';
import 'package:foodie/models/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null) {
    _firebaseAuth.authStateChanges().listen((User? user) {
      state = user;
    });
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, User?>((ref) => UserNotifier());

class UsuarioNotifier extends StateNotifier<Usuario?> {
  UsuarioNotifier() : super(null);

  Future<void> cargarDatosUsuario(User user) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        Usuario usuario = Usuario(
          user: user,
          id: data['id'] ?? '',
          cedula: data['cedula'] ?? '',
          telefono: data['telefono'] ?? '',
          direccion: data['direccion'] ?? '',
          pedido: data['pedido'] != null
              ? Map<String, int>.from(data['pedido'])
              : {},
        );

        state = usuario;
      } else {
        throw Exception('Usuario no encontrado');
      }
    } catch (e) {
      // Manejar errores aquí si es necesario
      state = null;
      rethrow;
    }
  }

  Future<void> actualizarDatosUsuario({
    required String telefono,
    required String cedula,
    required String direccion,
    required Map<String, int> pedido,
    required String email,
    required String name,
  }) async {
    if (state == null) return;

    try {
      User user = state!.user;

      // Update email and display name in Firebase Auth
      if (user.email != email) {
        await user.verifyBeforeUpdateEmail(email);
      }
      if (user.displayName != name) {
        await user.updateProfile(displayName: name);
      }

      // Update Firestore document
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .update({
        'telefono': telefono,
        'cedula': cedula,
        'direccion': direccion,
        'pedido': pedido,
      });

      state = state!.copyWith(
        telefono: telefono,
        cedula: cedula,
        direccion: direccion,
        pedido: pedido,
      );
      debugPrint('Actualización exitosa');
    } catch (e) {
      // Manejar errores aquí si es necesario
      debugPrint("Error actualizando datos: $e");
      rethrow;
    }
  }
}

final usuarioProvider = StateNotifierProvider<UsuarioNotifier, Usuario?>(
    (ref) => UsuarioNotifier());
