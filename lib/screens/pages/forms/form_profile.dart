import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:subtwo/models/organization_model.dart';
import 'package:subtwo/models/user_model.dart';
import 'package:subtwo/screens/items/dropdown.dart';
import 'package:subtwo/screens/shared/constants.dart';
import 'package:subtwo/screens/shared/loading.dart';
import 'package:subtwo/services/database.dart';

class Association {
  static final List<String> _associations = [
    'UiTM Negeri Sembilan',
    'UiTM Shah Alam',
    'UniSZA',
    'UPM',
    'UIAM',
    'UTM',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = List();
    matches.addAll(_associations);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}

class Industry {
  static final List<String> _industries = [
    'Mathematics',
    'Statistics',
    'Computer Sciences',
    'Engineerings',
    'Digitals',
    'Data Sciences',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = List();
    matches.addAll(_industries);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}

class FormProfile extends StatefulWidget {
  FormProfile({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FormProfileState createState() => _FormProfileState();
}

class _FormProfileState extends State<FormProfile> {
  @override
  void initState() {
    super.initState();
  }

  // List<String> _suggestGender = [
  //   "Male",
  //   "Female",
  //   "Rather Not Say",
  // ];

  // List<String> _suggestMarriageStatus = [
  //   "Single",
  //   "Married",
  //   "Rather Not Say",
  // ];

  String _fullname;
  String _username;
  String _studentID;
  final List<String> _gender = ['Male', 'Female', 'Rather Not Say'];
  String _currentGender;
  final List<String> _marriageStatus = ['Single', 'Married', 'Rather Not Say'];
  String _currentMarriageStatus;
  Timestamp _birthDate;
  final format = DateFormat('EEE, MMM d, ' 'yyyy');

  List<String> _suggestDistrict = [
    "Damansara",
    "Ipoh",
    "Kampar",
    "Klang",
  ];
  List<String> _suggestState = [
    "Perak Darul Ridzuan",
    "Selangor Darul Ehsan",
  ];
  List<String> _suggestCountry = [
    "Brunei",
    "Cambodia",
    "Indonesia",
    "Malaysia",
    "Philipines",
    "Singapore",
    "Thailand",
    "Vietnam",
  ];

  //final _autoCompletedKey = GlobalKey<AutoCompleteTextFieldState>();
  final _formKey = GlobalKey<FormState>();
  final _user = CreateOrganizationModel();
  final _inputAssociation = TextEditingController(text: '');
  final _inputIndustry = TextEditingController(text: '');
  bool loading = false;
  String _email = '';
  String _error = '';

  List<String> added = [];
  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<String>> _autoCompletedKeyAssociation =
      new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> _autoCompletedKeyIndustry =
      new GlobalKey();

  SimpleAutoCompleteTextField textField;
  bool showWhichErrorText = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: StreamBuilder<UserModel>(
                stream: DatabaseService(uid: user.uid).userData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    UserModel userData = snapshot.data;
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            initialValue: userData.fullname,
                            onChanged: (String value) {
                              setState(() => _fullname = value);
                            },
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                            ),
                            obscureText: false,
                            decoration: textInputDecoration.copyWith(
                              labelText: 'Fullname',
                            ),
                            validator: (String value) {
                              if (value.trim().isEmpty) {
                                return 'Fullname is required';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            initialValue: userData.username,
                            onChanged: (String value) {
                              setState(() => _username = value);
                            },
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                            ),
                            obscureText: false,
                            decoration: textInputDecoration.copyWith(
                              labelText: 'Username',
                            ),
                            validator: (String value) {
                              if (value.trim().isEmpty) {
                                return 'Username is required';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            initialValue: userData.studentID,
                            onChanged: (String value) {
                              setState(() => _studentID = value);
                            },
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                            ),
                            obscureText: false,
                            decoration: textInputDecoration.copyWith(
                              labelText: 'Student ID',
                            ),
                            validator: (String value) {
                              if (value.trim().isEmpty) {
                                return 'Student ID is required';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          //dropdown
                          DropdownButtonFormField(
                            decoration: textInputDecoration.copyWith(
                              labelText: 'Gender',
                            ),
                            value: _currentGender ?? userData.gender,
                            items: _gender.map((gender) {
                              return DropdownMenuItem(
                                  value: gender, child: Text(gender));
                            }).toList(),
                            onChanged: (val) =>
                                setState(() => _currentGender = val),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          //dropdown
                          DropdownButtonFormField(
                            decoration: textInputDecoration.copyWith(
                              labelText: 'Marriage Status',
                            ),
                            value: _currentMarriageStatus ??
                                userData.marriageStatus,
                            items: _marriageStatus.map((marriageStatus) {
                              return DropdownMenuItem(
                                  value: marriageStatus,
                                  child: Text(marriageStatus));
                            }).toList(),
                            onChanged: (val) =>
                                setState(() => _currentMarriageStatus = val),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          DateTimeField(
                            initialValue: userData.birthDate != null
                                ? userData.birthDate.toDate()
                                : DateTime.now(),
                            decoration: textInputDecoration.copyWith(
                              labelText: 'Birth Date',
                            ),
                            format: format,
                            onChanged: (date) => setState(() {
                              date != null
                                  ? _birthDate = Timestamp.fromDate(date)
                                  : _birthDate = _birthDate;
                            }),
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: userData.birthDate != null
                                    ? userData.birthDate.toDate()
                                    : DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          RaisedButton(
                            //shape: ShapeBorder.lerp(ShapeBorder(10.0), null, 18.0),
                            //shape: ShapeBorder(border: BorderRadius.all(Radius.circular(16.0))),
                            padding: EdgeInsets.symmetric(
                                horizontal: 90.0, vertical: 16.0),
                            color: Colors.brown[700],
                            textColor: Colors.brown[200],
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                await DatabaseService(uid: user.uid)
                                    .updateUserData(
                                  _fullname ?? userData.fullname,
                                  _username ?? userData.username,
                                  _currentGender ?? userData.gender,
                                  _currentMarriageStatus ??
                                      userData.marriageStatus,
                                  _studentID ?? userData.studentID,
                                  _birthDate ?? userData.birthDate,
                                );
                                // Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            _error,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Loading();
                  }
                })

            // Form(
            //   key: _formKey,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       SizedBox(
            //         height: 10.0,
            //       ),
            //       Text('Name: '),
            //       _fieldNormal('Name', 'Ex: NUR ARIF HUSAINI BIN NORWAZA',
            //           'Please insert your fullname', 1),
            //       SizedBox(
            //         height: 10.0,
            //       ),
            //       Text('Username: '),
            //       _fieldNormal('Username', 'Ex: arifhusaini97',
            //           'Please insert your account username', 1),
            //       SizedBox(
            //         height: 10.0,
            //       ),
            //       Text('Gender: '),
            //       DropDown(_suggestGender),
            //       SizedBox(
            //         height: 10.0,
            //       ),
            //       Text('Marriage Status: '),
            //       DropDown(_suggestMarriageStatus),
            //       SizedBox(
            //         height: 10.0,
            //       ),
            //       Text("Birth Date (YYYY-MM-DD):"),
            //       SizedBox(
            //         height: 10.0,
            //       ),
            //       InkWell(
            //         child: Text(
            //             "${birthDate.year} - ${birthDate.month} - ${birthDate.day}"),
            //         onTap: () async {
            //           DateTime picked = await showDatePicker(
            //               context: context,
            //               initialDate: birthDate,
            //               firstDate: DateTime(birthDate.year - 5),
            //               lastDate: DateTime(birthDate.year + 5));
            //           if (picked != null) {
            //             setState(() {
            //               birthDate = picked;
            //             });
            //           }
            //         },
            //       ),

            //       // ListTile(
            //       //   title: Text("Birth Date (YYYY-MM-DD):"),
            //       //   subtitle: Text(
            //       //       "${birthDate.year} - ${birthDate.month} - ${birthDate.day}"),
            //       //   onTap: () async {
            //       //     DateTime picked = await showDatePicker(
            //       //         context: context,
            //       //         initialDate: birthDate,
            //       //         firstDate: DateTime(birthDate.year - 5),
            //       //         lastDate: DateTime(birthDate.year + 5));
            //       //     if (picked != null) {
            //       //       setState(() {
            //       //         birthDate = picked;
            //       //       });
            //       //     }
            //       //   },
            //       // ),
            //       SizedBox(
            //         height: 10.0,
            //       ),
            //       Text('Contact Number: '),
            //       _fieldNormal('Contact Number', 'Ex: 0136362373',
            //           'Please insert your contact number', 1),
            //       SizedBox(
            //         height: 10.0,
            //       ),
            //       Text('Email: '),
            //       _fieldNormal('Email', 'Ex: arifhusaini97@gmail.com',
            //           'Please insert your email', 1),
            //       SizedBox(
            //         height: 10.0,
            //       ),
            //       Text('IC Number: '),
            //       _fieldNormal('IC Number', 'Ex: 940313-04-3204',
            //           'Please insert your IC number', 1),
            //       SizedBox(
            //         height: 10.0,
            //       ),
            //       //textQuery, Extended text field
            //       Text('Association: '),
            //       _fieldAutoCompleted(
            //         'Association',
            //         'Ex: Universiti Teknologi MARA (UiTM)',
            //         _autoCompletedKeyAssociation,
            //         _inputAssociation,
            //         'Please insert association',
            //       ),

            //       SizedBox(
            //         height: 10.0,
            //       ),
            //       Text('Industry: '),
            //       _fieldAutoCompleted(
            //         'Industry',
            //         'Ex: Mathematics',
            //         _autoCompletedKeyIndustry,
            //         _inputIndustry,
            //         'Please insert industry',
            //       ),
            //       SizedBox(
            //         height: 10.0,
            //       ),
            //       Text('District: '),
            //       DropDown(_suggestDistrict),
            //       SizedBox(
            //         height: 10.0,
            //       ),
            //       Text('State: '),
            //       DropDown(_suggestState),
            //       SizedBox(
            //         height: 10.0,
            //       ),
            //       Text('State: '),
            //       DropDown(_suggestCountry),
            //       SizedBox(
            //         height: 10.0,
            //       ),
            //       Text('About: '),
            //       _fieldNormal('About', 'Ex: I am a cool programmer......',
            //           'Please describe something about yourself', 4),
            //       SizedBox(
            //         height: 10.0,
            //       ),
            //       //                 _FirstPageState() {
            //       //   textField = SimpleAutoCompleteTextField(
            //       //     key: key,
            //       //     decoration: new InputDecoration(errorText: "Beans"),
            //       //     controller: TextEditingController(text: "Starting Text"),
            //       //     suggestions: suggestions,
            //       //     textChanged: (text) => currentText = text,
            //       //     clearOnSubmit: true,
            //       //     textSubmitted: (text) => setState(() {
            //       //           if (text != "") {
            //       //             added.add(text);
            //       //           }
            //       //         }),
            //       //   );
            //       // }

            //       // Container(
            //       //   padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
            //       //   child: Text('Subscribe'),
            //       // ),
            //       // SwitchListTile(
            //       //   title: Text('Monthly Newsletter'),
            //       //   value: _user.newsletter,
            //       //   onChanged: (bool value) =>
            //       //       setState(() => _user.newsletter = value),
            //       // ),
            //       // Container(
            //       //   padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
            //       //   child: Text('Interest'),
            //       // ),
            //       // CheckboxListTile(
            //       //   title: Text('Hiking'),
            //       //   value: _user.passions[User.PassionHiking],
            //       //   onChanged: (bool value) => setState(
            //       //       () => _user.passions[User.PassionHiking] = value),
            //       // ),
            //       // CheckboxListTile(
            //       //   title: Text('Swimming'),
            //       //   value: _user.passions[User.PassionSwimming],
            //       //   onChanged: (bool value) => setState(
            //       //       () => _user.passions[User.PassionSwimming] = value),
            //       // ),
            //       // CheckboxListTile(
            //       //   title: Text('Flying'),
            //       //   value: _user.passions[User.PassionFlying],
            //       //   onChanged: (bool value) => setState(
            //       //       () => _user.passions[User.PassionFlying] = value),
            //       // ),
            //       Center(
            //         child: Container(
            //           padding:
            //               EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            //           child: RaisedButton(
            //             child: Text('Submit'),
            //             color: Colors.purple,
            //             textColor: Colors.white,
            //             onPressed: () {
            //               final form = _formKey.currentState;
            //               if (form.validate()) {
            //                 form.save();
            //                 _user.save();
            //                 _showDialog(context);
            //               }
            //             },
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Submiting request to be approved'),
      ),
    );
  }

  Widget _fieldNormal(
      String _name, String _example, String _validate, int _maxLines) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 0.0,
        vertical: 0.0,
      ),
      child: TextFormField(
        maxLines: _maxLines,
        keyboardType: _keyboardType(_name),
        decoration: InputDecoration(
          border: _name == 'About' ? OutlineInputBorder() : null,
          hintText: _example,
        ),
        validator: (value) {
          if (value.isEmpty) {
            return _validate;
          }
          return null;
        },
        onSaved: _contain(_name),
      ),
    );
  }

  TextInputType _keyboardType(_name) {
    switch (_name) {
      case 'Contact Number':
        return TextInputType.phone;
        break;
      case 'Email':
        return TextInputType.emailAddress;
        break;
      default:
        return TextInputType.text;
        break;
    }
  }

  _contain(_name) {
    switch (_name) {
      case 'Name':
        (value) => setState(
              () => _user.fullname = value,
            );
        break;
      case 'Username ':
        (value) => setState(
              () => _user.username = value,
            );
        break;
      case 'Contact Number':
        (value) => setState(
              () => _user.telNo = value,
            );
        break;
      case 'Email':
        (value) => setState(
              () => _user.email = value,
            );
        break;
      case 'IC Number':
        (value) => setState(
              () => _user.regRos = value,
            );
        break;
      case 'Association':
        (value) => setState(
              () => _user.isUnder = value,
            );
        break;
      case 'Industry':
        (value) => setState(
              () => _user.industry = value,
            );
        break;
      case 'About':
        (value) => setState(
              () => _user.about = value,
            );
        break;
    }
  }

  Widget _fieldAutoCompleted(
    String _name,
    String _example,
    GlobalKey _autoCompletedKey,
    TextEditingController _input,
    String _validate,
    // String _validate
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.0),
      child: TypeAheadFormField(
        key: _autoCompletedKey,
        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            hintText: _example,
          ),
          controller: _input,
        ),
        suggestionsCallback: (pattern) {
          return _name == 'Association'
              ? Association.getSuggestions(pattern)
              : Industry.getSuggestions(pattern);
        },
        itemBuilder: (context, _suggestions) {
          return ListTile(
            title: Text(_suggestions),
          );
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        onSuggestionSelected: (suggestion) {
          _input.text = suggestion;
        },
        validator: (value) {
          if (value.isEmpty) {
            return _validate;
          }
          return null;
        },
        onSaved: _contain(_name),
      ),
    );
  }
}
