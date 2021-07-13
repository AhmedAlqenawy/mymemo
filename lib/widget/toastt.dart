
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IconToastWidget extends StatefulWidget {
  final Key key;
  final Color backgroundColor;
  final String message;
  final Widget textWidget;
  final double height;
  final double width;
  final Icon iconname;
  final EdgeInsetsGeometry padding;

  IconToastWidget({
    this.key,
    this.backgroundColor,
    this.textWidget,
    this.message,
    this.height,
    this.width,
    @required this.iconname,
    this.padding,
  }) : super(key: key);

  factory IconToastWidget.fail({String msg}) => IconToastWidget(
    message: msg,
    iconname: Icon(Icons.warning_amber_outlined),
  );

  factory IconToastWidget.success({String msg,String Iconname}) => IconToastWidget(
    message: msg,
    iconname: Icon(Icons.check_circle_outline_sharp),
  );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _IconToastWidgetState();
  }
}

class _IconToastWidgetState extends State<IconToastWidget>
    with TickerProviderStateMixin<IconToastWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget content = Material(
      color: Colors.transparent,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50.0),
          padding: widget.padding ??
              EdgeInsets.symmetric(vertical: 20.0, horizontal: 17.0),
          decoration: ShapeDecoration(
            color: widget.backgroundColor ?? const Color(0x9F000000),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: widget.iconname,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: widget.textWidget ??
                    Text(
                      widget.message ?? '',
                      style: TextStyle(
                          fontSize: Theme.of(context).textTheme.title.fontSize,
                          color: Colors.white),
                      softWrap: true,
                      maxLines: 200,
                    ),
              ),
            ],
          )),
    );

    return content;
  }
}

AutoSizeText autoText(String text, int maxLine, double fontSize,FontWeight fontWeight, Color color ) {
  return AutoSizeText(text,
      maxLines: maxLine,
      overflow: TextOverflow.visible,
      textAlign: TextAlign.center,
      style:GoogleFonts.elMessiri(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      )
  );
}
