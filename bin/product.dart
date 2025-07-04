abstract class Product {
  final String name;
  final double price;
  int quantity;

  Product(this.name, this.price, this.quantity);

  bool get isExpired => false;

  bool get requiresShipping => false;
}

// منتج قابل للفساد و غير قابل للشحن
class PerishableProduct extends Product {
  final DateTime expiryDate;

  PerishableProduct(super.name, super.price, super.quantity, this.expiryDate);

  @override
  bool get isExpired => DateTime.now().isAfter(expiryDate);
}

// غير قابل للفساد و غير قابل للشحن
class NonPerishableProduct extends Product {
  NonPerishableProduct(super.name, super.price, super.quantity);
}

abstract class ShippingItem {
  String getName();
  double getWeight();
}

// منتج قابل للشحن و قابل للفساد
class ShippablePerishableProduct extends PerishableProduct implements ShippingItem {
  final double weight;

  ShippablePerishableProduct(super.name, super.price, super.quantity, super.expiryDate, this.weight);

  @override
  bool get requiresShipping => true;

  @override
  String getName() => name;

  @override
  double getWeight() => weight;
}

// منتج قابل للشحن و غير قابل للفساد
class ShippableNonPerishableProduct extends NonPerishableProduct implements ShippingItem {
  final double weight;

  ShippableNonPerishableProduct(super.name, super.price, super.quantity, this.weight);

  @override
  bool get requiresShipping => true;

  @override
  String getName() => name;

  @override
  double getWeight() => weight;
}



