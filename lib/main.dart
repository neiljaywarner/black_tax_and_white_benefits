import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'DbProvider.dart';
import 'Post.dart';
import 'article_detail.dart';

Future<List<Post>> fetchPost() async {
  final response = await http.get(Uri.https('blacktaxandwhitebenefits.com','/wp-json/wp/v2/posts?_embed=true&per_page=100'));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return PostResponse.getPosts(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    //todo: fimber and crashlytics
    throw Exception('Failed to load posts');
  }
}

void main() => runApp(MyApp(posts: fetchPost(), key: null,));

class MyApp extends StatefulWidget {
  final Future<List<Post>> posts;

  MyApp({Key? key, required this.posts}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  late ArticleFutureBuilder home;

  @override
  void initState() {
    super.initState();
    home = ArticleFutureBuilder(posts: widget.posts);
  }

  Widget _buildFavoritesWidget(int selectedIndex) {
    if (selectedIndex==1) {
      return ArticleFutureBuilder(posts: DBProvider.db.getAllFavorites());
    } else if (selectedIndex == 2) {
      return AboutPage();
    } else {
      return home;
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Black Tax White Benefits',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text('Black Tax White Benefits')),
        body: Center(
          child: _buildFavoritesWidget(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
          ],
          currentIndex: _selectedIndex,
          fixedColor: Theme.of(context).accentColor,
          onTap: _onItemTapped,
        ),
      ),
    );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class ArticleFutureBuilder extends StatelessWidget {
  const ArticleFutureBuilder({
    Key? key,
    required this.posts,
  }) : super(key: key);

  final Future<List<Post>> posts;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: posts,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          debugPrint("Connection state not done");
          return CircularProgressIndicator();
        }
        debugPrint("Connection state done");

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          debugPrint("has data-data not null");
          return ListView.builder(
              itemCount: snapshot.data?.length,
              padding: const EdgeInsets.all(8.0),
              itemBuilder: (BuildContext _context, int i) => PostCard(post: snapshot.data![i])
          );
        } else if (snapshot.hasError) {
          debugPrint("Has Error ${snapshot.error}");
          return Center(child:Text('No articles or error loading articles.'));
        } else {
          debugPrint("No favorites");
          return Center(child:Text('Star an article an it will show up here!'));
        }
      },
    );
  }
}

class PostCard extends StatelessWidget {

  final Post post;

  PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('**** url = ${post.imageUrl}');
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(post: post))),
      child: Card(
        child: Column(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: post.imageUrl ?? '',
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Image.network('http://blacktaxandwhitebenefits.com/wp-content/uploads/2016/11/hand-1917895_1920.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8),
              child: ListTile(
                title: Text(post.title ?? ''),
                subtitle: Html(data: post.excerpt,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {

  final resourcesHtml = '''
  <img src="https://gordonferguson.org/wp-content/uploads/2016/11/Final-Main-Header.jpg"/>
  <ul>
    <li><a href='http://gordonferguson.org'>gordonferguson.org</a></li>
    <li><a href="https://ipibooks.ecwid.com/#!/Gordon-Ferguson/c/18671194/offset=0&sort=nameAsc">Books, videos (ipi)</a></li>
    <li><a href="mailto:gordonferguson33@gmail.com">Contact</a></li>
    </a></li>
    </ul>
    ''';

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(12),
      child: Html(data: resourcesHtml, onLinkTap: (String? url, _, __, ___) => launch(url!, forceSafariVC: false),),
    );
  }
}
