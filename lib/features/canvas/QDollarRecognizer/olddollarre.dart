// import 'dart:math';

// import '../point.dart';

// class QDollarRecognizer {
//   final List<Point> points;

//   static const NUM_POINT_CLOUDS = 16;
//   static const NUM_POINTS = 32;
//   static final ORIGIN = Point(0, 0, 0);
//   static const MAX_INT_COORD =
//       1024; // (IntX, IntY) range from [0, MaxIntCoord - 1]

//   static const int DEFAULT_CLOUD_SIZE = 32; // size of cloud
//   static const int DEFAULT_LUT_SIZE = 64; // size of the look-up table
//   static const LUT_SCALE_FACTOR = MAX_INT_COORD /
//       DEFAULT_LUT_SIZE; // used to scale from (IntX, IntY) to LUT

//   QDollarRecognizer(this.points);

//   void normalize(List<Point> points) {
//     points = resample(points, NUM_POINTS);
//     points = scale(points);
//     points = translateTo(points, ORIGIN);
//     points = makeIntCoords(points); // fills in (IntX, IntY) values
//     List<dynamic> lut = computeLUT(points);
//   }

//   // Resamples points
//   List<Point> resample(List<Point> points, int n) {
//     var intervalLength = pathLength(points) / (DEFAULT_CLOUD_SIZE - 1);
//     double distance = 0;

//     List<Point> resampledPoints = [];

//     for (int i = 0; i < DEFAULT_CLOUD_SIZE - 1; i++) {
//       final p1 = points[i];
//       final p2 = points[i - 1];
//       if (p1.strokeID == p2.strokeID) {
//         double d = euclideanDistance(p2, p1);
//         if ((distance + d) >= intervalLength) {
//           final px = p2.x + ((intervalLength - distance) / d) * (p1.x - p2.x);
//           final py = p2.y + ((intervalLength - distance) / d) * (p1.y - p2.y);
//           final p = Point.c1(px, py, points[i].strokeID);
//           resampledPoints[resampledPoints.length] = p; // append new point 'p'
//           points.replaceRange(
//               i, i + 1, [p]); // insert 'p' at position i in points
//           distance = 0;
//         } else {
//           distance += d;
//         }
//       }
//     }
//     if (resampledPoints.length == DEFAULT_CLOUD_SIZE - 1) {
//       final p1 = points[points.length - 1].x;
//       final p2 = points[points.length - 1].y;
//       final iD = points[points.length - 1].strokeID;
//       resampledPoints[resampledPoints.length] = Point.c1(p1, p2, iD);
//     }
//     return resampledPoints;
//   }

//   // Returns a list of points translated from the centroid to a specified point
//   List<Point> translateTo(List<Point> points, Point pt) {
//     Point centroid = this.centroid(points);
//     List<Point> translatedPoints = [];

//     for (int i = 0; i < points.length; i++) {
//       final p1 = points[i].x + pt.x - centroid.x;
//       final p2 = points[i].y + pt.y - centroid.y;
//       translatedPoints[translatedPoints.length] =
//           Point.c1(p1, p2, points[i].strokeID);
//     }

//     return translatedPoints;
//   }

//   // make integers into coordinates
//   List<Point> makeIntCoords(List<Point> points) {
//     for (int i = 0; i < points.length; i++) {
//       points[i].intX =
//           ((points[i].x + 1) / (2 * (MAX_INT_COORD - 1)).round()) as int;
//       points[i].intY =
//           ((points[i].y + 1) / (2 * (MAX_INT_COORD - 1)).round()) as int;
//     }
//     return points;
//   }

//   // Compute centroid
//   Point centroid(List<Point> points) {
//     double x = 0, y = 0;
//     for (int i = 0; i < points.length; i++) {
//       x += points[i].x;
//       y += points[i].y;
//     }

//     x /= points.length;
//     y /= points.length;

//     return Point.c1(x, y, 0);
//   }

//   // Returns a list of points scaled to integers in 0...m-1,where m = size of LUT
//   List<Point> scale(List<Point> points) {
//     double xmin = double.infinity;
//     double xmax = double.negativeInfinity;
//     double ymin = double.infinity;
//     double ymax = double.negativeInfinity;

//     for (int i = 0; i < points.length; i++) {
//       xmin = min(xmin, points[i].x);
//       ymin = min(ymin, points[i].y);
//       xmax = max(xmax, points[i].x);
//       ymax = max(ymax, points[i].y);
//     }

//     double size = max(xmax - xmin, ymax - ymin);
//     List<Point> scaledPoints = [];

//     for (int i = 0; i < points.length; i++) {
//       var px = (points[i].x - xmin) / size;
//       var py = (points[i].y - ymin) / size;
//       scaledPoints[scaledPoints.length] = Point.c1(px, py, points[i].strokeID);
//     }

//     return scaledPoints;
//   }

//   void cloudDistance(List<Point> points, List<Point> templates, int n,
//       int start, double minSoFar) {}

//   // Returns a list of lowerbound double values
//   List<double> computeLowerBound(
//       List<Point> points, List<Point> templates, int step, var lut) {
//     var n = points.length;
//     List<double> lowerBound = List<double>.filled((n / step + 1).floor(), 0);
//     var sat = List<double>.filled(n, 0);
//     lowerBound[0] = 0;

//     for (int i = 0; i < n; i++) {
//       double x = (points[i].intX! / LUT_SCALE_FACTOR).roundToDouble();
//       double y = (points[i].intY! / LUT_SCALE_FACTOR).roundToDouble();
//       int index = lut[x][y];
//       double distance = sqrEuclideanDistance(points[i], templates[index]);
//       sat[i] = (i == 0) ? distance : sat[i - 1] + distance;
//       lowerBound[0] += (n - 1) * distance;
//     }

//     for (int i = step, j = 1; i < n; i += step, j++) {
//       lowerBound[j] = lowerBound[0] + i * sat[n - 1] - n * sat[i - 1];
//     }

//     return lowerBound;
//   }

//   // Compute Look up Table (default size: 64 x 64)
//   List<dynamic> computeLUT(List<Point> points) {
//     List lookUpTable = List.empty(growable: true);

//     for (int i = 0; i < DEFAULT_LUT_SIZE; i++) {
//       lookUpTable[i] = List.empty(growable: true);
//       for (int x = 0; x < DEFAULT_LUT_SIZE; x++) {
//         for (int y = 0; y < DEFAULT_LUT_SIZE; y++) {
//           double u = -1;
//           double b = double.infinity;
//           for (int i = 0; i < points.length; i++) {
//             int row = (points[i].intX! / LUT_SCALE_FACTOR).round();
//             int col = (points[i].intY! / LUT_SCALE_FACTOR).round();
//             int d = ((row - x) * (row - x)) + ((col - y) * (col - y));
//             if (d < b) {
//               b = d as double;
//               u = i as double;
//             }
//           }
//           lookUpTable[x][y] = u;
//         }
//       }
//     }
//     return lookUpTable;
//   }

//   // Computes the path length
//   double pathLength(List<Point> points) {
//     double distance = 0.0;
//     for (int x = 1; x < points.length; x++) {
//       if (points[x].strokeID == points[x - 1].strokeID) {
//         distance += euclideanDistance(points[x - 1], points[x]);
//       }
//     }
//     return distance;
//   }

//   // Geometry methods
//   double sqrEuclideanDistance(Point a, Point b) {
//     var dx = a.x - b.x;
//     var dy = a.y - b.y;
//     return (dx * dx + dy * dy);
//   }

//   double euclideanDistance(Point a, Point b) {
//     return sqrt(sqrEuclideanDistance(a, b));
//   }
// }
