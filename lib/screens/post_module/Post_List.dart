import 'package:fake_api/models/Post_Model.dart';
import 'package:flutter/material.dart';

import '../../api_services/Api_Services.dart';
import '../../models/Product_Model.dart';
import 'PostDetails_Screen.dart';

class PostList extends StatefulWidget {
  const PostList({super.key, required this.title});

  final String title;

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
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
        body: FutureBuilder<PostModels>(
          future: _apiServices.getPosts(),
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
                  itemCount: snapshot.data?.posts?.length,
                  itemBuilder: (context, index) {

                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostDetails(
                                      posts: snapshot.data!.posts![index],
                                    )));
                      },
                      // child: Image.network(snapshot.data!.products![index].thumbnail.toString())),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                              snapshot.data!.posts![index].title.toString()),
                          const Divider(),
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
