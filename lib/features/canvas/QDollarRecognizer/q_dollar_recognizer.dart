import 'dart:ffi';
import 'dart:math';

import '../point.dart';

class QDollarRecognizer {
  final List<Point> points;
  final List<Point> templates;
  static const NUM_POINT_CLOUDS = 16;
  static const NUM_POINTS = 32;
  static final ORIGIN = Point.c1(0, 0, 0);
  static const MAX_INT_COORD =
      1024; // (IntX, IntY) range from [0, MaxIntCoord - 1]

  static const int DEFAULT_CLOUD_SIZE = 32; // size of cloud
  static const int DEFAULT_LUT_SIZE = 64; // size of the look-up table
  static const LUT_SCALE_FACTOR = MAX_INT_COORD /
      DEFAULT_LUT_SIZE; // used to scale from (IntX, IntY) to LUT

  QDollarRecognizer(this.points, this.templates);

  void normalize(List<Point> points, int n, int m) {}

  void resample(List<Point> points, int n) {}

  void translate(List<Point> points, int n) {}

  void scale(List<Point> points, int m) {}

  void cloudDistance(List<Point> points, List<Point> templates, int n,
      int start, double minSoFar) {}

  void computeLowerBound(
      List<Point> points, List<Point> templates, int step, Array lut) {}

  // Compute Look up Table (default size: 64 x 64)
  List<dynamic> computeLUT(List<Point> points) {
    List lookUpTable = List.empty(growable: true);

    for (int i = 0; i < DEFAULT_LUT_SIZE; i++) {
      lookUpTable[i] = List.empty(growable: true);
      for (int x = 0; x < DEFAULT_LUT_SIZE; x++) {
        for (int y = 0; y < DEFAULT_LUT_SIZE; y++) {
          double u = -1;
          double b = double.infinity;
          for (int i = 0; i < points.length; i++) {
            int row = (points[i].intX! / LUT_SCALE_FACTOR).round();
            int col = (points[i].intY! / LUT_SCALE_FACTOR).round();
            int d = ((row - x) * (row - x)) + ((col - y) * (col - y));
            if (d < b) {
              b = d as double;
              u = i as double;
            }
          }
          lookUpTable[x][y] = u;
        }
      }
    }
    return lookUpTable;
  }

  // Computes the path length
  double pathLength(List<Point> points) {
    double distance = 0.0;
    for (int x = 1; x < points.length; x++) {
      if (points[x].strokeID == points[x - 1].strokeID) {
        distance += euclideanDistance(points[x - 1], points[x]);
      }
    }
    return distance;
  }

// Geometry methods
  double sqrEuclideanDistance(Point a, Point b) {
    var dx = a.x - b.x;
    var dy = a.y - b.y;
    return (dx * dx + dy * dy);
  }

  double euclideanDistance(Point a, Point b) {
    return sqrt(sqrEuclideanDistance(a, b));
  }
}
