import 'package:test/test.dart';
import 'package:tvc_crawl/tvc_crawl.dart';
import 'package:tvc_crawl/utils/time_converter.dart';

void main() {
  group('Test THINID', () {
    test('character: 4, and max character: 100', () {
      final int testMax = 100;
      final int testNumberCharacter = 4;
      final Set<String> test = <String>{};
      _generate(test, max: testMax, numberCharacter: testNumberCharacter);
    });
    test('character: 5, and max character: 1000', () {
      final int testMax = 1000;
      final int testNumberCharacter = 5;
      final Set<String> test = <String>{};
      _generate(test, max: testMax, numberCharacter: testNumberCharacter);
    });
    test('character: 6, and max character: 10000', () {
      final int testMax = 10000;
      final int testNumberCharacter = 6;
      final Set<String> test = <String>{};
      _generate(test, max: testMax, numberCharacter: testNumberCharacter);
    });
    test('character: 7, and max character: 100000', () {
      final int testMax = 100000;
      final int testNumberCharacter = 7;
      final Set<String> test = <String>{};
      _generate(test, max: testMax, numberCharacter: testNumberCharacter);
    });
    test('character: 8, and max character: 1000000', () {
      final int testMax = 1000000;
      final int testNumberCharacter = 8;
      final Set<String> test = <String>{};
      _generate(test, max: testMax, numberCharacter: testNumberCharacter);
    });
    test('character: 9, and max character: 10000000', () {
      final int testMax = 10000000;
      final int testNumberCharacter = 9;
      final Set<String> test = <String>{};
      _generate(test, max: testMax, numberCharacter: testNumberCharacter);
    });
  });
}

void _generate(Set<String> test, {int max = 125, int numberCharacter = 5}) {
  for (int i = 0; i < max; ++i) {
    final String id = ThinId.randomId(numberCharacter: numberCharacter);
    test.add(id);
    expect(test.length, i + 1);
  }
}
