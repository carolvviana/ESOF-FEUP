import 'package:flutter/material.dart';

import '../database_service/app_database.dart';

class RatingWidget extends StatefulWidget {
  final String id;
  final String uid;

  RatingWidget({Key? key, required this.id, required this.uid})
      : super(key: key);

  @override
  State<RatingWidget> createState() => _RatingInputState();
}

class _RatingInputState extends State<RatingWidget> {
  int? selectedRating = null;

  int currentRating = 0;

  final AppDatabase _databaseService = AppDatabase();
  bool _isEditing = false;

  @override
  initState() {
    super.initState();
    _databaseService.getRating(widget.uid, widget.id).then((value) {
      setState(() {
        currentRating = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isEditing = true;
        });
      },
      child: _isEditing ? _buildTextField() : _buildText(),
    );
  }

  Widget _buildText() {
    return currentRating == 0
        ? _buildTextField()
        : Text('${currentRating}/10',
            style: TextStyle(
              color: Colors.white,
            ));
  }

  Widget _buildTextField() {
    return SizedBox(
        width: 120,
        height: 30,
        child: DropdownButton<int>(
          // style: TextStyle(color: Colors.white),
          value: selectedRating,
          hint: Text('Select Rating',
              style: TextStyle(
                color: Colors.white,
              )),
          onChanged: (value) {
            setState(() {
              currentRating = value!;
              _isEditing = false;
            });
            _databaseService.updateRating(widget.uid, widget.id, value!);
          },
          items: List.generate(10, (index) {
            final rating = index + 1;
            return DropdownMenuItem<int>(
              value: rating,
              child: Text(rating.toString()),
            );
          }),
        ));
  }
}
