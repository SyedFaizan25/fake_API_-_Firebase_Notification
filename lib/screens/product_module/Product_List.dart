import 'package:flutter/material.dart';

import '../../api_services/Api_Services.dart';
import '../../models/Product_Model.dart';
import 'ProductDetails_Screen.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key, required this.title});

  final String title;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ApiServices _apiServices = ApiServices();
  List<String> uniqueCategories = [];

  @override
  void initState() {
    // _apiServices.getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: FutureBuilder<ProductModel>(
          future: _apiServices.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading spinner while the data is loading
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Show an error message if the future completed with an error
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 64),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Retry fetching data
                      _apiServices.getProducts();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              // Show the data if the future completed successfully
              return ListView.builder(
                  itemCount: snapshot.data?.products?.length,
                  itemBuilder: (context, index) {
// Creating a unique String list for categories
                    uniqueCategories.clear();
                    for (int i = 0; i <= index; i++) {
                      if (!uniqueCategories.contains(
                          snapshot.data!.products![i].category.toString())) {
                        uniqueCategories.add(
                            snapshot.data!.products![i].category.toString());
                      }
                    }

                    // Now you have the unique categories for this item index

                    debugPrint(uniqueCategories.length.toString());

                    // Now you have the unique categories for this item index
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                      product: snapshot.data!.products![index],
                                    )));
                      },
                      leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(snapshot
                              .data!.products![index].thumbnail
                              .toString())),
                      // child: Image.network(snapshot.data!.products![index].thumbnail.toString())),
                      title: Text(
                          snapshot.data!.products![index].title.toString()),
                    );
                  });
            } else {
              // By default, show an empty container
              return Container();
            }
          },
        ));
  }
}
