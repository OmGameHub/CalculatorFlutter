import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController inputController = TextEditingController();
  TextEditingController resultController = TextEditingController();

  String num1 = "asd";
  String num2 = "";
  String opt = "";

  bool isErrorHit = false;

  void onPressPad(String btnText) {
    String inputText = inputController.text;

    switch (btnText) 
    {
      case "0":
      case "1":
      case "2":
      case "3":
      case "4":
      case "5":
      case "6":
      case "7":
      case "8":
      case "9":
          inputText += btnText;
        break;

      case "c":
        if (inputText != null && inputText.length > 0) 
          inputText = inputText.substring(0, inputText.length - 1);
        break;
      
      case "/": 
      case "*": 
      case "+": 
        if (inputText.isNotEmpty) 
        {
          num1 = inputText;
          opt = btnText;

          inputText = "";
        } 

        break;

      case "-": 
        if (inputText.isNotEmpty) 
        {
          num1 = inputText;
          opt = btnText;

          inputText = "";
        } 
        else
        {
          inputText += btnText; 
        } 

        break;
      
      case ".": 
        if (!inputText.contains(".")) 
          inputText += btnText;
        break;

      case "=": 
        if (num1.isNotEmpty && opt.isNotEmpty && inputText.isNotEmpty) 
        {
          num2 = inputText;
          double result = calculate();

          if (result != null) 
          {
            isErrorHit = false;
            inputText = calculate().toString();

            setState(() { resultController.text = ""; });
          }
        }
        break;
    }

    setState(() { inputController.text = inputText; });
  }

  double calculate()
  {
    try 
    {
      double fNum = double.parse(num1);
      double sNum = double.parse(num2);

      switch (opt) 
      {
        case "/": return fNum / sNum;
        case "*": return fNum * sNum;
        case "-": return fNum - sNum;
        case "+": return fNum + sNum; 
      }
    } 
    catch (e) 
    {
      print("Error in calculate $e");

      setState(() {
        isErrorHit = true;
        resultController.text = "Bad expression";
      });
    }

    return null;
  }
  
  Widget iconPadBtn(String btnText, IconData iconData, Color iconColor, double iconSize) {
    return Expanded(
      child: FlatButton(
        child: Icon(
          iconData,
          color: Colors.blue,
          size: iconSize,
        ),
        shape: CircleBorder(side: BorderSide.none),
        onPressed: () { onPressPad(btnText); },
      ),
    );
  }

  Widget numberPadBtn(String btnText, TextStyle textStyle) {
    return Expanded(
      child: FlatButton(
        child: Text(
          btnText,
          style: textStyle,
        ),
        shape: CircleBorder(side: BorderSide.none),
        onPressed: () { onPressPad(btnText); },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // calculator display
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // input text field
                      TextField(
                        controller: inputController,
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.blueGrey[200],
                        ),
                        textAlign: TextAlign.right,
                        textAlignVertical: TextAlignVertical.bottom,
                        enabled: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),

                      // result text field
                      TextField(
                        controller: resultController,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isErrorHit? Colors.red : null,
                        ),
                        textAlign: TextAlign.right,
                        textAlignVertical: TextAlignVertical.top,
                        enabled: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              // Calculator pad
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.blueGrey[50],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // number pad 
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: <Widget>[

                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  numberPadBtn("7", TextStyle(fontSize: 32, fontWeight: FontWeight.normal)),
                                  numberPadBtn("8", TextStyle(fontSize: 32, fontWeight: FontWeight.normal)),
                                  numberPadBtn("9", TextStyle(fontSize: 32, fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),

                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  numberPadBtn("4", TextStyle(fontSize: 32, fontWeight: FontWeight.normal)),
                                  numberPadBtn("5", TextStyle(fontSize: 32, fontWeight: FontWeight.normal)),
                                  numberPadBtn("6", TextStyle(fontSize: 32, fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),

                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  numberPadBtn("1", TextStyle(fontSize: 32, fontWeight: FontWeight.normal)),
                                  numberPadBtn("2", TextStyle(fontSize: 32, fontWeight: FontWeight.normal)),
                                  numberPadBtn("3", TextStyle(fontSize: 32, fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),

                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  numberPadBtn("0", TextStyle(fontSize: 32, fontWeight: FontWeight.normal)),
                                  numberPadBtn(".", TextStyle(fontSize: 32, fontWeight: FontWeight.normal)),
                                  numberPadBtn("=", TextStyle(fontSize: 32, fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),

                      // divider
                      Container(width: 1, color: Colors.blueGrey[100]),
                      
                      // operator pad 
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[

                            iconPadBtn("c", Icons.backspace, Colors.blue, 32),
                            numberPadBtn("/", TextStyle(fontSize: 32, color: Colors.blue)),
                            numberPadBtn("*", TextStyle(fontSize: 32, color: Colors.blue)),
                            numberPadBtn("-", TextStyle(fontSize: 32, color: Colors.blue)),
                            numberPadBtn("+", TextStyle(fontSize: 32, color: Colors.blue)),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }  
}