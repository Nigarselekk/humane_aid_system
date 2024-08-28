import 'package:flutter/material.dart';
import 'package:humane_aid_system/models/register_model.dart';
import 'package:humane_aid_system/services/register_service.dart';
import 'package:humane_aid_system/my/my_service_models/base_model.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  int? _selectedRole;
  bool _isLoading = false;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedRole == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a role')),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        BaseModel<RegisterModel> response = await RegisterService.register(
          _firstNameController.text,
          _lastNameController.text,
          _emailController.text,
          _userNameController.text,
          _phoneNumberController.text,
          _passwordController.text,
          _confirmPasswordController.text,
          _selectedRole!,
        );

        setState(() {
          _isLoading = false;
        });

        if (response.succeeded!) {
          switch (_selectedRole) {
            case 0:
              Navigator.pushNamed(context, '/adminLogin');
              break;
            case 1:
              Navigator.pushNamed(context, '/affectedLogin');
              break;
            case 2:
              Navigator.pushNamed(context, '/helpersLogin');
              break;
            default:
              Navigator.pop(context);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration Successful')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message ?? 'Registration Failed')),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(_firstNameController, 'First Name', Icons.person),
                    SizedBox(height: 10),
                    _buildTextField(_lastNameController, 'Last Name', Icons.person_outline),
                    SizedBox(height: 10),
                    _buildTextField(_emailController, 'Email', Icons.email),
                    SizedBox(height: 10),
                    _buildTextField(_userNameController, 'Username', Icons.account_circle),
                    SizedBox(height: 10),
                    _buildTextField(_phoneNumberController, 'Phone Number', Icons.phone),
                    SizedBox(height: 10),
                    _buildPasswordField(_passwordController, 'Password'),
                    SizedBox(height: 10),
                    _buildPasswordField(_confirmPasswordController, 'Confirm Password'),
                    SizedBox(height: 10),
                    _buildRoleDropdown(),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: _register,
                      child: Text('Register', style: TextStyle(fontSize: 18, color: Colors.white), selectionColor: Colors.white,),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: labelText,
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $labelText';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String labelText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: labelText,
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $labelText';
        }
        return null;
      },
    );
  }

  Widget _buildRoleDropdown() {
    return DropdownButtonFormField<int>(
      value: _selectedRole,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person_outline),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: 'Role',
        filled: true,
        fillColor: Colors.white,
      ),
      items: [
        DropdownMenuItem(
          value: 0,
          child: Text('Admin'),
        ),
        DropdownMenuItem(
          value: 1,
          child: Text('DisasterAffected'),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text('Helpers'),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _selectedRole = value;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Please select a role';
        }
        return null;
      },
    );
  }





  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _userNameController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

