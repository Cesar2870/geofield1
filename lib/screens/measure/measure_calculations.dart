import 'package:material_ui/material_ui.dart';

// Cálculos locais usados por Medir terreno e Detalhes do levantamento.
//
// As coordenadas são tratadas como pares (longitude, latitude) em um plano
// simples. Não há conversão para metros: os valores servem apenas para
// comparação entre levantamentos enquanto o GPS real não é integrado.

/// Área do polígono por Shoelace/Gauss.
double polygonArea(List<Offset> points) {
  if (points.length < 3) return 0;
  double sum = 0;
  for (int i = 0; i < points.length; i++) {
    final Offset current = points[i];
    final Offset next = points[(i + 1) % points.length];
    sum += current.dx * next.dy - next.dx * current.dy;
  }
  return (sum / 2).abs();
}

/// Soma das distâncias euclidianas. Com 2 pontos, é a distância entre eles
/// (não vai e volta). Com 3 ou mais, o polígono é fechado.
double polygonPerimeter(List<Offset> points) {
  if (points.length < 2) return 0;
  if (points.length == 2) return (points[1] - points[0]).distance;
  double total = 0;
  for (int i = 0; i < points.length; i++) {
    total += (points[(i + 1) % points.length] - points[i]).distance;
  }
  return total;
}
