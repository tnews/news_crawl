part of tvc_crawl.domain;

class News {
  String id;
  String lang;
  String source;
  String originId;
  List<String> categories;
  String headline;
  String description;
  List<String> contents;
  String htmlContent;
  String url;
  int status;
  String author;
  List<String> authors;
  String thumbnail;
  int publishedTime;

  @override
  String toString() =>
      '$runtimeType title: $headline\nLength: ${contents.length}\n contents: $contents';
}
