import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Import file_picker package

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Donation Form',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.red, // Set scaffold background color to red
      ),
      home: DonationForm(),
    );
  }
}

class DonationForm extends StatefulWidget {
  @override
  _DonationFormState createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _donorName = '';
  int _donorAge = 18;
  String? _donorGender;
  String? _donorBloodGroup;
  String _donorAdditionalNumber = '';
  String _addressPinCode = '';
  String? _donatedPlatelets;
  int _numberOfDonations = 0;
  DateTime? _lastDonationDate; // Nullable DateTime for last donation date
  String? _medicalCondition;
  String? _drinkingAndSmoking;
  String? _willDonateBlood;
  String _donationExperience = '';
  String _donationFilePath = ''; // Path of the uploaded file

  // State variable to hold form details for display
  Map<String, dynamic> _formDetails = {};

  // Method to handle file selection
  void _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _donationFilePath = result.files.single.path ?? '';
      });
    }
  }

  // Method to show date picker
  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _lastDonationDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _lastDonationDate) {
      setState(() {
        _lastDonationDate = picked;
      });
    }
  }

  // Method to handle form submission
  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      setState(() {
        _formDetails = {
          'Email': _email,
          'Donor Name': _donorName,
          'Donor Age': _donorAge,
          'Donor Gender': _donorGender,
          'Donor Blood Group': _donorBloodGroup,
          'Donor Additional Number': _donorAdditionalNumber,
          'Address Pin Code': _addressPinCode,
          'Donated Platelets': _donatedPlatelets,
          'Number of Donations': _numberOfDonations,
          'Last Donation Date': _lastDonationDate != null
              ? '${_lastDonationDate?.day}/${_lastDonationDate?.month}/${_lastDonationDate?.year}'
              : '',
          'Medical Condition': _medicalCondition,
          'Drinking and Smoking': _drinkingAndSmoking,
          'Will Donate Blood': _willDonateBlood,
          'Donation Experience': _donationExperience,
          'Donation File Path': _donationFilePath,
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Donation Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email ID'),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your email address';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _email = value ?? '';
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Donor Name'),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _donorName = value ?? '';
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Donor Age'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your age';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _donorAge = int.tryParse(value ?? '18') ?? 18;
                      });
                    },
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Donor Gender'),
                    value: _donorGender,
                    items: ['Male', 'Female', 'Binary'].map((gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _donorGender = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select your gender';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Donor Blood Group'),
                    value: _donorBloodGroup,
                    items: [
                      'A rhD positive(A+)',
                      'A rhD negative(A-)',
                      'B rhD positive(B+)',
                      'B rhD negative(B-)',
                      'O rhD positive(O+)',
                      'O rhD negative(O-)',
                      'AB rhD positive(AB+)',
                      'AB rhD negative(AB-)'
                    ].map((group) {
                      return DropdownMenuItem<String>(
                        value: group,
                        child: Text(group),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _donorBloodGroup = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select your blood group';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Donor Additional Number'),
                    onChanged: (value) {
                      setState(() {
                        _donorAdditionalNumber = value ?? '';
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Address Pin Code'),
                    onChanged: (value) {
                      setState(() {
                        _addressPinCode = value ?? '';
                      });
                    },
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Have you donated platelets?'),
                    value: _donatedPlatelets,
                    items: ['Yes', 'No'].map((answer) {
                      return DropdownMenuItem<String>(
                        value: answer,
                        child: Text(answer),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _donatedPlatelets = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Number of Donations Made'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _numberOfDonations = int.tryParse(value ?? '0') ?? 0;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Last Date of Donation'),
                    readOnly: true,
                    onTap: _selectDate,
                    validator: (value) {
                      if (_lastDonationDate == null) {
                        return 'Please select the last date of donation';
                      }
                      return null;
                    },
                    controller: TextEditingController(
                      text: _lastDonationDate != null
                          ? '${_lastDonationDate?.day}/${_lastDonationDate?.month}/${_lastDonationDate?.year}'
                          : '',
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Are you under any medical condition?'),
                    value: _medicalCondition,
                    items: ['Yes', 'No'].map((answer) {
                      return DropdownMenuItem<String>(
                        value: answer,
                        child: Text(answer),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _medicalCondition = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Drinking and Smoking?'),
                    value: _drinkingAndSmoking,
                    items: ['Yes', 'No'].map((answer) {
                      return DropdownMenuItem<String>(
                        value: answer,
                        child: Text(answer),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _drinkingAndSmoking = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Will you donate blood if you stay close to needy?'),
                    value: _willDonateBlood,
                    items: ['Yes', 'No'].map((answer) {
                      return DropdownMenuItem<String>(
                        value: answer,
                        child: Text(answer),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _willDonateBlood = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Write a few lines about your blood donation experience'),
                    maxLines: 3,
                    onChanged: (value) {
                      setState(() {
                        _donationExperience = value ?? '';
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Upload Donation File:',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: _selectFile,
                    child: Text('Select File'),
                  ),
                  if (_donationFilePath.isNotEmpty)
                    Text('Selected File: $_donationFilePath'),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _handleSubmit,
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.0),
            if (_formDetails.isNotEmpty)
              Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _formDetails.entries.map((entry) {
                    return Text('${entry.key}: ${entry.value}');
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
