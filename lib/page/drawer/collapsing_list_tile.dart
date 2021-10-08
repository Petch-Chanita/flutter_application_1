import 'package:flutter/material.dart';
import 'package:flutter_application_1/apptheme/app-theme.dart';

class CollapsingListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final AnimationController animationController;
  final bool isSelected;
  final Function onTap;

  CollapsingListTile(
      {@required this.title,
      @required this.icon,
      @required this.animationController,
      @required this.isSelected = false,
      @required this.onTap});

  @override
  _CollapsingListTileState createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
  Animation<double> widthAnimation, sizedBoxAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widthAnimation =
        Tween<double>(begin: 45, end: 220).animate(widget.animationController);
    sizedBoxAnimation =
        Tween<double>(begin: 0, end: 10).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
          color: widget.isSelected
              ? Colors.transparent.withOpacity(0.3)
              : Colors.transparent,
        ),
        width: widthAnimation.value,
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: widget.isSelected
                  ? MyTheme.selectedColorDrawer
                  : Colors.white30,
              size: 28,
            ),
            SizedBox(width: sizedBoxAnimation.value),
            
            (widthAnimation.value >= 220)
                ? Text(
                    widget.title,//
                    // style: TextStyle(color: Colors.white),
                    style: widget.isSelected
                        ? MyTheme.listTileSelectedTextStyle
                        : MyTheme.listTileDefaultTextStyle,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
