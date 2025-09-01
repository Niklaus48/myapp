
import 'package:flutter/material.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/viewmodels/user_viewmodel.dart';
import 'package:provider/provider.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _middleNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _addressController;
  late TextEditingController _postCodeController;

  @override
  void initState() {
    super.initState();
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    userViewModel.loadUser();
    _firstNameController = TextEditingController(text: userViewModel.user?.firstName);
    _middleNameController =
        TextEditingController(text: userViewModel.user?.middleName);
    _lastNameController = TextEditingController(text: userViewModel.user?.lastName);
    _phoneNumberController =
        TextEditingController(text: userViewModel.user?.phoneNumber);
    _addressController = TextEditingController(text: userViewModel.user?.address);
    _postCodeController = TextEditingController(text: userViewModel.user?.postCode);
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      body: userViewModel.user == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(labelText: 'First Name'),
                    ),
                    TextFormField(
                      controller: _middleNameController,
                      decoration: const InputDecoration(labelText: 'Middle Name'),
                    ),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                    ),
                    TextFormField(
                      controller: _phoneNumberController,
                      decoration: const InputDecoration(labelText: 'Phone Number'),
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(labelText: 'Address'),
                    ),
                    TextFormField(
                      controller: _postCodeController,
                      decoration: const InputDecoration(labelText: 'Post Code'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final updatedUser = User(
                            uid: userViewModel.user!.uid,
                            email: userViewModel.user!.email,
                            firstName: _firstNameController.text,
                            middleName: _middleNameController.text,
                            lastName: _lastNameController.text,
                            phoneNumber: _phoneNumberController.text,
                            address: _addressController.text,
                            postCode: _postCodeController.text,
                          );
                          userViewModel.updateUser(updatedUser);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Profile updated successfully')),
                          );
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
