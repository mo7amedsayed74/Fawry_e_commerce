import 'product.dart';
import 'customer.dart';
import 'checkout.dart';

void main() {
  var cheese = ShippablePerishableProduct(
    'Cheese',
    100,
    5,
    DateTime.now().add(Duration(days: 2)), // مش منتهي الصلاحيه
    0.2, // 200g
  );

  var biscuits = ShippableNonPerishableProduct(
    'Biscuits',
    150,
    3,
    0.7, // 700g
  );

  var tv = ShippableNonPerishableProduct('TV', 4000, 2, 12.5);

  var mobileCard = NonPerishableProduct('Mobile Scratch Card', 50, 10);

  var expiredCheese = ShippablePerishableProduct(
    'Old Cheese',
    80,
    2,
    DateTime.now().subtract(Duration(days: 1)), // منتهي الصلاحيه
    0.3,
  );

  // create customer
  var customer = Customer('Mohamed Sayed', 8000);

  customer.cart.addItem(cheese, 2);
  customer.cart.addItem(biscuits, 1);
  customer.cart.addItem(mobileCard, 2);
  customer.cart.addItem(tv, 1);

  try {
    checkout(customer);
  } catch (e) {
    print('\n Error: $e');
  }
}
