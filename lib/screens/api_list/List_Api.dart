import 'package:flutter/material.dart';

import '../../notification_services/notification_services.dart';
import '../post_module/Post_List.dart';
import '../product_module/Product_List.dart';
import '../quote_module/Quote_List.dart';

class ListApi extends StatefulWidget {
  const ListApi({super.key});

  @override
  State<ListApi> createState() => _ListApiState();
}

class _ListApiState extends State<ListApi> {

  NotificationServices notificationServices =NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.notificationPermissionServices();
    notificationServices.firebaseInit();
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      debugPrint("Device Token $value");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Fake Api's for Testing"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductList(title: "Products")));

            }, child: const Text('Products')),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PostList(title: "Posts")));

            }, child: const Text('Posts')),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const QuoteList(title: "Quotes")));

            }, child: const Text('Quotes')),
          ],
        ),
      ),
    );
  }
}