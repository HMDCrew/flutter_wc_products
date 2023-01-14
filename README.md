# WooCommerce products module for Flutter (null-safe)
This module is created for manage products in flutter
copy the "products" folder into the application of your flutter project

## Getting Started
File -> pubspec.yaml

```yaml
dependencies:
  flutter:
    sdk: flutter
  # Declare products path in this file to use module in your project
  products:
    path: ./products
```

Widget example file:
```dart
// declare this variables to use it in your dart file
static String baseUrl = "https://dev-dominewptest.pantheonsite.io";
static Client client = Client();
static ProductsApi productsApi = ProductsApi(client, baseUrl);

String search = '';
String productId = '';
String tempValue = '';
```

## Example search products
```dart
TextField(
  decoration: const InputDecoration(
    hintText: 'Search products',
  ),
  onChanged: (val) {
    search = val;
  },
),
ElevatedButton(
  onPressed: () async {
    final result = await productsApi.findProducts(page: 0, pageSize: 10, searchTerm: search);
    setState(() {
      tempValue = result.asValue!.value.toString();
    });
  },
  child: Container(
    child: Text('Search'),
  ),
),
```

## Example get products
```dart
ElevatedButton(
  onPressed: () async {
    final result = await productsApi.getAllProducts(page: 0, pageSize: 10);
    setState(() {
      tempValue = result.asValue!.value.toString();
    });
  },
  child: Container(
    child: Text('getAllProducts'),
  ),
),
```

## Example get product
```dart
TextField(
  decoration: const InputDecoration(
    hintText: 'Product Id',
  ),
  onChanged: (val) {
    productId = val;
  },
),
ElevatedButton(
  onPressed: () async {
    final result = await productsApi.getProduct(productId: productId);
    setState(() {
      tempValue = result.asValue!.value.toString();
    });
  },
  child: Container(
    child: Text('Get Products'),
  ),
),
```

### Note:
Requirement plugins:
- [JWT Authentication for WP REST API](https://wordpress.org/plugins/jwt-authentication-for-wp-rest-api/)
- [Customn routes in plugin](https://github.com/HMDCrew/REST-API-WP-Woo)
