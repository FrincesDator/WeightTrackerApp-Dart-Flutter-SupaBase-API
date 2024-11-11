import 'package:flutter/material.dart';

class BMI extends StatefulWidget {
  const BMI({Key? key}) : super(key: key);

  @override
  _BMIState createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  double height = 101;
  double weight = 101;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Text(
                'HEIGHT',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFAEDCA),
                  border: Border.all(color: Colors.black, width: 2.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          '${height.toStringAsFixed(2)} CM',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 20),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Color(0xFFfe5d26),
                            inactiveTrackColor: Colors.grey,
                            trackShape: RectangularSliderTrackShape(),
                            trackHeight: 6.0, // Change the track height
                            thumbColor: Color(0xFFfe5d26), // Change the thumb color
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0), // Change the thumb shape
                            overlayColor: Color(0xFFfe5d26).withOpacity(0.3), // Change the overlay color
                            overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0), // Change the overlay shape
                          ),
                          child: Slider(
                            value: height,
                            min: 100,
                            max: 220,
                            onChanged: (value) {
                              setState(() {
                                height = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'WEIGHT',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFAEDCA),
                  border: Border.all(color: Colors.black, width: 2.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          '${weight.toStringAsFixed(2)} KG',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 20),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Color(0xFFfe5d26),
                            inactiveTrackColor: Colors.grey,
                            trackShape: RectangularSliderTrackShape(),
                            trackHeight: 6.0, // Change the track height
                            thumbColor: Color(0xFFfe5d26), // Change the thumb color
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0), // Change the thumb shape
                            overlayColor: Color(0xFFfe5d26).withOpacity(0.3), // Change the overlay color
                            overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0), // Change the overlay shape
                          ),
                          child: Slider(
                            value: weight,
                            min: 30,
                            max: 150,
                            onChanged: (value) {
                              setState(() {
                                weight = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: () {
                double bmi = calculateBMI(height, weight);
                String result = getBMIResult(bmi);

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('BMI Result'),
                    content: Text('Your BMI: ${bmi.toStringAsFixed(2)}\n$result'),
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('CALCULATE'),
            ),
          ],
        ),
      ),
    );
  }

  double calculateBMI(double height, double weight) {
    double heightInMeter = height / 100;
    return weight / (heightInMeter * heightInMeter);
  }

  String getBMIResult(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 25) {
      return 'Normal weight';
    } else if (bmi >= 25 && bmi < 30) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }
}
