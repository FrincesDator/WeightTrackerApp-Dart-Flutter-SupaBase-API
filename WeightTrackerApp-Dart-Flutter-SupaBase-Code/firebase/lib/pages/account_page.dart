import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase/main.dart';

class AccountPage extends StatefulWidget {
  final Function(String, double, double, String) onUpdateProfile;

  const AccountPage({Key? key, required this.onUpdateProfile}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _fullNameController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  var _loading = true;

  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });

    try {
      final userId = supabase.auth.currentUser!.id;
      final data = await supabase
          .from('profiles')
          .select<Map<String, dynamic>>()
          .eq('id', userId)
          .single();
      _fullNameController.text = (data['full_name'] ?? '') as String;
      _weightController.text = (data['weight'] ?? '')?.toString() ?? '';
      _heightController.text = (data['height'] ?? '')?.toString() ?? '';
    } on PostgrestException catch (error) {
      // Handle error
    } catch (error) {
      // Handle unexpected error
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      _loading = true;
    });
    final fullName = _fullNameController.text.trim();
    final weight = double.tryParse(_weightController.text.trim()) ?? 0.0;
    final height = double.tryParse(_heightController.text.trim()) ?? 0.0;
    final user = supabase.auth.currentUser;
    final date = DateTime.now().toIso8601String();
    final updates = {
      'id': user!.id,
      'full_name': fullName,
      'weight': weight,
      'height': height,
      'updated_at': date,
    };
    try {
      await supabase.from('profiles').upsert(updates);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Successfully updated profile!'),
          ),
        );
      }
      widget.onUpdateProfile(fullName, weight, height, date);
    } on PostgrestException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Unexpected error occurred'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _signOut() async {
    try {
      await supabase.auth.signOut();
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Unexpected error occurred'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }

  Future<void> _back() async {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          title: Center(
            child: Text(
              '\nEDIT PROFILE',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Color(0xFFfe5d26),
          elevation: 8,
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
              children: [
                const SizedBox(height: 40),
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(labelText: 'Nickname'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _weightController,
                  decoration: const InputDecoration(labelText: 'Weight (kg)'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _heightController,
                  decoration: const InputDecoration(labelText: 'Height (ft'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: _loading ? null : _updateProfile,
                  child: Text(_loading ? 'Saving...' : 'Update'),
                ),
                const SizedBox(height: 18),
                TextButton(onPressed: _signOut, child: const Text('Sign Out')),
                const SizedBox(height: 18),
                TextButton(onPressed: _back, child: const Text('Go Back')),
              ],
            ),
    );
  }
}
