import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  int currentIndex = 0;
  String result;
  String warningText;

  TextEditingController heightEditingController = TextEditingController();
  TextEditingController weightEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("BMI Calculator", style: TextStyle(color: Colors.black)),
          elevation: 0.0,
          backgroundColor: Color(0xfffafafa),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    radioButton("Man", Colors.blue, 0),
                    radioButton("Woman", Colors.pink, 1)
                  ],
                ),

                SizedBox(
                  height: 20.0,
                ),

                // Now lets create our input form to get the height in cm
                Text(
                  "Enter your height in cm :",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: heightEditingController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: "Your height in cm",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none)),
                ),

                SizedBox(
                  height: 20.0,
                ),

                // create input filed to get the weight in kg
                Text(
                  "Enter your weight in kg :",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: weightEditingController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: "Your weight in kg",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none)),
                ),

                SizedBox(
                  height: 20.0,
                ),

                // Now lets add the calculate button

                Container(
                  child: FlatButton(
                    minWidth: double.infinity,
                    height: 50.0,
                    onPressed: () {
                      double height = double.parse(heightEditingController.value.text);
                      double weight = double.parse(weightEditingController.value.text);
                      calculateBMI(height, weight);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    color: Colors.blue,
                    child: Text(
                      "Calculate",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20.0,
                ),

                Container(
                  width: double.infinity,
                  child: Text(
                    "Your BMI is : ",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "$result",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black,
                        fontSize: 24.0,
                    fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(
                  height: 20.0,
                ),

                Container(
                  width: double.infinity,
                  child: Text(
                    "$warningText",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculateBMI(double height, double weight){
    double finalResult = weight /(height * height / 10000);
    String bmi = finalResult.toStringAsFixed(2);
    setState(() {
      result = bmi;
      if(finalResult < 18.5){
        warningText = "Your BMI is considered underweight. Keep in mind that an underweight BMI calculation may pose certain health risks";
      } else if(finalResult > 18.5 && finalResult < 24.9){
        warningText = "Your BMI is considered normal. This healthy weight helps reduce your risk of serious health conditions and means you’re close to your fitness goals";
      } else if(finalResult > 25 && finalResult < 29.9){
        warningText = "Your BMI is considered overweight. Being overweight may increase your risk of cardiovascular disease.";
      } else {
        warningText = "Your BMI is considered obese. People with obesity are at increased risk for many diseases and health conditions, including cardiovascular disease, high blood pressure (Hypertension), Type 2 diabetes, breathing problems and more";
      }
    });
  }

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget radioButton(String value, Color color, int index) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        height: 80.0,
        child: FlatButton(
          color: currentIndex == index ? color : Colors.grey[200],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          onPressed: () {
            changeIndex(index);
          },
          child: Text(
            value,
            style: TextStyle(
                color: currentIndex == index ? Colors.white : color,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
