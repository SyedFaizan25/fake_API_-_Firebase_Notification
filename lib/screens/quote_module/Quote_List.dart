import 'package:flutter/material.dart';
import '../../api_services/Api_Services.dart';
import '../../models/Quote_Model.dart';
import 'QuoteDetails_Screen.dart';

class QuoteList extends StatefulWidget {
  const QuoteList({super.key, required this.title});

  final String title;

  @override
  State<QuoteList> createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
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
        body: FutureBuilder<QuotesModel>(
          future: _apiServices.getQuotes(),
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
                  itemCount: snapshot.data?.quotes?.length,
                  itemBuilder: (context, index) {
                    // Now you have the unique categories for this item index
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuoteDetails(
                                    quote: snapshot.data!.quotes![index])));
                      },
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot.data!.quotes![index].author.toString()),
                          const Divider()
                        ],
                      ),
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
