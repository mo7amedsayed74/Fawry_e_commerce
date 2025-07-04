import 'dart:io';
import 'product.dart';
import 'customer.dart';

void checkout(Customer customer) {
  final cart = customer.cart;

  if (cart.isEmpty) {
    throw Exception('Cart is empty');
  }

  for (var item in cart.items) {
    if (item.product.isExpired) {
      throw Exception('${item.product.name} is expired');
    }
    if (item.quantity > item.product.quantity) {
      throw Exception('${item.product.name} is out of stock');
    }
  }

  final subtotal = cart.subtotal;
  final shipping = cart.shippingFees;
  final total = subtotal + shipping;

  if (customer.balance < total) {
    throw Exception('Sorry! your balance not enough');
  }

  customer.balance -= total;

  for (var item in cart.items) {
    item.product.quantity -= item.quantity;
  }

  // ** Shipment notice **
  final shippingItems = cart.items
      .where((item) => item.product.requiresShipping)
      .toList();

  if (shippingItems.isNotEmpty) {
    print('\n** Shipment notice **');
    double weight=0;
    double totalWeight = 0;
    for (var item in shippingItems) {
      final product = item.product as ShippingItem;
      stdout.write('${item.quantity}x ${product.getName()}');
      weight = product.getWeight();
      totalWeight += weight;
      stdout.write('\t ${(weight * 1000).toInt()}g\n');
    }
    print('Total package weight ${totalWeight.toStringAsFixed(1)}kg');
  }

  // ** Checkout receipt **
  print('\n** Checkout receipt **');
  for (var item in cart.items) {
    stdout.write('${item.quantity}x ${item.product.name}');
    stdout.write('\t ${(item.product.price * item.quantity).toStringAsFixed(0)}\n');
  }

  print('----------------------');
  print('Subtotal\t ${subtotal.toStringAsFixed(0)}');
  print('Shipping\t ${shipping.toStringAsFixed(0)}');
  print('Amount  \t ${total.toStringAsFixed(0)}');


  // إفراغ السلة بعد الدفع
  cart.items.clear();
}
