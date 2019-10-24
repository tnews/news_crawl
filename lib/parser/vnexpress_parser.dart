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
      final int time = _convertTimeToInt(_getTime(document));
      final String title = _getTitle(document);
      final String description = _getDescription(document);
      final List<String> body = _getBody(document);

      final String author = _getAuthor(document);

      if (title is String && body is List<String>) {
        return News()
          ..lang = 'vn'
          ..source = 'vnexpress.net'
          ..headline = title
          ..description = description
          ..contents = body
          ..author = author
          ..authors = <String>[author]
          ..htmlContent = document.outerHtml
          ..publishedTime = time;
      } else {
        return null;
      }
    } catch (ex) {
      debugPrint('$runtimeType.parse $ex');
      return null;
    }
  }

  String _getTitle(Document document) {
    final String title = document.querySelector('.title_news_detail')?.text;
    return title;
  }

  List<String> _getBody(Document document) {
    final List<String> body = document
            .querySelectorAll('.Normal')
            ?.where((Element element) => element.children.isEmpty)
            ?.map((Element element) =>
                StringConverter.removeNewsLine(element.text))
            ?.where((String text) => text?.isNotEmpty == true)
            ?.toList() ??
        const <String>[];
    return body;
  }

  String _getTime(Document document) {
    final String time = document.querySelector('.time')?.text;
    _convertTimeToInt(time);
    return time;
  }

  String _getDescription(Document document) {
    final String query = '.sidebar_1 > .description';
    Element element = document.querySelector(query);
    if (element?.nodes?.length == 2) {
      final String description = element.nodes[1].text;
      return description;
    } else
      return null;
  }

  String _getAuthor(Document document) {
    final String query = '.Normal > strong';
    final String author = document.querySelector(query).text;
    return author;
  }
}

int _convertTimeToInt(String time) {
  try {
    final DateTime dateTime = TimeConverter.stringToDateTime(time);
    return dateTime.millisecondsSinceEpoch;
  } catch (ex) {
    debugPrint('Error._convertTimeToInt $ex');
    return null;
  }
}
