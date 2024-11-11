import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase/supabase.dart';
import 'package:firebase/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  String _name = 'Unknown';
  double _weight = 0.0;
  double _height = 0.0;
  String _date = '';

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  Future<void> _getProfile() async {
    try {
      final userId = supabase.auth.currentUser!.id;
      final data = await supabase
          .from('profiles')
          .select('full_name, weight, height, updated_at')
          .eq('id', userId)
          .single();

      setState(() {
        _name = data['full_name'] as String;
        _weight = (data['weight'] ?? 0.0) as double;
        _height = (data['height'] ?? 0.0) as double;
        _date = (data['updated_at'] ?? '') as String;
      });
    } on PostgrestException catch (error) {
      print('Error fetching data: ${error.message}');
    } catch (error) {
      print('Unexpected error: $error');
    }
  }

  void onUpdateProfile(String name, double weight, double height, String updated_at) {
    setState(() {
      _name = name;
      _weight = weight;
      _height = height;
      _date = updated_at;
    });
  }

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
                      '\n\n\t\t\t\t\t\t\tBe Smart, Eat Wise,',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '\t\t\t\t$_name',
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
                    height: 200,
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
                          'Your favorite app to keep you on track.\n\n Weight: $_weight \n Height: $_height \n Last Updated: $_date',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
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
                            Icons.settings,
                            size: 40,
                            color: Colors.black,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 40),
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
                                Navigator.of(context).pushReplacementNamed('/account');
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
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
