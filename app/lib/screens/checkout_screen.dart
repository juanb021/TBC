import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:foodie/models/plato.dart';
import 'package:foodie/models/usuario.dart';
import 'package:foodie/widgets/cart_item.dart';
import 'package:foodie/widgets/cart_total.dart';
import 'package:foodie/providers/shopping_cart_provider.dart';
import 'package:foodie/providers/user_provider.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  void sendMessage(String phoneNumber, String message) async {
    final Uri url = Uri.parse(
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'No se pudo abrir WhatsApp';
    }
  }

  String formatMessage({
    required String nombreUsuario,
    required String direccionUsuario,
    required String documentoUsuario,
    required Map<String, int> pedido,
  }) {
    final StringBuffer message = StringBuffer();

    message.writeln('Hola, quisiera realizar un pedido:');
    message.writeln('Nombre: $nombreUsuario');
    message.writeln('Dirección: $direccionUsuario');
    message.writeln('Documento de Identidad: $documentoUsuario');
    message.writeln('Pedido:');

    pedido.forEach((plato, cantidad) {
      message.writeln('- $plato: $cantidad unidades');
    });

    return message.toString();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<Plato, int> cartItems = ref.watch(shoppingCartProvider);
    Map<String, int> pedido =
        cartItems.map((plato, cantidad) => MapEntry(plato.name, cantidad));

    User? user = ref.watch(userProvider);
    Usuario? usuario = ref.watch(usuarioProvider);

    debugPrint(usuario?.user.toString());

    return SingleChildScrollView(
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tu carrito:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (final item in cartItems.entries)
            CartItem(plato: item.key, ammount: item.value),
          CartTotal(
            ammount: ref.watch(shoppingCartProvider.notifier).totalCost(),
          ),
          const SizedBox(height: 16),
          user != null
              ? usuario == null
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                      onPressed: () {
                        sendMessage(
                            '+584122560218',
                            formatMessage(
                                nombreUsuario: usuario.user.displayName ?? '',
                                direccionUsuario: usuario.direccion,
                                documentoUsuario: usuario.cedula,
                                pedido: pedido));
                        ref.read(shoppingCartProvider.notifier).clearCart();
                      },
                      label: const Text(
                        'Finaliza tu pedido',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 58, 171, 72),
                      ),
                      icon: const Icon(
                        Icons.shopping_cart_checkout,
                        color: Colors.white,
                        size: 28,
                      ),
                    )
              : ElevatedButton.icon(
                  onPressed: () {
                    sendMessage(
                        '+584122560218',
                        formatMessage(
                            nombreUsuario: '',
                            direccionUsuario: '',
                            documentoUsuario: '',
                            pedido: pedido));
                    ref.read(shoppingCartProvider.notifier).clearCart();
                  },
                  label: const Text(
                    'Finaliza tu pedido',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 58, 171, 72),
                  ),
                  icon: const Icon(
                    Icons.shopping_cart_checkout,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
        ],
      ),
    );
  }
}
