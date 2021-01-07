import 'package:flutter/material.dart';
import 'package:spacex/screens/home_screen.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<int> years = [];
  int year;
  String launch;
  String land;
  bool launchSuccess;
  bool landSuccess;

  getYearList(){
    for(int i = 2006;i<=2020;i++){
      years.add(i);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getYearList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text("Space X Launch Programs",style: TextStyle(color: Colors.black,fontSize: 18),),
        ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(height: 100,),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.orange,width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButtonFormField(
                  hint: Text("Select a Launch Success",style: TextStyle(color: const Color(0xFF424242)),),
                  value: launch,
                  onChanged: (value) {
                    setState(() {
                      launch = value;
                      if(launch=="True"){
                        landSuccess = true;
                      }else if(launch=="False"){
                        launchSuccess = false;
                      }
                    });
                  },
                  items: ["False","True"].map((label) => DropdownMenuItem(
                    child: Text(label.toString()),
                    value: label,
                  )).toList(),
                  icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
                )
            ),
            SizedBox(height: 50,),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.orange,width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButtonFormField(
                  hint: Text("Select a Land Success",style: TextStyle(color: const Color(0xFF424242)),),
                  value: land,
                  onChanged: (value) {
                    setState(() {
                      land = value;
                      if(land=="True"){
                        landSuccess = true;
                      }else if(land=="False"){
                        landSuccess = false;
                      }
                    });
                  },
                  items: ["False","True"].map((label) => DropdownMenuItem(
                    child: Text(label.toString()),
                    value: label,
                  )).toList(),
                  icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
                )
            ),
            SizedBox(height: 50,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.orange,width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButtonFormField(
                  hint: Text("Select a year",style: TextStyle(color: const Color(0xFF424242)),),
                  value: year,
                  onChanged: (value) {
                    setState(() {
                      year = value;
                    });
                  },
                  items: years.map((label) => DropdownMenuItem(
                    child: Text(label.toString()),
                    value: label,
                  )).toList(),
                  icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
                )
            ),
            SizedBox(height: 50,),
            FlatButton(
                onPressed: (){
                  print("year is $year");
                  print("launch is $launchSuccess");
                  print("land is $landSuccess");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                    launchSuccess: launchSuccess,
                    landSuccess: landSuccess,
                    year: year,
                  )));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  height: 50,
                  width: 200,
                  child: Text("Get Details",style: TextStyle(fontSize: 18,color: Colors.white),),
                ))
          ],
        ),
      ),
    );
  }
}
