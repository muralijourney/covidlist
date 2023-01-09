import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {

   NormalText({
      @required this.text = "",
      this.fontFamily = 'Roboto',
      this.fontcolor = Colors.black,
      this.fontSize = 16,
      this.fontWeight = FontWeight.normal,
      this.textAlign = TextAlign.center,
      this.padding = 0.0,
      this.leftPadding = 0.0,
      this.topPadding = 0.0,
      this.bottomPadding = 0.0,
      this.rightPadding = 0.0,
      this.margin = 0.0,
      this.leftMargin = 0.0,
      this.rightMargin = 0.0,
      this.topMargin = 0.0,
      this.bottomMargin = 0.0,
      this.isStriked = false,
      this.textWrapRequired = true,
      this.maxLines = 0,
      this.isUpperCase = false,
      this.isVisible = true,
   });

   final String text;
   final String fontFamily;
   final Color fontcolor;
   final double fontSize;
   final FontWeight fontWeight;
   final TextAlign textAlign;
   final double padding;
   final double leftPadding;
   final double topPadding;
   final double bottomPadding;
   final double rightPadding;
   final double margin;
   final double leftMargin;
   final double rightMargin;
   final double topMargin;
   final double bottomMargin;
   final bool isStriked;
   final bool textWrapRequired;
   final int maxLines;
   final bool isUpperCase;
   bool isVisible;

   @override
   Widget build(BuildContext context) {
      return isVisible
          ? MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: Container(
             padding: padding == 0.0
                 ? EdgeInsets.only(
                 left: leftPadding,
                 top: topPadding,
                 bottom: bottomPadding,
                 right: rightPadding)
                 : EdgeInsets.all(padding),
             margin: margin == 0.0
                 ? EdgeInsets.fromLTRB(
                 leftMargin, topMargin, rightMargin, bottomMargin)
                 : EdgeInsets.all(margin),
             child: textWrapRequired
                 ? Text(
                isUpperCase ? text.toUpperCase() : text,
                softWrap: true,
                textAlign: textAlign,
                style: TextStyle(
                    fontSize: fontSize,
                    fontFamily: fontFamily,
                    color: fontcolor,
                    fontWeight: fontWeight,
                    decoration: isStriked
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
             )
                 : maxLines == 0
                 ? Text(
                isUpperCase ? text.toUpperCase() : text,
                textAlign: textAlign,
                style: TextStyle(
                    fontSize: fontSize,
                    color: fontcolor,
                    fontFamily: fontFamily,
                    fontWeight: fontWeight,
                    decoration: isStriked
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
             )
                 : Text(
                isUpperCase ? text.toUpperCase() : text,
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
                textAlign: textAlign,
                style: TextStyle(
                    fontSize: fontSize,
                    color: fontcolor,
                    fontFamily: fontFamily,
                    fontWeight: fontWeight,
                    decoration: isStriked
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
             ),
          ))
          : Container(
         height: 0,
         width: 0,
      );
   }
}
