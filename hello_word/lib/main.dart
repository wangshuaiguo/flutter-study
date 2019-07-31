import 'package:flutter/material.dart';

void main() {
  runApp(new AppBarBottomSample());
}

class AppBarBottomSample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _AppBarBottomSampleState();
  }
}

class _AppBarBottomSampleState extends State<AppBarBottomSample>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: choices.length);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('05-导航底部挂Tabbar'),
          leading: IconButton(
            tooltip: 'Previous choice',
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              _nextPage(-1);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_forward),
              tooltip: '下一个 choice',
              onPressed: () {
                _nextPage(1);
              },
            )
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: Theme(
              data: Theme.of(context).copyWith(accentColor: Colors.white),
              child: Container(
                height: 48.0,
                alignment: Alignment.center,
                child: TabPageSelector(controller: _tabController,),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: choices.map(
              (Choice choice){
                return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: ChoiceCard(
                      choice: choice,
                    ),
                );
              }
          ).toList(),
        ),
      ),
    );
  }


  void _nextPage(int delta) {
    int indexNew = _tabController.index + delta;
    if (indexNew >= _tabController.length) {
      indexNew = 0;
      // return;
    }else if (indexNew < 0){
      indexNew = _tabController.length - 1;
    }

    _tabController.animateTo(indexNew);
  }
}

class Choice {
  final String title;
  final IconData icon;

  const Choice(this.title, this.icon);
}

const List<Choice> choices = const <Choice>[
  const Choice('CAR', Icons.directions_car),
  const Choice('bike', Icons.directions_bike),
  const Choice('boat', Icons.directions_boat),
  const Choice('bus', Icons.directions_bus),
  const Choice('railway', Icons.directions_railway),
  const Choice('walk', Icons.directions_walk),
  const Choice('subway', Icons.directions_subway),
];



class ChoiceCard extends StatelessWidget {

  const ChoiceCard({ Key key, this.choice }) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return new Card(
      color: Colors.white,
      child: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Icon(choice.icon, size: 128.0, color: textStyle.color),
            new Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
