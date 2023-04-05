class Post {
  final String title;
  final String excerpt;
  final String rendered;
  final String author;
  final String authorPhoto;
  final String date;
  final String img;

  Post({
    required this.title,
    required this.excerpt,
    required this.rendered,
    required this.img,
    required this.author,
    required this.authorPhoto,
    required this.date,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title']['rendered'],
      excerpt: json['excerpt']['rendered'],
      rendered: json['content']['rendered'],
      img: json['jetpack_featured_media_url'] ?? '',
      author: '', //será populado posteriormente
      authorPhoto: '', //será populado posteriormente
      date: json['date'],
    );
  }

  //
  Post copyWith({
    String? title,
    String? excerpt,
    String? rendered,
    String? img,
    String? author,
    String? authorPhoto,
    String? date,
  }) {
    return Post(
      title: title ?? this.title,
      excerpt: excerpt ?? this.excerpt,
      rendered: rendered ?? this.rendered,
      img: img ?? this.img,
      author: author ?? this.author,
      authorPhoto: authorPhoto ?? this.authorPhoto,
      date: date ?? this.date,
    );
  }
}
