import 'package:EfendimDriverApp/ui/Account/UI/ListItems/account_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:EfendimDriverApp/ui/Locale/locales.dart';
import 'package:EfendimDriverApp/ui/Routes/routes.dart';
import 'package:EfendimDriverApp/ui/Themes/colors.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:custom_switch/custom_switch.dart';

class InsightPage extends StatefulWidget {
  @override
  _InsightPageState createState() => _InsightPageState();
}

class _InsightPageState extends State<InsightPage> {
  int _currentPage = 0;
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: AccountDrawer(),
      appBar: AppBar(
        // title: Text(AppLocalizations.of(context).insight,
        //     style: Theme.of(context)
        //         .textTheme
        //         .headline4
        //         .copyWith(fontWeight: FontWeight.w500)),
        titleSpacing: 0.0,
        // actions: <Widget>[
        //   Row(
        //     children: <Widget>[
        //       Text(
        //         AppLocalizations.of(context).today.toUpperCase(),
        //         style: Theme.of(context).textTheme.headline4.copyWith(
        //             fontSize: 15.0, letterSpacing: 1.5, color: kMainColor),
        //       ),
        //       IconButton(
        //         icon: Icon(Icons.arrow_drop_down),
        //         color: kMainColor,
        //         onPressed: () {
        //           /*....*/
        //         },
        //       )
        //     ],
        //   )
        // ],
      ),
      body: PageView(
        controller: _pageController,
        children: [
          Example2(),
          Container(color: Colors.red),
          Container(color: Colors.greenAccent.shade700),
          Container(color: Colors.orange),
        ],
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: Icon(
              Icons.shopping_bag_outlined,
              color: Color(0xffBD1942),
            ),
            title: Text('My Order'),
            activeColor: Colors.black,
          ),
          BottomBarItem(
            icon: Icon(Icons.home_repair_service),
            title: Text('Favorites'),
            activeColor: Colors.red,
            darkActiveColor: Colors.red.shade400,
          ),
          BottomBarItem(
            icon: Icon(Icons.map),
            title: Text('Account'),
            activeColor: Colors.greenAccent.shade700,
            darkActiveColor: Colors.greenAccent.shade400,
          ),
          BottomBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Colors.orange,
          ),
        ],
      ),
    );
  }
}

class Example2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool status = false;
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Container(
              height: 100,
              color: Colors.white,
            ),
            Container(
              height: 40,
              color: Color(0xffBD1942),
            ),
            Positioned(
              top: 15,
              left: 30,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(7.0))),
                height: 90,
                width: 300,
                child: Row(
                  children: [
                    Column(
                      children: [
                        
                        SizedBox(height: 10,),
                        CustomSwitch(
                          
                          activeColor: Colors.pinkAccent,
                          value: status,
                          onChanged: (value) {
                           
                            
                          },
                        ),
                         SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Order Enabled",
                          style: TextStyle(
                            color: Color(0xffBD1942),
                            fontSize: 12,
                          ),
                        ),
                        
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "My Order",
                      style: TextStyle(
                        color: Color(0xffBD1942),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        CustomSwitch(
                          activeColor: Colors.pinkAccent,
                          value: status,
                          onChanged: (value) {
                            print("VALUE : $value");
                            
                          },
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "Store Open",
                          style: TextStyle(
                            color: Color(0xffBD1942),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          //  padding: const EdgeInsets.all(1.0),

          width: 450,
          height: 330,
          child: ContainedTabBarView(
            tabs: [
              Text(
                'Peding Orders',
              ),
              Text(
                'In progress ',
              ),
              Text(
                'Under Delivery',
              ),
            ],
            tabBarProperties: TabBarProperties(
              height: 52.0,
              indicatorColor: Color(0xffBD1942),
              indicatorWeight: 3.0,
              labelColor: Color(0xffBD1942),
              unselectedLabelColor: Colors.grey[400],
            ),
            views: [
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Card(
                        child: Row(
                          children: [
                            MaterialButton(
                              onPressed: () {},
                              //color: Colors.blue,
                              textColor: Colors.white,
                              child: Column(
                                children: [
                                   Container(
                                     color: Colors.green,
                                     width: 50,
                                     height: 50,
                                     
                                     child: Image.network("https://png.pngtree.com/png-vector/20200417/ourlarge/pngtree-delivery-boy-with-mask-riding-bike-vector-png-image_2187935.jpg",
                                   width: 50,
                                   height: 130,
                                   ),
                                   ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    children: [],
                                  ),
                                ],
                              ),
                            //  padding: EdgeInsets.all(10),
                              shape: CircleBorder(),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order # 1199",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Color(0xffBD1942),
                                    fontSize: 10,
                                     fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "1 Item for  gurdeepresr guur",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                
                                Text(
                                  "a day ago",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color:Colors.grey,
                                    fontSize: 10,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(2),
                                  height: 25,
                                  width: 60,
                                  decoration: new BoxDecoration(
                                    //borderRadius: new BorderRadius.circular(16.0),
                                    color: Colors.yellow,
                                  ),
                                  child: Text("Peding",
                                  style: TextStyle(
                                    fontSize: 15,
              
              
                                  ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  
                                  Container(
                                    
                                     decoration: BoxDecoration(
                                       color: Colors.greenAccent,
              
                                        border: Border.all(
                                          color: Colors.greenAccent,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  
                                    height: 20,
                                    width: 40,
                                    padding: EdgeInsets.all(3),
                                    child: Text(
                                      '60.0',
                                      style: TextStyle(fontSize: 10),
                                    ),),
                                  SizedBox(height: 50,),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.alarm,
                                        color: Colors.black,
                                        size:1,
                                        
                                      ),
                                      Text(
                                        'Deliver ASAP ',
              
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                                      Card(
                        child: Row(
                          children: [
                            MaterialButton(
                              onPressed: () {},
                              //color: Colors.blue,
                              textColor: Colors.white,
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.green,
                                    width: 50,
                                    height: 50,
                                    child: Image.network(
                                      "https://png.pngtree.com/png-vector/20200417/ourlarge/pngtree-delivery-boy-with-mask-riding-bike-vector-png-image_2187935.jpg",
                                      width: 50,
                                      height: 130,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    children: [],
                                  ),
                                ],
                              ),
                              //  padding: EdgeInsets.all(10),
                              shape: CircleBorder(),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order # 1199",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Color(0xffBD1942),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "1 Item for  gurdeepresr guur",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "a day ago",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(2),
                                  height: 25,
                                  width: 60,
                                  decoration: new BoxDecoration(
                                    //borderRadius: new BorderRadius.circular(16.0),
                                    color: Colors.yellow,
                                  ),
                                  child: Text(
                                    "Peding",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        border: Border.all(
                                          color: Colors.greenAccent,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    height: 20,
                                    width: 40,
                                    padding: EdgeInsets.all(3),
                                    child: Text(
                                      '60.0',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.alarm,
                                        color: Colors.black,
                                        size: 1,
                                      ),
                                      Text(
                                        'Deliver ASAP ',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                                      Card(
                        child: Row(
                          children: [
                            MaterialButton(
                              onPressed: () {},
                              //color: Colors.blue,
                              textColor: Colors.white,
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.green,
                                    width: 50,
                                    height: 50,
                                    child: Image.network(
                                      "https://png.pngtree.com/png-vector/20200417/ourlarge/pngtree-delivery-boy-with-mask-riding-bike-vector-png-image_2187935.jpg",
                                      width: 50,
                                      height: 130,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    children: [],
                                  ),
                                ],
                              ),
                              //  padding: EdgeInsets.all(10),
                              shape: CircleBorder(),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order # 1199",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Color(0xffBD1942),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "1 Item for  gurdeepresr guur",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "a day ago",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(2),
                                  height: 25,
                                  width: 60,
                                  decoration: new BoxDecoration(
                                    //borderRadius: new BorderRadius.circular(16.0),
                                    color: Colors.yellow,
                                  ),
                                  child: Text(
                                    "Peding",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        border: Border.all(
                                          color: Colors.greenAccent,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    height: 20,
                                    width: 40,
                                    padding: EdgeInsets.all(3),
                                    child: Text(
                                      '60.0',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.alarm,
                                        color: Colors.black,
                                        size: 1,
                                      ),
                                      Text(
                                        'Deliver ASAP ',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(color: Colors.white),
              Container(color: Colors.white),
            ],
            onChange: (index) => print(index),
          ),
        ),
      ],
    ));
  }
}

class Insight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Divider(
          color: Theme.of(context).cardColor,
          thickness: 8.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '64',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).orders,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        fontWeight: FontWeight.w500, color: Color(0xff6a6c74)),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '68 km',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).ride,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        fontWeight: FontWeight.w500, color: Color(0xff6a6c74)),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '\$302.50',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).earnings,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        fontWeight: FontWeight.w500, color: Color(0xff6a6c74)),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          color: Theme.of(context).cardColor,
          thickness: 6.7,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context).earnings.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontSize: 15.0, letterSpacing: 1.5)),
              Center(
                child: Image(
                  image: AssetImage("assets/images/graph.png"),
                  height: 200.0,
                ),
              ),
              GestureDetector(
                // onTap: () =>
                //     Navigator.pushNamed(context, PageRoutes.walletPage),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).viewAll.toUpperCase(),
                    style: Theme.of(context).textTheme.caption.copyWith(
                        color: kMainColor,
                        letterSpacing: 1.33,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Theme.of(context).cardColor,
          thickness: 6.7,
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context).orders.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontSize: 15.0, letterSpacing: 1.5)),
              Center(
                child: Image(
                  image: AssetImage("assets/images/graph.png"),
                  height: 200.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
