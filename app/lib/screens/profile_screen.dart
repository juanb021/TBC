import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:foodie/models/usuario.dart';
import 'package:foodie/providers/user_provider.dart';
import 'package:foodie/widgets/profile_screen/login_form.dart';
import 'package:foodie/widgets/profile_screen/profile_info.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _islogin = true;

  void changeLogStatus() {
    setState(() {
      _islogin = !_islogin;
    });
  }

  Future<Usuario?> _loadUserData(User user) async {
    try {
      await ref.read(usuarioProvider.notifier).cargarDatosUsuario(user);
      return ref.read(usuarioProvider);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return Scaffold(
      body: Center(
        child: user == null
            ? LoginForm(
                islogin: _islogin,
                logStatus: changeLogStatus,
              )
            : FutureBuilder<Usuario?>(
                future: _loadUserData(user),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return ProfileInfo(usuario: snapshot.data!);
                  } else {
                    return ProfileInfo(
                        usuario: Usuario(
                      user: user,
                      id: '',
                      cedula: '',
                      telefono: '',
                      direccion: '',
                      pedido: {},
                    ));
                  }
                },
              ),
      ),
    );
  }
}
