import 'package:test/test.dart';
import 'package:tvc_crawl/tvc_crawl.dart';

void main() {
  group('Convert time', () {
    test('Text To String Time 1: OK', () {
      final DateTime time =
          TimeConverter.stringToDateTime('Thứ sáu, 11/10/2019, 22:12 (GMT+7)');
      expect(time, DateTime(2019, 10, 11, 22, 12));
    });
    test('Text To String Time 2: OK', () {
      final DateTime time =
          TimeConverter.stringToDateTime('Thứ hai, 14/10/2019, 15:07 (GMT+7)');
      expect(time, DateTime(2019, 10, 14, 15, 07));
    });
    test('Text To String Time 3: NULL OK', () {
      final DateTime time = TimeConverter.stringToDateTime(null);
      expect(time, isNull);
    });
    test('Text To String Time 4: is not a time: OK', () {
      final DateTime time = TimeConverter.stringToDateTime('sdfghjkl;');
      expect(time, isNull);
    });
  });
}
