// import 'package:fake_api/models/Product_Model.dart';
// import 'package:flutter/material.dart';
//
//
//
// class ProductDetails extends StatefulWidget {
//   final Products product;
//
//   const ProductDetails({super.key, required this.product});
//
//   @override
//   State<ProductDetails> createState() => _ProductDetailsState();
// }
//
// class _ProductDetailsState extends State<ProductDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.product.title.toString()),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             SizedBox(
//               height: 300,
//               child: PageView(
//                 children: widget.product.images!.map((url) {
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(15),
//                       child: Image.network(url, fit: BoxFit.cover),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Text(
//                         widget.product.title!,
//                         style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 1,
//                       ),
//                       CircleAvatar(
//                           radius: 20,
//                           backgroundImage: NetworkImage(widget.product.thumbnail
//                               .toString())),
//
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Text(widget.product.description!),
//                   const SizedBox(height: 10),
//                   Text('Price: \$${widget.product.price}',
//                       style: const TextStyle(fontSize: 18)),
//                   const SizedBox(height: 10),
//                   Text('Discount: ${widget.product.discountPercentage}%',
//                       style: const TextStyle(fontSize: 18)),
//                   const SizedBox(height: 10),
//                   Text('Rating: ${widget.product.rating}',
//                       style: const TextStyle(fontSize: 18)),
//                   const SizedBox(height: 10),
//                   Text('Stock: ${widget.product.stock}',
//                       style: const TextStyle(fontSize: 18)),
//                   const SizedBox(height: 10),
//                   Text('Brand: ${widget.product.brand}',
//                       style: const TextStyle(fontSize: 18)),
//                   const SizedBox(height: 10),
//                   Text('Category: ${widget.product.category}',
//                       style: const TextStyle(fontSize: 18)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:fake_api/models/Product_Model.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final Products product;

  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.product.title.toString()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 300,
              child: PageView(
                children: widget.product.images!.map((url) {
                  return ScaleTransition(
                    scale: _scaleAnimation,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(url, fit: BoxFit.cover),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.product.title!,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                        NetworkImage(widget.product.thumbnail.toString()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(widget.product.description!),
                  const SizedBox(height: 10),
                  Text('Price: \$${widget.product.price}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text('Discount: ${widget.product.discountPercentage}%',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text('Rating: ${widget.product.rating}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text('Stock: ${widget.product.stock}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text('Brand: ${widget.product.brand}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text('Category: ${widget.product.category}',
                      style: const TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

