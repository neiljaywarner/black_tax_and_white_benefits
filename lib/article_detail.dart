import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_html/flutter_html.dart';

import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'DbProvider.dart';
import 'Post.dart';

class DetailScreen extends StatefulWidget {
  final Post post;

  const DetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}


class _DetailScreenState extends State<DetailScreen> {
  var _shareMessage;
  List<String> favorites = <String>[];

  late int length;

  @override
  void initState() {
    _shareMessage = "Check out this article '${widget.post.title}'\n${widget.post.link}";

    super.initState();

  }

  @override
  Widget build(BuildContext context) => FutureBuilder<Post?>(
      future: DBProvider.db.getNote(widget.post.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container();
        }

        bool isFavorite = snapshot.hasData;
        return Scaffold(
          appBar: AppBar(
              title: const Text("Black Tax White Benefits"),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () => Share.share(_shareMessage),
                ),
                IconButton(
                  icon: isFavorite ? const Icon(Icons.star) : const Icon(Icons.star_border),
                  onPressed: () => toggleFavorite(widget.post, isFavorite),
                  // TODO: border star if already favorites
                ),
              ]),
          body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Card(
                    child: Column(
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: widget.post.imageUrl ?? '',
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Image.network('http://blacktaxandwhitebenefits.com/wp-content/uploads/2016/11/hand-1917895_1920.jpg'),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.post.title ?? '',
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            )),
                        Padding(padding: const EdgeInsets.all(16.0), child: Html(data: widget.post.content)),
                      ],
                    ),
                  )
                ],
              )),
        );
      }
    );

  void toggleFavorite(Post post, bool isCurrentlyFavorite) async {
    if (isCurrentlyFavorite) {
      await DBProvider.db.unFavorite(post);
    } else {
      await DBProvider.db.favorite(post);
    }
    setState(() {
      print("rebuilding after toggling favorite");
      // just rebuild, it will update the star.
    });
  }
}
// extremely slight few lines borrowwed from flutter_wordcamp, and inspiration
// but almost all code diffferent, dependencies different, second screen new,etc