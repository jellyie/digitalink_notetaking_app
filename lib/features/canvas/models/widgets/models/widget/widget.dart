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

  const factory Widget.paragraph(
      {String? data,
      @Default(false) bool selected,
      @Default(WidgetType.component) WidgetType type}) = Paragraph;

  const factory Widget.heading(
      {String? data,
      @Default(false) bool selected,
      @Default(WidgetType.component) WidgetType type}) = Heading;

  const factory Widget.blockquote(
      {String? data,
      @Default(false) bool selected,
      @Default(WidgetType.component) WidgetType type}) = Blockquote;

  const factory Widget.bold(
      {String? data,
      @Default(false) bool selected,
      @Default(WidgetType.component) WidgetType type}) = Bold;

  const factory Widget.italicize(
      {String? data,
      @Default(false) bool selected,
      @Default(WidgetType.component) WidgetType type}) = Italicize;

  const factory Widget.bulletedList(
      {String? data,
      @Default(false) bool selected,
      @Default(WidgetType.component) WidgetType type}) = BulletedList;

  const factory Widget.table(
      {String? data,
      @Default(false) bool selected,
      @Default(WidgetType.component) WidgetType type}) = Table;

  const factory Widget.image(
      {String? data,
      @Default(false) bool selected,
      @Default(WidgetType.component) WidgetType type}) = Image;

  const factory Widget.duplicate(
      {String? data,
      @Default(false) bool selected,
      @Default(WidgetType.command) WidgetType type}) = Duplicate;

  const factory Widget.erase(
      {String? data,
      @Default(false) bool selected,
      @Default(WidgetType.command) WidgetType type}) = Erase;

  const factory Widget.split(
      {String? data,
      @Default(false) bool selected,
      @Default(WidgetType.command) WidgetType type}) = Split;

  const factory Widget.newline(
      {String? data,
      @Default(false) bool selected,
      @Default(WidgetType.command) WidgetType type}) = NewLine;

  dynamic get widget => map(

      /// Return a Paragraph Widget
      paragraph: (p) => Text(
            p.data ?? '',
            style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.25),
          ),

      /// Return a Heading Widget
      heading: (h) => Text(
            h.data as String,
            style: const TextStyle(
              fontSize: 96.0,
              fontWeight: FontWeight.w300,
              letterSpacing: -1.5,
            ),
          ),

      /// Return a Blockquote Widget
      blockquote: (b) => Padding(
            padding: const EdgeInsets.fromLTRB(40, 16, 40, 16),
            child: Container(
              child: const Text('Placeholder for blockquote',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.25)),
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    width: 1.0,
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
      bulletedList: (b) => const Text('Placeholder for bulleted list'),

      /// Return a Table Widget
      table: (t) => const Text('Placeholder for table'),

      /// Return an Image Widget
      image: (i) => const Text('Placeholder for image'),

      /// Command Widgets do not return a widget
      /// This may be removed later actually...
      duplicate: (c) {},
      erase: (c) {},
      split: (c) {},
      newline: (c) {});
}
