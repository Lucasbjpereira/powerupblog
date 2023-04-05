import 'package:html_unescape/html_unescape.dart';
import 'package:power_up_blog/models/post_model.dart';

String removeHtmlTagsAndConvertSpecialCharacters(String text) {
  return HtmlUnescape()
      .convert(text)
      .replaceAll(RegExp(r'(\n{2,})'), '\n\n')
      .replaceAll(RegExp(r'<[^>]*>'), '');
}

String getPostAuthorAndDate(Post post) {
  return 'Por ${post.author} em ${post.date}';
}
