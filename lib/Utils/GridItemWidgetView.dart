import 'package:unifit/Models/HomeGridItemModel.dart';
import 'package:unifit/Utils/UiViewsWidget.dart';
import 'package:flutter/cupertino.dart';

class GridItemWidgetView extends StatefulWidget{
  final List<HomeGridItemModel> datalist;
  final BuildContext context;
  const GridItemWidgetView({Key key,this.datalist,this.context}): super(key:key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GridItemWidgetViewState();
  }
}
class _GridItemWidgetViewState extends State<GridItemWidgetView>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Container(alignment: Alignment.center,
        child:
        new GridView.count(shrinkWrap: true,  physics: ScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            padding: const EdgeInsets.all(8.0),
            mainAxisSpacing:0.0,
            crossAxisSpacing: 15,

            children:new List<Widget>.generate(widget.datalist.length, (index){
       return  UiViewsWidget.GridItemView(widget.datalist[index],widget.context);

     })
    ));
  }
}