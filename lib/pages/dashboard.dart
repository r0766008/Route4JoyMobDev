import 'package:flutter/material.dart';
import 'package:flutter_project/pages/play/route_list.dart' as PlayRoute;
import 'package:flutter_project/pages/edit/route_list.dart' as EditRoute;
import 'package:flutter_project/widgets/maindrawer.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
  }

  navigatePage(String page) {
    if (page == "Play") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PlayRoute.RouteListPage()),
      );
    } else if (page == "Edit") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditRoute.RouteListPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff21254A),
          title: Text("My Dashboard"),
          bottom: PreferredSize(
            child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.white.withOpacity(0.3),
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    child: Text('Play Route'),
                  ),
                  Tab(
                    child: Text('Edit Route'),
                  ),
                ]),
            preferredSize: Size.fromHeight(30.0),
          ),
        ),
        drawer: Drawer(
          child: MainDrawer(),
        ),
        backgroundColor: Color(0xff21254A),
        body: TabBarView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 150, horizontal: 25),
              child: Card(
                elevation: 5,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Play Route",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Text(
                            "If you feel like going outside and have a little fun. Then this is the page for you, you can start by playing other routes all over the world. \n\nJust press the button below and it will take you to a list of available routes in your region. \nChoose your favorite route and start playing. \n\nHave fun!",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          navigatePage("Play");
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(124, 40, 194, 1),
                          ),
                          child: Center(
                            child: Text(
                              "Play",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 150, horizontal: 25),
              child: Card(
                elevation: 5,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Edit Route",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Text(
                            "You can also start making your own routes. This will allow other people to start playing these. Make difficult questions but make sure they can be solved. \n\nJust press the button below and it will take you to a list of your routes. Choose which route you want to edit or create a new one. \n\nHave fun!",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          navigatePage("Edit");
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(124, 40, 194, 1),
                          ),
                          child: Center(
                            child: Text(
                              "Edit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
