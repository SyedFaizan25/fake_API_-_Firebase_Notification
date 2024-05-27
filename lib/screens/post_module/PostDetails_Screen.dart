// import 'package:flutter/material.dart';
//
// import '../../models/Post_Model.dart';
//
//
//
// class PostDetails extends StatefulWidget {
//   final Posts posts;
//
//   const PostDetails({super.key, required this.posts});
//
//   @override
//   State<PostDetails> createState() => _PostDetailsState();
// }
//
// class _PostDetailsState extends State<PostDetails> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.posts.title.toString()),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.posts.title.toString(),
//               style: const TextStyle(
//                 fontSize: 24.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10.0),
//             Text(
//               widget.posts.body.toString(),
//               style: const TextStyle(fontSize: 16.0),
//             ),
//             const SizedBox(height: 20.0),
//             Wrap(
//               spacing: 8.0,
//               children: List.generate(
//                 widget.posts.tags!.length,
//                     (index) => Chip(
//                   label: Text(widget.posts.tags![index].toString()),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10.0),
//             Text(
//               '${widget.posts.reactions.toString()} reactions',
//               style: const TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../../models/Post_Model.dart';

class PostDetails extends StatefulWidget {
  final Posts posts;

  const PostDetails({super.key, required this.posts});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
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
        title: Text(widget.posts.title.toString()),
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _animation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.posts.title.toString(),
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                widget.posts.body.toString(),
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 20.0),
              Wrap(
                spacing: 8.0,
                children: List.generate(
                  widget.posts.tags!.length,
                      (index) => Chip(
                    label: Text(widget.posts.tags![index].toString()),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                '${widget.posts.reactions.toString()} reactions',
                style: const TextStyle(
                  fontSize: 14.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
