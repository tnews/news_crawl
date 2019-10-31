part of tvc_crawl.parser;

class VNExpressParser extends NewsParser {
  final List<CategoryParser> parsers;
  VNExpressParser(this.parsers);

  static BuilderVNExpressParser builder() => BuilderVNExpressParser();

  @override
  News parse(HtmlData htmlData) {
    News news;
    for (CategoryParser categoryParser in parsers) {
      news = categoryParser.parse(htmlData);
      if (news?.isNews() == true) break;
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
  News parse(HtmlData htmlData) {
    final Document document = htmlData.document;
    try {
      final int time = _convertTimeToInt(_getTime(document));
      final String title = _getTitle(document);
      final String description = _getDescription(document);
      final String htmlContents = _getHtmlContents(document);
      final List<BaseNewsContent> contents = _getContents(document);
      final String author = _getAuthor(document);
      final List<String> authors = _getAuthors(author);

      if (title is String && contents is List<BaseNewsContent>) {
        return News.randomId(
          lang: 'vn',
          source: 'vnexpress.net',
          categories: <String>['thoi_su'],
          headline: title,
          description: description,
          contents: contents,
          author: author,
          authors: authors,
          htmlContent: htmlContents,
          thumbnail: htmlData.thumbnail,
          url: htmlData.url,
          publishedTime: time,
        );
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

  String _getHtmlContents(Document document) {
    final String query = '.sidebar_1 > article.content_detail';

    return document.querySelector(query).innerHtml;
  }

  List<BaseNewsContent> _getContents(Document document) {
    final List<BaseNewsContent> contents = <BaseNewsContent>[];
    final String query = '.sidebar_1 > article.content_detail';
    final Element detail = document.querySelector(query);
    if (detail != null) {
      for (Node node in detail.nodes) {
        BaseNewsContent content = _tryGetImageContent(node);
        content ??= _tryGetTextContent(node);
        if (content != null) contents.add(content);
      }
    }
    return contents;
  }

  ImageContent _tryGetImageContent(Node node) {
    if (node is Element) {
      final List<Element> elements = node.getElementsByTagName('img');
      if (elements?.isNotEmpty == true) {
        final Element element = _getFirstElementHaveImage(elements);
        final String imageUrl = element.attributes['src'];
        final String text = element.attributes['alt'];
        return ImageContent(imageUrl, text);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  TextContent _tryGetTextContent(Node node) {
    if (node is Element && node.className == 'Normal') {
      final String text = node?.text?.trim();
      if (text?.isNotEmpty == true) {
        return TextContent(text);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Element _getFirstElementHaveImage(List<Element> elements) {
    return elements.firstWhere(
      (Element element) => element.attributes != null && element.attributes['src'] is String,
      orElse: () => null,
    );
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

  List<String> _getAuthors(String author) {
    if (author is String) {
      return author
          .split('-')
          .where((String item) => item?.trim()?.isNotEmpty)
          .map((String item) => item.trim())
          .toList();
    } else {
      return null;
    }
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
