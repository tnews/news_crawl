part of tvc_crawl.parser;

class VNExpressParser extends NewsParser {
  final List<CategoryParser> parsers;
  VNExpressParser(this.parsers);

  static BuilderVNExpressParser builder() => BuilderVNExpressParser();

  @override
  News parse(Document document) {
    News news;
    for (CategoryParser categoryParser in parsers) {
      news = categoryParser.parse(document);
      if (news is News) break;
    }
    return news;
  }
}

class BuilderVNExpressParser {
  final Set<CategoryParser> categoryParsers = <CategoryParser>{};

  BuilderVNExpressParser add(CategoryParser categoryParser) {
    categoryParsers.add(categoryParser);
    return this;
  }

  VNExpressParser build() => VNExpressParser(categoryParsers.toList());
}

class NewsCategoryVNExpressParser extends CategoryParser {
  @override
  News parse(Document document) {
    try {
      final String title = document.querySelector('.title_news_detail').text;
      final List<String> body = document
              .querySelectorAll('.Normal')
              ?.map((Element element) => element.text)
              ?.where((String text) => text?.isNotEmpty == true)
              ?.toList() ??
          const <String>[];
      if (title is String && body is List<String>) {
        return News()
          ..headline = title
          ..contents = body;
      } else {
        return null;
      }
    } catch (ex) {
      debugPrint('$runtimeType.parse $ex');
      return null;
    }
  }
}
