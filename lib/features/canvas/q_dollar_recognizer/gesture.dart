import 'dart:math';
import '../q_dollar_recognizer/point.dart';

/// Implements a gesture as a cloud of points (i.e., an unordered set of points).
/// For $P, gestures are normalized with respect to scale, translated to origin, and resampled into a fixed number of 32 points.
/// For $Q, a LUT is also computed.
class Gesture {
  List<Point> points = []; // gesture points (normalized)
  List<Point> rawPoints =
      []; // gesture points (not normalized, as captured from the input device)
  String name = ''; // gesture class

  static const int _samplingResolution =
      64; // default number of points on the gesture path
  static const int _maxIntCoordinates =
      1024; // $Q only: each point has two additional x and y integer coordinates in the interval [0..MAX_INT_COORDINATES-1] used to operate the LUT table efficiently (O(1))
  static int lutSize =
      64; // $Q only: the default size of the lookup table is 64 x 64
  static int lutScaleFactor =
      16; // $Q only: scale factor to convert between integer x and y coordinates and the size of the LUT

  List<List<int>> lut = List.generate(
      64, (i) => List.filled(64, 0, growable: false),
      growable: false); // Lookup table

  /// Constructs a gesture from a list of points
  Gesture(this.points, {this.name = ''}) {
    rawPoints = List<Point>.of(points, growable: false);
    normalize();
    print('\n\nGesture: $name \n'); // for debugging..
  }

  /// Normalizes the gesture path.
  /// The $Q recognizer requires an extra normalization step, the computation of the LUT,
  /// which can be enabled with the computeLUT parameter.
  void normalize({bool computeLUT = true}) {
    points = resample(rawPoints, _samplingResolution);
    points = _scale(points);
    points = translateTo(points, centroid(points));

    if (computeLUT) {
      _makeIntCoords();
      _makeLUT();
    }
  }

  /// Resamples a list of points into n equally-distanced points
  List<Point> resample(List<Point> points, int n) {
    List<Point> resampledPoints = List.filled(n, points[0]);

    double interval = _pathLength(points) / (n - 1);
    double distance = 0;
    int numPoints = 1;

    for (int i = 1; i < points.length; i++) {
      final p1 = points[i], p2 = points[i - 1];
      if (p1.strokeID == p2.strokeID) {
        double d = euclideanDistance(points[i - 1], points[i]);
        if (distance + d >= interval) {
          Point firstPoint = points[i - 1];
          while (distance + d >= interval) {
            double t = min(max((interval - distance) / d, 0.0), 1.0);
            if (t.isNaN) t = 0.5;
            resampledPoints[numPoints++] = Point(
                (1.0 - t) * firstPoint.x + t * points[i].x,
                (1.0 - t) * firstPoint.y + t * points[i].y);
            d = distance + d - interval;
            distance = 0;
            firstPoint = resampledPoints[numPoints - 1];
          }
          distance = d;
        } else {
          distance += d;
        }
      }
    }

    if (numPoints == n - 1) {
      final p1 = points[points.length - 1].x;
      final p2 = points[points.length - 1].y;
      final iD = points[points.length - 1].strokeID;
      resampledPoints[numPoints++] = Point(p1, p2, iD);
    }
    return resampledPoints;
  }

  /// Performs scale normalization with shape preservation into [0..1]x[0..1]
  List<Point> _scale(List<Point> points) {
    double xmin = double.maxFinite,
        xmax = double.minPositive,
        ymin = double.maxFinite,
        ymax = double.minPositive;

    for (int i = 0; i < points.length; i++) {
      xmin = min(xmin, points[i].x);
      ymin = min(ymin, points[i].y);
      xmax = max(xmax, points[i].x);
      ymax = max(ymax, points[i].y);
    }

    double scale = max(xmax - xmin, ymax - ymin);
    List<Point> scaledPoints = List.filled(points.length, Point(0, 0));

    for (int i = 0; i < points.length; i++) {
      var px = (points[i].x - xmin) / scale;
      var py = (points[i].y - ymin) / scale;
      scaledPoints[i] = Point(px, py, points[i].strokeID);
    }

    return scaledPoints;
  }

  /// Translates a list of points by p
  List<Point> translateTo(List<Point> points, Point p) {
    List<Point> translatedPoints = List.filled(points.length, Point(0, 0));

    for (int i = 0; i < points.length; i++) {
      translatedPoints[i] =
          Point(points[i].x - p.x, points[i].y - p.y, points[i].strokeID);
    }

    return translatedPoints;
  }

  /// Computes the centroid for a list of points
  Point centroid(List<Point> points) {
    double cx = 0, cy = 0;
    for (int i = 0; i < points.length; i++) {
      cx += points[i].x;
      cy += points[i].y;
    }

    cx /= points.length;
    cy /= points.length;

    return Point(cx, cy, 0);
  }

  /// Computes the path length for a list of points
  double _pathLength(List<Point> points) {
    double length = 0.0;
    for (int x = 1; x < points.length; x++) {
      if (points[x].strokeID == points[x - 1].strokeID) {
        length += euclideanDistance(points[x - 1], points[x]);
      }
    }
    return length;
  }

  /// Scales point coordinates to the integer domain [0..MAXINT-1] x [0..MAXINT-1]
  void _makeIntCoords() {
    for (int i = 0; i < points.length; i++) {
      var x1 = (points[i].x + 1) ~/ 2.0;
      var y1 = (points[i].y + 1) ~/ 2.0;
      var d = (_maxIntCoordinates - 1);
      points[i].intX = x1.isNaN ? 0 : (x1 * d);
      points[i].intY = y1.isNaN ? 0 : (y1 * d);
    }
  }

  /// Constructs a Lookup Table that maps grip points to the closest point from the gesture path
  void _makeLUT() {
    for (int i = 0; i < lutSize; i++) {
      lut[i] = List.filled(lutSize, 0);

      for (int x = 0; x < lutSize; x++) {
        for (int y = 0; y < lutSize; y++) {
          int minIndex = -1;
          int minDistance = double.maxFinite.toInt();
          for (int i = 0; i < points.length; i++) {
            int row = points[i].intY ~/ lutSize;
            int col = points[i].intX ~/ lutSize;
            int d = (row - x) * (row - x) + (col - y) * (col - y);
            if (d < minDistance) {
              minDistance = d;
              minIndex = i;
            }
          }
          lut[x][y] = minIndex;
        }
      }
    }
  }

  // Geometry methods
  static double sqrEuclideanDistance(Point a, Point b) {
    return (a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y);
  }

  static double euclideanDistance(Point a, Point b) {
    return sqrt(sqrEuclideanDistance(a, b));
  }
}
