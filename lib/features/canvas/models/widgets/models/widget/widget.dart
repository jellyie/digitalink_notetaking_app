import 'package:digitalink_notetaking_app/features/canvas/models/widgets/widget_library/image/image_from_gallery.dart';
import 'package:digitalink_notetaking_app/features/canvas/models/widgets/widget_library/list/list_widget.dart';

import '../../widget_library/table_widget.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'widget.freezed.dart';

enum WidgetType {
  command,
  component,
}

@freezed
class Widget with _$Widget {
  const Widget._();

  const factory Widget.paragraph(dynamic data,
      {@Default(false) bool selected,
      @Default(WidgetType.component) WidgetType type}) = Paragraph;

  const factory Widget.heading(dynamic data,
      {@Default(false) bool selected,
      @Default(WidgetType.component) WidgetType type}) = Heading;

  const factory Widget.blockquote(dynamic data,
      {@Default(false) bool selected,
      @Default(WidgetType.component) WidgetType type}) = Blockquote;

  const factory Widget.bold(dynamic data,
      {@Default(false) bool selected,
      @Default(WidgetType.component) WidgetType type}) = Bold;

  const factory Widget.italicize(dynamic data,
      {@Default(false) bool selected,
      @Default(WidgetType.component) WidgetType type}) = Italicize;

  const factory Widget.bulletedList(dynamic data,
      {@Default(false) bool selected,
      @Default(WidgetType.component) WidgetType type}) = BulletedList;

  const factory Widget.table(dynamic data,
      {@Default(false) bool selected,
      @Default(WidgetType.component) WidgetType type}) = Table;

  const factory Widget.image(dynamic data,
      {@Default(false) bool selected,
      @Default(WidgetType.component) WidgetType type}) = Image;

  const factory Widget.duplicate(dynamic data,
      {@Default(false) bool selected,
      @Default(WidgetType.command) WidgetType type}) = Duplicate;

  const factory Widget.erase(dynamic data,
      {@Default(false) bool selected,
      @Default(WidgetType.command) WidgetType type}) = Erase;

  const factory Widget.split(dynamic data,
      {@Default(false) bool selected,
      @Default(WidgetType.command) WidgetType type}) = Split;

  const factory Widget.newline(
      {dynamic data,
      @Default(false) bool selected,
      @Default(WidgetType.command) WidgetType type}) = NewLine;

  dynamic get widget => map(

      /// Return a Paragraph Widget
      paragraph: (p) => Text(
            p.data ?? '',
            style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.25),
          ),

      /// Return a Heading Widget
      heading: (h) => Text(
            h.data as String,
            style: const TextStyle(
              fontSize: 64.0,
              fontWeight: FontWeight.w300,
              letterSpacing: -1.5,
            ),
          ),

      /// Return a Blockquote Widget
      blockquote: (b) => Padding(
            padding: const EdgeInsets.fromLTRB(40, 16, 40, 16),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
                child: Text('"${b.data}"',
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontStyle: FontStyle.italic,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0.25)),
              ),
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.blueGrey,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),

      /// Return a Bold Widget
      bold: (b) => Text(
            b.data ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

      /// Return an Italicize Widget
      italicize: (i) => Text(
            i.data ?? '',
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),

      /// Return a BulletedList Widget
      bulletedList: (b) => const ListWidget(),

      /// Return a Table Widget
      table: (t) => const TableWidget(),

      /// Return an Image Widget
      image: (i) => const ImageFromGallery(
            imageFile: null,
          ),

      /// Command Widgets do not return a widget
      /// This may be removed later actually...
      duplicate: (c) {},
      erase: (c) {},
      split: (c) {},
      newline: (c) {});
}
