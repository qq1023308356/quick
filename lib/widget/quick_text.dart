import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui show TextHeightBehavior;

import '../quick.dart';
import '../quick_config.dart';
import '../quick_style.dart';

class QuickText extends StatefulWidget {
  /// The text to display.
  ///
  /// This will be null if a [textSpan] is provided instead.
  final data;

  /// If non-null, the style to use for this text.
  ///
  /// If the style's "inherit" property is true, the style will be merged with
  /// the closest enclosing [DefaultTextStyle]. Otherwise, the style will
  /// replace the closest enclosing [DefaultTextStyle].
  final TextStyle style;

  /// {@macro flutter.painting.textPainter.strutStyle}
  final StrutStyle strutStyle;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the [data] is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any.
  final TextDirection textDirection;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  final Locale locale;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  final bool softWrap;

  /// How visual overflow should be handled.
  final TextOverflow overflow;

  /// The number of font pixels for each logical pixel.
  ///
  /// For example, if the text scale factor is 1.5, text will be 50% larger than
  /// the specified font size.
  ///
  /// The value given to the constructor as textScaleFactor. If null, will
  /// use the [MediaQueryData.textScaleFactor] obtained from the ambient
  /// [MediaQuery], or 1.0 if there is no [MediaQuery] in scope.
  final double textScaleFactor;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  ///
  /// If this is null, but there is an ambient [DefaultTextStyle] that specifies
  /// an explicit number for its [DefaultTextStyle.maxLines], then the
  /// [DefaultTextStyle] value will take precedence. You can use a [RichText]
  /// widget directly to entirely override the [DefaultTextStyle].
  final int maxLines;

  /// An alternative semantics label for this text.
  ///
  /// If present, the semantics of this widget will contain this value instead
  /// of the actual text. This will overwrite any of the semantics labels applied
  /// directly to the [TextSpan]s.
  ///
  /// This is useful for replacing abbreviations or shorthands with the full
  /// text value:
  ///
  /// ```dart
  /// Text(r'$$', semanticsLabel: 'Double dollars')
  /// ```
  final String semanticsLabel;

  /// {@macro flutter.painting.textPainter.textWidthBasis}
  final TextWidthBasis textWidthBasis;

  /// {@macro flutter.dart:ui.textHeightBehavior}
  final ui.TextHeightBehavior textHeightBehavior;
  final QuickStyle quickStyle;
  final bool isTitleStyle;
  final bool autoLines;

  const QuickText(
    this.data, {
    Key key,
    this.quickStyle,
    this.isTitleStyle = true,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow = TextOverflow.ellipsis,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.autoLines = false,
  })  : assert(
          data is RxString || data is String,
          'data only is RxString or String',
        ),
        super();

  @override
  State<StatefulWidget> createState() => _QuickTextState();
}

class _QuickTextState extends State<QuickText> {
  @override
  Widget build(BuildContext context) {
    final inheritedWidget = QuickInheritedWidget.of(context);
    if (widget.data is RxString) {
      return Obx(
        () {
          return buildText(inheritedWidget, widget.data.value);
        },
      );
    } else {
      return buildText(inheritedWidget, widget.data);
    }
  }

  Text buildText(QuickInheritedWidget inheritedWidget, String text) {
    return Text(
      text,
      key: widget.key,
      style: widget.style ?? (widget.isTitleStyle
          ? widget.quickStyle?.titleStyle ??
          inheritedWidget.getStyle(widget.quickStyle?.copyId)?.titleStyle ??
          inheritedWidget.quickStyle?.titleStyle ??
          QuickConfig.instance.style?.titleStyle ??
          null
          : widget.quickStyle?.detailStyle ??
          inheritedWidget
              .getStyle(widget.quickStyle?.copyId)
              ?.detailStyle ??
          inheritedWidget.quickStyle?.detailStyle ??
          QuickConfig.instance.style?.detailStyle ??
          null),
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign ??
          widget.quickStyle?.textAlign ??
          inheritedWidget.getStyle(widget.quickStyle?.copyId)?.textAlign ??
          inheritedWidget.quickStyle?.textAlign ??
          QuickConfig.instance.style?.textAlign ??
          null,
      textDirection: widget.textDirection,
      locale: widget.locale,
      softWrap: widget.softWrap,
      maxLines: widget.autoLines ? null : 1,
      overflow: widget.autoLines ? null : TextOverflow.ellipsis,
      textScaleFactor: widget.textScaleFactor,
      semanticsLabel: widget.semanticsLabel,
      textWidthBasis: widget.textWidthBasis,
      textHeightBehavior: widget.textHeightBehavior,
    );
  }

  @override
  void dispose() {
    if (widget.data is RxString) {
      var rx = (widget.data as RxString);
      if (rx.subject.isClosed) {
        rx.close();
      }
    }
    super.dispose();
  }
}
