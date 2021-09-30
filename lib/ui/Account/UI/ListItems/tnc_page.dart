import 'package:EfendimDriverApp/ui/Account/UI/ListItems/webview_t&c.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:EfendimDriverApp/core/localizations/global_translations.dart';

class TncPage extends StatefulWidget {
  @override
  _TncPageState createState() => _TncPageState();
}

class _TncPageState extends State<TncPage> {
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<GlobalTranslations>(context, listen: false);
    return Scaffold(
      // drawer: AccountDrawer(),
      appBar: AppBar(
        titleSpacing: 0.0,
        centerTitle: true,
        title: Text(lang.translate("Terms and Conditions"),
            style: Theme.of(context).textTheme.bodyText1),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, )),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * double.infinity,
                padding: EdgeInsets.all(48.0),
                color: Theme.of(context).cardColor,
                child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo_delivery.png"),
                    ),
                  ),
                ),
              ),
           
              
                
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top : 200.0),
                          child: Container(
                            height : MediaQuery.of(context).size.height*0.05,
                            width : MediaQuery.of(context).size.width*0.35,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => Termsconditions(
                                      title: "Terms and conditions",
                                      selectedUrl:
                                          "https://apps.efendim.biz/terms-of-use/",
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(primary : Colors.yellow),
                              child: Text("Terms and Conditions" ,style : TextStyle(color: Colors.black), textAlign: TextAlign.center) ,
                            ),
                          ),
                        ),
                      ],
                    )
                  
              
            ],
          ),
        ),
      ),
    );
  }
}
