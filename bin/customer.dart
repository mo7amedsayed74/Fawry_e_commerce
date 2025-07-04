import 'product.dart';

class Customer {
  String name;
  double balance;
  final Cart cart = Cart();

  Customer(this.name, this.balance);
}

class Cart {
  final List<CartItem> items = [];

  void addItem(Product product, int quantity) {
    if (quantity > product.quantity) {
      throw Exception('Quantity exceeds stock');
    }
    items.add(CartItem(product, quantity));
  }

  bool get isEmpty => items.isEmpty;

  double get subtotal =>
      items.fold(0, (sum, item) => sum + item.product.price * item.quantity);

  double get shippingFees => items
      .where((item) => item.product is ShippingItem)
      .fold(0, (sum, item) =>
  sum + (item.product as ShippingItem).getWeight() * 10);
}

class CartItem {
  final Product product;
  final int quantity;

  CartItem(this.product, this.quantity);
}


