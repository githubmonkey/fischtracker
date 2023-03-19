import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromMap', () {
    test('cat with all properties', () {
      final cat = Cat.fromMap(const {'name': 'Research'}, 'id_abc');
      expect(cat, const Cat(name: 'Research', id: 'id_abc'));
    });

    test('missing name', () {
      expect(() => Cat.fromMap(const {}, 'id_abc'),
          throwsA(isInstanceOf<TypeError>()));
    });
  });

  group('toMap', () {
    test('valid name', () {
      const cat = Cat(name: 'Research', id: 'id_abc');
      expect(cat.toMap(), {'name': 'Research'});
    });
  });

  group('equality', () {
    test('different properties, equality returns false', () {
      const cat1 = Cat(name: 'Research', id: 'abc');
      const cat2 = Cat(name: 'Admin', id: 'abc');
      expect(cat1 == cat2, false);
    });

    test('different id, equality returns false', () {
      const cat1 = Cat(name: 'Research', id: 'abc');
      const cat2 = Cat(name: 'Research', id: 'edf');
      expect(cat1 == cat2, false);
    });

    test('same properties, equality returns true', () {
      const cat1 = Cat(name: 'Research', id: 'abc');
      const cat2 = Cat(name: 'Research', id: 'abc');
      expect(cat1 == cat2, true);
    });
  });
}
