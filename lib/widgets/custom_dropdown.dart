import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String hint;
  final List<String> list;
  final Function onChanged;
  final IconData? iconData;

  const CustomDropdown({
    required this.hint,
    required this.list,
    required this.onChanged,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor.withOpacity(0.3),
        border:
            Border.all(color: Theme.of(context).accentColor.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            color: Theme.of(context).accentColor,
          ),
          const SizedBox(width: 15),
          DropdownButton<String>(
            hint: Text(
              hint,
              textScaleFactor: 1.1,
              style: const TextStyle(color: Colors.white),
            ),
            items: list.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? val) {
              FocusScope.of(context).requestFocus(FocusNode());
              onChanged(val);
            },
          ),
        ],
      ),
    );
  }
}
