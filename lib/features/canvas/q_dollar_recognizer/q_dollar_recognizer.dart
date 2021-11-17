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
import '../q_dollar_recognizer/gesture.dart';
import '../q_dollar_recognizer/point.dart';

/// This class is a direct translation of the $Q Super Quick Recognizer from C# to Dart
class QDollarRecognizer {
  static bool useEarlyAbandoning = true;
  static bool useLowerBounding = false;

  String recognize(Gesture candidate, List<Gesture> trainingSet) {
    var minDistance = double.maxFinite;
    String gesture = "";
    for (Gesture template in trainingSet) {
      double distance = _greedyCloudMatch(candidate, template, minDistance);
      if (distance < minDistance) {
        minDistance = distance;
        gesture = template.name;
      }
    }
    return gesture;
  }

  static double _greedyCloudMatch(Gesture g1, Gesture g2, double currentMin) {
    int totalPoints = g1.points.length;
    int step = pow(totalPoints, 0.5).floor();

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
    List<double> lowerBound = [];
    List<double> summedAreaTable = [];
    lowerBound.add(0);
    for (int i = 0; i < totalPoints; i++) {
      int index = lookupTable[(points1[i].intY ~/ Gesture.lutScaleFactor)]
          [(points1[i].intX ~/ Gesture.lutScaleFactor)];
      double distance =
          Gesture.sqrEuclideanDistance(points1[i], points2[index]);
      summedAreaTable
          .add((i == 0) ? distance : summedAreaTable[i - 1] + distance);
      lowerBound.insert(0, lowerBound[0] += (totalPoints - i) * distance);
    }

    for (int i = step, lowerBoundIndex = 1;
        i < totalPoints;
        i += step, lowerBoundIndex++) {
      lowerBound.insert(
          lowerBoundIndex,
          lowerBound.first +
              i * summedAreaTable[totalPoints - 1] -
              totalPoints * summedAreaTable[i - 1]);
    }
    return lowerBound;
  }

  static double _cloudDistance(List<Point> points1, List<Point> points2,
      int startIndex, double currentMin) {
    int totalPoints = points1.length;

    List<int> indexesNotMatched =
        List<int>.generate(totalPoints, (i) => i, growable: false);

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
