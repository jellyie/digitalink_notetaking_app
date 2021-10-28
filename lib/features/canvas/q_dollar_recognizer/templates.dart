import 'dart:collection';

import 'gesture.dart';
import 'point.dart';

class Templates {
  static final List<Gesture> _templates = [
    Gesture([
      Point(307, 216, 1),
      Point(333, 186, 2),
      Point(356, 215, 3),
      Point(375, 186, 4),
      Point(399, 216, 5),
      Point(418, 186, 6)
    ], name: 'zig zag'),
    Gesture([
      Point(177, 554, 1),
      Point(223, 476, 1),
      Point(268, 554, 1),
      Point(183, 554, 1),
      Point(177, 490, 2),
      Point(223, 568, 2),
      Point(268, 490, 2),
      Point(183, 490, 2)
    ], name: 'six-point star'),
    Gesture([
      Point(177, 92, 1),
      Point(177, 2, 1),
      Point(182, 1, 2),
      Point(246, 95, 2),
      Point(247, 87, 3),
      Point(247, 1, 3)
    ], name: 'N'),
    Gesture([
      Point(507, 8, 1),
      Point(507, 87, 1),
      Point(513, 7, 2),
      Point(528, 7, 2),
      Point(537, 8, 2),
      Point(544, 10, 2),
      Point(550, 12, 2),
      Point(555, 15, 2),
      Point(558, 18, 2),
      Point(560, 22, 2),
      Point(561, 27, 2),
      Point(562, 33, 2),
      Point(561, 37, 2),
      Point(559, 42, 2),
      Point(556, 45, 2),
      Point(550, 48, 2),
      Point(544, 51, 2),
      Point(538, 53, 2),
      Point(532, 54, 2),
      Point(525, 55, 2),
      Point(519, 55, 2),
      Point(513, 55, 2),
      Point(510, 55, 2)
    ], name: 'P')
  ];

  static UnmodifiableListView<Gesture> get templates =>
      UnmodifiableListView(_templates);
}
