import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laza_app/features/auth/auth_service.dart';
//import '../../core/services/auth_service.dart';
import 'cart_service.dart';

class CartScreen extends StatelessWidget {
  final cartService = CartService();
  final authService = AuthService();

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = authService.currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: StreamBuilder<QuerySnapshot>(
        stream: cartService.getCartItems(userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final items = snapshot.data!.docs;
          if (items.isEmpty) return const Center(child: Text('Cart is empty'));

          double subtotal = 0;
          for (var item in items) {
            subtotal += (item['price'] as num) * (item['quantity'] as num);
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      leading: Image.network(item['image'], width: 50),
                      title: Text(item['title']),
                      subtitle: Text('\$${item['price']} x ${item['quantity']}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => cartService.removeFromCart(userId, item.id),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('Subtotal: \$${subtotal.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        key: const Key('checkout_button'),
                        onPressed: () async {
                          await cartService.clearCart(userId);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Checkout successful')));
                        },
                        child: const Text('Checkout'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
