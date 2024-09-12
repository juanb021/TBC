import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:foodie/models/plato.dart';
import 'package:foodie/models/usuario.dart';
import 'package:foodie/providers/user_provider.dart';
import 'package:foodie/widgets/profile_screen/boton.dart';

class ProfileInfo extends ConsumerStatefulWidget {
  const ProfileInfo({
    super.key,
    required this.usuario,
  });

  final Usuario usuario;

  @override
  ConsumerState<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends ConsumerState<ProfileInfo> {
  final _uform = GlobalKey<FormState>();
  String _enteredName = '';
  String _enteredEmail = '';
  String _enteredCel = '';
  String _enteredDir = '';
  String _enteredDNI = '';
  Map<String, int> pedido = {};

  Map<String, int> convertCartToMap(Map<Plato, int> cart) {
    return cart.map((plato, quantity) => MapEntry(plato.name, quantity));
  }

  void submit() async {
    if (!_uform.currentState!.validate()) {
      return;
    }

    _uform.currentState!.save();

    ref.watch(usuarioProvider.notifier).actualizarDatosUsuario(
          telefono: _enteredCel,
          cedula: _enteredDNI,
          direccion: _enteredDir,
          pedido: {},
          email: _enteredEmail,
          name: _enteredName,
        );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Datos actualizados de manera exitosa'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Usuario cuenta = widget.usuario;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 58, 171, 72),
                  Color.fromARGB(255, 249, 176, 20),
                ],
              ),
            ),
            child: Form(
                key: _uform,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      initialValue: cuenta.user.displayName,
                      decoration: const InputDecoration(
                        labelText: 'Nombre de usuario',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      autocorrect: false,
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Por favor introduce un Nombre';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredName = value!;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: cuenta.user.email,
                      decoration: const InputDecoration(
                        labelText: 'Correo Electronico',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                        if (value == null ||
                            value.trim().isEmpty ||
                            !emailRegex.hasMatch(value)) {
                          return 'Por favor introduce un correo electrónico correcto';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredEmail = value!;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: cuenta.cedula,
                      decoration: const InputDecoration(
                        labelText: 'Cedula de Identidad',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      autocorrect: false,
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Por favor introduce un Numero de cedula correcto';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredDNI = value!;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: cuenta.telefono,
                      decoration: const InputDecoration(
                        labelText: 'Numero de telefono',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      autocorrect: false,
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        const pattern = r'^\+58\d{10}$|^\d{11}$';
                        final regExp = RegExp(pattern);

                        if (value == null ||
                            value.trim().isEmpty ||
                            !regExp.hasMatch(value)) {
                          return 'Por favor introduce un número de telefono adecuado';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredCel = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: cuenta.direccion,
                      decoration: const InputDecoration(
                        labelText: 'Direccion',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      autocorrect: false,
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Por favor introduce una direccion';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredDir = value!;
                      },
                    ),
                  ],
                )),
          ),
          const SizedBox(height: 16),
          Boton(
            texto: 'Actualizar datos',
            icono: Icons.edit_outlined,
            color: const Color.fromARGB(255, 58, 171, 72),
            funcion: submit,
          ),
          const SizedBox(height: 16),
          Boton(
              texto: 'Cerrar Sesion',
              icono: Icons.exit_to_app,
              color: const Color.fromARGB(255, 249, 176, 20),
              funcion: () {
                FirebaseAuth.instance.signOut();
              })
        ],
      ),
    );
  }
}
