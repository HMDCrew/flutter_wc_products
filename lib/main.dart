import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:products/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static String baseUrl = "https://dev-panasonic.pantheonsite.io/";
  static Client client = Client();
  static ProductsApi productsApi = ProductsApi(client, baseUrl);

  String search = '';
  String productId = '';
  String tempValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                const SizedBox(height: 100.0),
                Text(tempValue),

                // Search function
                TextField(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16.0),
                    hintText: 'Search products',
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onChanged: (val) {
                    search = val;
                  },
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () async {
                    final result = await productsApi.findProducts(page: 0, pageSize: 10, searchTerm: search);
                    setState(() {
                      tempValue = result.asValue!.value.toString();
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Search',
                      style: Theme.of(context).textTheme.button?.copyWith(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),

                // getAllProducts
                ElevatedButton(
                  onPressed: () async {
                    final result = await productsApi.getAllProducts(page: 0, pageSize: 10);
                    setState(() {
                      tempValue = result.asValue!.value.toString();
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'getAllProducts',
                      style: Theme.of(context).textTheme.button?.copyWith(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),

                // getProduct
                TextField(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16.0),
                    hintText: 'Product Id',
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onChanged: (val) {
                    productId = val;
                  },
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () async {
                    final result = await productsApi.getProduct(productId: productId);
                    setState(() {
                      tempValue = result.asValue!.value.toString();
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Get Products',
                      style: Theme.of(context).textTheme.button?.copyWith(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
