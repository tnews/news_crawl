part of tvc_crawl.parser;

class VNExpressParser extends NewsParser {
  final List<CategoryParser> parsers;
  VNExpressParser(this.parsers);

  static BuilderVNExpressParser builder() => BuilderVNExpressParser();

  @override
  News parse(Document document) {
    return null;
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
