///
/// The $Q Point-Cloud Recognizer (.NET Framework C# version)
///
/// 	    Radu-Daniel Vatavu, Ph.D.
///     University Stefan cel Mare of Suceava
///     Suceava 720229, Romania
///     radu.vatavu@usm.ro
///
///     Lisa Anthony, Ph.D.
///      Department of CISE
///      University of Florida
///      Gainesville, FL 32611, USA
///      lanthony@cise.ufl.edu
///
///     Jacob O. Wobbrock, Ph.D.
/// 	    The Information School
///     University of Washington
///     Seattle, WA 98195-2840
///     wobbrock@uw.edu
///
/// The academic publication for the $Q recognizer, and what should be
/// used to cite it, is:
///
/// Vatavu, R.-D., Anthony, L. and Wobbrock, J.O. (2018).
///   $Q: A Super-Quick, Articulation-Invariant Stroke-Gesture
///    Recognizer for Low-Resourc Devices. Proceedings of 20th International Conference on
///    Human-Computer Interaction with Mobile Devices and Services (MobileHCI '18). Barcelona, Spain
///   (September 3-6, 2018). New York: ACM Press.
///   DOI: https://doi.org/10.1145/3229434.3229465
///
/// This software is distributed under the "New BSD License" agreement:
///
/// Copyright (c) 2018, Radu-Daniel Vatavu, Lisa Anthony, and
/// Jacob O. Wobbrock. All rights reserved.
///
/// Redistribution and use in source and binary forms, with or without
/// modification, are permitted provided that the following conditions are met:
///    * Redistributions of source code must retain the above copyright
///      notice, this list of conditions and the following disclaimer.
///    * Redistributions in binary form must reproduce the above copyright
///      notice, this list of conditions and the following disclaimer in the
///      documentation and/or other materials provided with the distribution.
///    * Neither the names of the University Stefan cel Mare of Suceava,
///     University of Washington, nor University of Florida, nor the names of its contributors
///     may be used to endorse or promote products derived from this software
///     without specific prior written permission.
///
/// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
/// IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
/// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
/// PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Radu-Daniel Vatavu OR Lisa Anthony
/// OR Jacob O. Wobbrock BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
/// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
/// OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
/// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
/// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
/// OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
/// SUCH DAMAGE.
///

import 'dart:math';
import '../q_dollar_recognizer/point.dart';

/// Implements a gesture as a cloud of points (i.e., an unordered set of points).
/// For $P, gestures are normalized with respect to scale, translated to origin, and resampled into a fixed number of 32 points.
/// For $Q, a LUT is also computed.
class Gesture {
  List<Point> points = [];
  List<Point> rawPoints = [];
  String name = '';

  static const int _samplingResolution = 64;
  static const int _maxIntCoordinates = 1024;
  static int lutSize = 64;
  static int lutScaleFactor = 16;

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
    List<Point> resampledPoints =
        List.filled(n, points.isNotEmpty ? points[0] : Point(0, 0));

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
                (1.0 - t) * firstPoint.y + t * points[i].y,
                points[i].strokeID);
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
      if (xmin > points[i].x) xmin = points[i].x;
      if (ymin > points[i].y) ymin = points[i].y;
      if (xmax < points[i].x) xmax = points[i].x;
      if (ymax < points[i].y) ymax = points[i].y;
    }

    double scale = max(xmax - xmin, ymax - ymin);
    List<Point> scaledPoints = [];

    for (int i = 0; i < points.length; i++) {
      var px = (points[i].x - xmin) / scale;
      var py = (points[i].y - ymin) / scale;
      scaledPoints.add(Point(px, py, points[i].strokeID));
    }

    return scaledPoints;
  }

  /// Translates a list of points by p
  List<Point> translateTo(List<Point> points, Point p) {
    List<Point> translatedPoints = [];

    for (int i = 0; i < points.length; i++) {
      translatedPoints
          .add(Point(points[i].x - p.x, points[i].y - p.y, points[i].strokeID));
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

    return Point(cx / points.length, cy / points.length, 0);
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
          int minDistance = double.maxFinite.ceil();
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

  /// Geometry methods
  static double sqrEuclideanDistance(Point a, Point b) {
    return (a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y);
  }

  static double euclideanDistance(Point a, Point b) {
    return sqrt(sqrEuclideanDistance(a, b));
  }
}
