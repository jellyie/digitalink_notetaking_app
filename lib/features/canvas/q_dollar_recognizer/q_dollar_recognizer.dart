import 'dart:math';

import '../q_dollar_recognizer/gesture.dart';
import '../q_dollar_recognizer/point.dart';
import '../q_dollar_recognizer/templates.dart';

class QDollarRecognizer {
  static bool useEarlyAbandoning = true;
  static bool useLowerBounding = false;
  static final List<Gesture> _templateSet = Templates.templates;

  String recognize(Gesture candidate) {
    var minDistance = double.maxFinite;
    String gesture = "";
    for (Gesture template in _templateSet) {
      double distance = _greedyCloudMatch(template, candidate, minDistance);
      if (distance < minDistance) {
        minDistance = distance;
        gesture = template.name;
      }
    }
    return gesture;
  }

  static double _greedyCloudMatch(Gesture g1, Gesture g2, double currentMin) {
    int totalPoints = g1.points.length;
    int step = pow(totalPoints, 0.5).toInt();

    if (useLowerBounding) {
      List<double> lb1 = _computeLowerBound(g1.points, g2.points, g2.lut, step);
      List<double> lb2 = _computeLowerBound(g2.points, g1.points, g1.lut, step);

      for (int i = 0, lowerBoundIndex = 0;
          i < totalPoints;
          i += step, lowerBoundIndex++) {
        if (lb1[lowerBoundIndex] < currentMin) {
          currentMin = min(
              currentMin, _cloudDistance(g1.points, g2.points, i, currentMin));
        }
        if (lb2[lowerBoundIndex] < currentMin) {
          currentMin = min(
              currentMin, _cloudDistance(g2.points, g1.points, i, currentMin));
        }
      }
    } else {
      for (int i = 0; i < totalPoints; i += step) {
        currentMin = min(
            currentMin, _cloudDistance(g1.points, g2.points, i, currentMin));
        currentMin = min(
            currentMin, _cloudDistance(g2.points, g1.points, i, currentMin));
      }
    }
    return currentMin;
  }

  static List<double> _computeLowerBound(List<Point> points1,
      List<Point> points2, List<List<int>> lookupTable, int step) {
    int totalPoints = points1.length;
    List<double> lowerBound = List.filled((totalPoints ~/ step + 1), 0);
    List<double> summedAreaTable = List.filled(totalPoints, 0);

    for (int i = 0; i < totalPoints; i++) {
      int index = lookupTable[(points1[i].intY ~/ Gesture.lutScaleFactor)]
          [(points1[i].intX ~/ Gesture.lutScaleFactor)];
      double distance =
          Gesture.sqrEuclideanDistance(points1[i], points2[index]);
      summedAreaTable[i] =
          (i == 0) ? distance : summedAreaTable[i - 1] + distance;
      lowerBound[0] += (totalPoints - i) * distance;
    }

    for (int i = step, lowerBoundIndex = 1;
        i < totalPoints;
        i += step, lowerBoundIndex++) {
      lowerBound[lowerBoundIndex] = lowerBound[0] +
          i * summedAreaTable[totalPoints - 1] -
          totalPoints * summedAreaTable[i - 1];
    }
    return lowerBound;
  }

  static double _cloudDistance(List<Point> points1, List<Point> points2,
      int startIndex, double currentMin) {
    int totalPoints = points1.length;

    List<int> indexesNotMatched =
        List.generate(totalPoints, (i) => i, growable: false);

    double sum = 0;
    int i = startIndex;
    int weight = totalPoints;
    int indexNotMatched = 0;

    do {
      int index = -1;
      double minDistance = double.maxFinite;
      for (int j = indexNotMatched; j < totalPoints; j++) {
        double distance = Gesture.sqrEuclideanDistance(
            points1[i], points2[indexesNotMatched[j]]);
        if (distance < minDistance) {
          minDistance = distance;
          index = j;
        }
      }
      indexesNotMatched[index] = indexesNotMatched[indexNotMatched];
      sum += (weight--) * minDistance;

      if (useEarlyAbandoning) {
        if (sum >= currentMin) return sum;
      }

      i = (i + 1) % totalPoints;
      indexNotMatched++;
    } while (i != startIndex);
    return sum;
  }
}
