part of tvc_crawl.domain;

class NewsParserData {
  final String url;
  final Document document;
  final String thumbnail;
  final Type newsParser;

  NewsParserData({
    @required this.url,
    @required this.document,
    this.thumbnail,
    this.newsParser,
  }) : assert(url != null, 'url musn\'t null');

  @override
  String toString() => '$runtimeType url: $url';
}
