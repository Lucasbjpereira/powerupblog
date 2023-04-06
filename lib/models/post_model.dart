/*
* @description Classe que representa um Post do blog.
* @param String title: titulo do Post.
* @param String excerpt: resumo do Post.
* @param String rendered: conteúdo do Post.
* @param String img: imagem do Post.
* @param String author: autor do Post.
* @param String authorPhoto: foto do autor do Post.
* @param String date: data de publicação do Post.
*/
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

  /*
  * @description Constrói um objeto Post a partir de um mapa de dados JSON.
  * @param Map<String, dynamic> json: Mapa de dados JSON com as informações do Post.
  * @return: Objeto Post criado a partir dos dados do mapa.
  */
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title']['rendered'],
      excerpt: json['excerpt']['rendered'],
      rendered: json['content']['rendered'],
      img: json['jetpack_featured_media_url'] ?? '',
      author: '',
      authorPhoto: '',
      date: json['date'],
    );
  }

  /*
  * @description Cria uma cópia do objeto Post com os parâmetros fornecidos.
  * @param String? title: novo título para o Post.
  * @param String? excerpt: novo resumo para o Post.
  * @param String? rendered: novo conteúdo para o Post.
  * @param String? img: nova imagem para o Post.
  * @param String? author: novo autor para o Post.
  * @param String? authorPhoto: nova foto do autor para o Post.
  * @param String? date: nova data de publicação para o Post.
  * @return: Nova instância do objeto Post com os parâmetros fornecidos.
  */
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
