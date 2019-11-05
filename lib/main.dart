import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Base Converter'),
        ),
        body: new Primary(),
        resizeToAvoidBottomPadding: false,
      )
    );
  }
}

class Primary extends StatefulWidget {
  @override
  _PrimaryState createState() => _PrimaryState();
}

class _PrimaryState extends State<Primary>{
  final inputControl = TextEditingController();
  var _inputType = "dec";

  @override
  void initState(){
    super.initState();
    inputControl.addListener(_refresh);
  }

  @override
  void dispose(){
    inputControl.dispose();
    super.dispose();
  }

  _radioRefresh(val){
    print(val);
    setState(() {
      _inputType = val;
    });
  }

  _refresh(){
    print("Field ${inputControl.text}");
    setState(() {});
  }

  String _toBin(int input){
    if(input == null){
      return '';
    }
    else {
      var num = input;
      var output = '';

      while (num > 0) {
        print(output);
        output = (num % 2).toString() + output;
        num -= num % 2;
        num = (num / 2).toInt();
      }

      return output;
    }
  }

  String _toOct(int input){
    if(input == null) return '';
    else{
      var num = input;
      var output = '';

      while(num>0){
        output = (num%8).toString()+output;
        num -= (num%8);
        num = (num/8).toInt();
      }

      return output;
    }
  }

  String _toHex(int input){
    if(input == null) return '';
    else{
      var num = input;
      var output = '';

      while(num>0){
        switch(num%16){
          case 15:{
            output = 'F' + output;
            num -= 15;
            num = (num / 16).toInt();
            break;
          }
          case 14:{
            output = 'E'+output;
            num -= 14;
            num = (num/16).toInt();
            break;
          }
          case 13:{
            output = 'D'+output;
            num -= 13;
            num = (num/16).toInt();
            break;
          }
          case 12:{
            output = 'C'+output;
            num -= 12;
            num = (num/16).toInt();
            break;
          }
          case 11:{
            output = 'B'+output;
            num -= 11;
            num = (num/16).toInt();
            break;
          }
          case 10:{
            output = 'A'+output;
            num -= 10;
            num = (num/16).toInt();
            break;
          }
          default:{
            output = (num%16).toString()+output;
            num -= num%16;
            num = (num/16).toInt();
          }
        }
      }
      return output;
    }
  }

  String _binToDec(String input){
    var result = 0;
    final num = input;
    final len = num.length-1;

    for(int i=len; i>=0; i--){
      if(num[i]!='0'&&num[i]!='1'){
        print(num[i]);
        return '';
      }
      else{
        result += (int.tryParse(num[i])*pow(2, len-i));
      }
    }
    print(result);
    return result.toString();
  }

  String _hexToDec(String input){
    final map = {
      'F':'15',
      'E':'14',
      'D':'13',
      'C':'12',
      'B':'11',
      'A':'10',
      'f':'15',
      'e':'14',
      'd':'13',
      'c':'12',
      'b':'11',
      'a':'10',
      '9':'9',
      '8':'8',
      '7':'7',
      '6':'6',
      '5':'5',
      '4':'4',
      '3':'3',
      '2':'2',
      '1':'1',
      '0':'0',
    };
    var sum = 0;
    var x = 0;
    for(int i=0; i<input.length; i++){
      if(!map.containsKey(input[i])){
        return '';
      }
      else{
        x = int.tryParse(map[input[i]]);
        sum += pow(16, input.length-i-1)*x;
      }
    }
    return sum.toString();
  }

  Widget _details(String input, String type){
    var hex = '';
    var bin = '';
    var oct = '';
    var dec = '';

    if(type=='dec'){
      hex = _toHex(int.tryParse(input));
      bin = _toBin(int.tryParse(input));
      oct = _toOct(int.tryParse(input));
      dec = input;
    }

    else if(type=='bin'){
      dec = _binToDec(input);
      bin = input;
      oct = _toOct(int.tryParse(dec));
      hex = _toHex(int.tryParse(dec));
    }

    else{
      dec = _hexToDec(input);
      bin = _toBin(int.tryParse(dec));
      oct = _toOct(int.tryParse(dec));
      hex = input;
    }

    return Column(
      children: <Widget>[
        ListTile(
          title: Text("Binary"),
          trailing: Text(bin),
        ),
        ListTile(
          title: Text("Octal"),
          trailing: Text(oct)
        ),
        ListTile(
          title: Text("Hexadecimal"),
          trailing: Text(hex)
        ),
        ListTile(
          title: Text("Decimal"),
          trailing: Text(dec)
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: inputControl,
              )
            )
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
                ),
                padding: EdgeInsets.all(10.0),
                child: _details(inputControl.text, _inputType),
              )
            )
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(top:10.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                ),
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Text("Choose Input Type"),
                      //flex: ,
                    ),
                    Expanded(
                        child: ListTile(
                          title: Text("Decimal"),
                          trailing: Radio(value: "dec", groupValue: _inputType, onChanged: _radioRefresh),
                        )
                    ),
                    Expanded(
                        child: ListTile(
                          title: Text("Binary"),
                          trailing: Radio(value: "bin", groupValue: _inputType, onChanged: _radioRefresh),
                        )
                    ),
                    Expanded(
                        child: ListTile(
                          title: Text("Hexadecimal"),
                          trailing: Radio(value: "hex", groupValue: _inputType, onChanged: _radioRefresh),
                        )
                    )
                  ],
                )
              )
            )
          )
        ],
      )
    );
  }
}