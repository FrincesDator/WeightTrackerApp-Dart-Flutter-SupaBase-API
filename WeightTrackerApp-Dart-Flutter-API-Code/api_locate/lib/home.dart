import 'package:flutter/material.dart';
import 'package:api_locate/recipe.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFF2C078),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Color(0xFFF2C078),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '\n\n\t\t\t\t\t\t\tEatwell,',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '\t\t\t\tOur Fitness\n\t\t\t\tSmartie!',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 50),
                        Icon(
                          Icons.person,
                          size: 100,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.5),
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    color: Colors.black,
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    height: 85,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF7EBC89),
                        border: Border.all(color: Colors.black, width: 2.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        title: Text(
                          'BiteSmart & Fit.',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Your favorite app to keep you on track.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Features"),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 85,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFAEDCA),
                        border: Border.all(color: Colors.black, width: 2.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 25),
                          Icon(
                            Icons.search,
                            size: 40,
                            color: Colors.black,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Search Recipe',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 20),
                          SizedBox(
                            width: 100,
                            height: 40,
                            child: TextButton(
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
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RecipeSearchPage(),
                                ));
                              },
                              child: Text(
                                'BEGIN',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 85,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFAEDCA),
                        border: Border.all(color: Colors.black, width: 2.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 25),
                          Icon(
                            Icons.fastfood_sharp,
                            size: 40,
                            color: Colors.black,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Fastfood Calories',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 20),
                          SizedBox(
                            width: 100,
                            height: 40,
                            child: TextButton(
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
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RecipeSearchPage(),
                                ));
                              },
                              child: Text(
                                'BEGIN',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
