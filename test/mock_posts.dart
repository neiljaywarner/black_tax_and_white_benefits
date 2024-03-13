import 'package:black_tax_and_white_benefits/Post.dart';

List<Post> mockPosts = [
  Post(
    id: 1,
    excerpt: "Hello",
    title: "Article 1",
    link: null,
    imageUrl: null,
    content: "Something big happened",
  ),
  Post(
    id: 2,
    excerpt: "Lorem ipsum",
    title: "Article 2",
    link: null,
    imageUrl: null,
    content: "Something average happened",
  ),
];

Future<List<Post>> fetchMockPosts() async {
  await Future.delayed(const Duration(seconds: 1));
  return mockPosts;
}
