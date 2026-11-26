import 'package:flutter_test/flutter_test.dart';
import 'package:geofield/screens/measure/measure_screen.dart';

void main() {
  group('cálculos do levantamento simulado', () {
    test('quadrado de lado 1 tem área 1 e perímetro 4', () {
      const List<Offset> square = [
        Offset(0, 0),
        Offset(1, 0),
        Offset(1, 1),
        Offset(0, 1),
      ];

      expect(polygonArea(square), 1);
      expect(polygonPerimeter(square), 4);
    });

    test('dois pontos têm área zero e perímetro igual à distância', () {
      const List<Offset> line = [Offset(0, 0), Offset(3, 4)];

      expect(polygonArea(line), 0);
      expect(polygonPerimeter(line), 5);
    });

    test('um ponto ou nenhum ponto resulta em zero', () {
      expect(polygonArea(const [Offset(1, 1)]), 0);
      expect(polygonPerimeter(const [Offset(1, 1)]), 0);
      expect(polygonArea(const <Offset>[]), 0);
      expect(polygonPerimeter(const <Offset>[]), 0);
    });
  });
}
