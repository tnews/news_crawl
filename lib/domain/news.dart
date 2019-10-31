part of tvc_crawl.domain;

class News {
  final String id;
  final String lang;
  final String source;
  final String originId;
  final List<String> categories;
  final String headline;
  final String description;
  final List<String> contents;
  final String htmlContent;
  final String url;
  final int status;
  final String author;
  final List<String> authors;
  final String thumbnail;
  final int publishedTime;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    addValueToMap('id', id, data);
    addValueToMap('lang', lang, data);
    addValueToMap('source', source, data);
    addValueToMap('originId', originId, data);
    addValueToMap('categories', categories, data);
    addValueToMap('headline', headline, data);
    addValueToMap('description', description, data);
    addValueToMap('contents', contents, data);
    addValueToMap('htmlContent', htmlContent, data);
    addValueToMap('url', url, data);
    addValueToMap('status', status, data);
    addValueToMap('author', author, data);
    addValueToMap('authors', authors, data);
    addValueToMap('thumbnail', thumbnail, data);
    addValueToMap('publishedTime', publishedTime, data);

    return data;
  }

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      lang: json['lang'],
      source: json['source'],
      originId: json['originId'],
      categories: json['categories'],
      headline: json['headline'],
      description: json['description'],
      contents: json['contents'],
      htmlContent: json['htmlContent'],
      url: json['url'],
      status: json['status'],
      author: json['author'],
      authors: json['authors'],
      thumbnail: json['thumbnail'],
      publishedTime: json['publishedTime'],
    );
  }

  News({
    this.id,
    this.lang,
    this.source,
    this.originId,
    this.categories,
    this.headline,
    this.description,
    this.contents,
    this.htmlContent,
    this.url,
    this.status,
    this.author,
    this.authors,
    this.thumbnail,
    this.publishedTime,
  });

  News.randomId({
    this.lang,
    this.source,
    this.originId,
    this.categories,
    this.headline,
    this.description,
    this.contents,
    this.htmlContent,
    this.url,
    this.status,
    this.author,
    this.authors,
    this.thumbnail,
    this.publishedTime,
  }) : id = ThinId.randomIdWithDayAsPrefix();

  @override
  String toString() =>
      '$runtimeType title: $headline\nLength: ${contents.length}\n contents: $contents';
}

void addValueToMap(String key, dynamic value, final Map<String, dynamic> data) {
  if (value != null) data[key] = value;
}
