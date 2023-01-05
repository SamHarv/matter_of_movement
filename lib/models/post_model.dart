import 'package:hive/hive.dart';

part 'post_model.g.dart';

@HiveType(typeId: 0)
class Post extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String body;
  @HiveField(2)
  final DateTime datePosted;
  @HiveField(3)
  final String image;
  @HiveField(4)
  final List<String> tags;

  Post({
    required this.title,
    this.body = 'There is no content available for this post.\n\n'
        'Please check back again soon',
    required this.datePosted,
    required this.image,
    required this.tags,
  });

  @override
  bool operator ==(Object other) {
    if (other is Post) {
      return other.title == title &&
          other.image == image &&
          other.datePosted == datePosted;
    }
    return false;
  }

  @override
  int get hashCode => title.hashCode ^ image.hashCode ^ datePosted.hashCode;
}
