class Post {
  final String title;
  final String body;
  final DateTime datePosted;
  final String image;
  final List<String> tags;
  final bool isFavourite;

  const Post({
    required this.title,
    this.body = 'There is no content available for this post.\n\n'
        'Please check back again soon',
    required this.datePosted,
    required this.image,
    required this.tags,
    required this.isFavourite,
  });
}
