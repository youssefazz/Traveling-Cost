import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trip Cost Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new FuelForm(),
    );
  }
}
class FuelForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FuelFormState();

}
class _FuelFormState extends State<FuelForm>{
  String result="";
  final _currencies=['Euro','Dollars','MAD'];
  String _currency='Dollars';
  final double FormDistance=5.0;
  TextEditingController distanceController=TextEditingController();
  TextEditingController avgController=TextEditingController();
  TextEditingController priceController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle=Theme.of(context).textTheme.headline6;
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:Text("Fuel Cost App"),
          backgroundColor: Colors.blueAccent,

        ),
        body: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: FormDistance,
                  bottom: FormDistance,
                ),
                child:TextField(
                controller: distanceController,
                decoration: InputDecoration(
                  labelText: "Distance ",
                  hintText: 'e.g. 124',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )
                ),
                keyboardType: TextInputType.number,
              )),
              Padding(
                padding: EdgeInsets.only(
                  top: FormDistance,
                  bottom: FormDistance,
                ),
                  child:TextField(
                controller: avgController,
                decoration: InputDecoration(
                    labelText: "Distance per unit",
                    hintText: 'e.g. 102',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )
                ),
                keyboardType: TextInputType.number,
              )),
              Padding(
                padding: EdgeInsets.only(
                  top: FormDistance,
                  bottom: FormDistance,
                ),
                child:
                Row(children:<Widget>[
                  Expanded(child:TextField(
                controller: priceController,
                decoration: InputDecoration(
                    labelText: "Price ",
                    hintText: 'e.g. 40',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )
                ),
                keyboardType: TextInputType.number,
              ),),
              Container(width: FormDistance*5),
              Expanded(
                  child:DropdownButton<String>(
                  items: _currencies.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                value: _currency,
                onChanged: (String value){
                    _onDropDownChanged(value);
                },
              )),
                ]),
              ),
              Row(children: <Widget>[
                Expanded(
                  child:RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                child: Text(
                  'Submit',
                  textScaleFactor: 1.5,
                ),
                onPressed: (){
                  setState(() {
                    result=_Calculate();
                  });
                },
              ),),
              Expanded(
                child:RaisedButton(
                color: Theme.of(context).buttonColor,
                textColor: Theme.of(context).primaryColorDark,
                child: Text(
                  'Reset',
                  textScaleFactor: 1.5,
                ),
                onPressed: (){
                  setState(() {
                    _Reset();
                  });
                },
              ),),
              ],),
              Text(result),
            ],
          ),
        ),
      );
  }
  _onDropDownChanged(String value){
    setState(() {
      this._currency=value;
    });
  }
  String _Calculate(){
    double _distance=double.parse(distanceController.text);
    double _fuelCost=double.parse(priceController.text);
    double _consumption=double.parse(avgController.text);
    double _totalCost=_distance / _consumption *_fuelCost;
    String result='The total cost of your trip is '+_totalCost.toStringAsFixed(2)+' '+_currency;
    return result;
  }
  void _Reset(){
    distanceController.text='';
    avgController.text='';
    priceController.text='';
    setState(() {
      result='';
    });
  }
}