import 'package:flutter/material.dart';
import 'package:spacex/models/space_launch_response_model.dart';
import 'package:spacex/services/spacex_services.dart';

class HomeScreen extends StatefulWidget {
  final bool launchSuccess;
  final bool landSuccess;
  final int year;
  HomeScreen({this.launchSuccess,this.landSuccess,this.year});


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SpaceXServices _spaceXServices = SpaceXServices();
  List<SpaceXLaunches> _list;
  String url;
  setUrl(){
    if(widget.launchSuccess!=null && widget.landSuccess==null && widget.year==null){
      url= "https://api.spaceXdata.com/v3/launches?limit=100&launch_success=${widget.launchSuccess}";
    }else if(widget.launchSuccess!=null && widget.landSuccess!=null && widget.year==null){
      url= "https://api.spaceXdata.com/v3/launches?limit=100&launch_success=${widget.launchSuccess}&land_success=${widget.landSuccess}";
    }else if(widget.year!=null && widget.launchSuccess!=null && widget.landSuccess!=null ){
      url = "https://api.spaceXdata.com/v3/launches?limit=100&launch_success=${widget.launchSuccess}&land_success=${widget.landSuccess}&launch_year=${widget.year}";
    }else{
      url= "https://api.spaceXdata.com/v3/launches?limit=100";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUrl();
    _spaceXServices.getLaunches(url).then((value) {
      setState(() {
        _list = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Space X Launches",style: TextStyle(color: Colors.white,fontSize: 18),),
      ),
      body: _list!=null?ListView.separated(
        itemCount: _list.length,
        separatorBuilder: (context,index){
          return SizedBox(height: 20,);
        },
          itemBuilder: (context,index){
            return Center(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.grey.withOpacity(0.5),
                      child: Image.network(_list[index].links.missionPatchSmall),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "${_list[index].missionName} #${_list[index].flightNumber}",
                      style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.w800,
                        fontSize: 22
                      ),),
                    SizedBox(height: 10,),
                    Text(
                      "Mission Ids: ${_list[index].missionId.toString()}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 22
                      ),),
                    SizedBox(height: 10,),
                    Text(
                      "Successful Launch: ${_list[index].launchSuccess}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 22
                      ),),
                    SizedBox(height: 10,),
                    Text(
                      "Successful Landing: ${_list[index].rocket.firstStage.cores[0].landSuccess}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 22
                      ),),
                  ],
                ),
              ),
            );
          },


      ):Center(
        child: Container(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(),
        ),
      ),
        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.only(right: 50,bottom: 5),
            child: Text('Developer by: Alind Sharma',style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w800,
        fontSize: 22
    ),),
          )
      ],
    );
  }
}
