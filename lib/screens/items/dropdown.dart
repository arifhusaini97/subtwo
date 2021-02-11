import 'package:flutter/material.dart';
 
class DropDown extends StatefulWidget {

  final List<String> _organizationType;
  DropDown(this._organizationType) : super();
 
  @override
  DropDownState createState() => DropDownState(_organizationType);
}
 
 
class DropDownState extends State<DropDown> {
  List<String> _organizationType;
  DropDownState(this._organizationType);
  List<DropdownMenuItem<String>> _dropdownMenuItems;
  String _selectedType;
 
  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_organizationType);
    _selectedType = _dropdownMenuItems[0].value;
    super.initState();
  }
 
  List<DropdownMenuItem<String>> buildDropdownMenuItems(List organizationTypes) {
    List<DropdownMenuItem<String>> items = List();
    for (String organizationType in organizationTypes) {
      items.add(
        DropdownMenuItem(
          value: organizationType,
          child: Text(organizationType),
        ),
      );
    }
    return items;
  }
 
  onChangeDropdownItem(String selectedType) {
    setState(() {
      _selectedType = selectedType;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
                  value: _selectedType,
                  items: _dropdownMenuItems,
                  onChanged: onChangeDropdownItem,
                );
  }
}