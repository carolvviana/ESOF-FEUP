import 'dart:ui';

import 'package:cinetalks/screens/movie_show_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../database_service/app_database.dart';
import '../models/movie_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RatingWidget extends StatefulWidget {
  String id;
  String uid;

  RatingWidget({Key? key, required this.id, required this.uid}) : super(key: key);

  @override
  State<RatingWidget> createState() => _RatingInputState();
}

class _RatingInputState extends State<RatingWidget> {
  int? selectedRating = null;

  final AppDatabase _databaseService = AppDatabase();
  bool _isEditing = false;
  String? _ratingError = null;

  @override
  initState() {
    super.initState();
      _databaseService.getRating(widget.uid, widget.id).then((value) {
      setState(() {
        selectedRating = value;
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () {
        setState(() {
          _isEditing = true;
        });
      },
      child: _isEditing ? _buildTextField() : _buildText(),
    );
  }

  Widget _buildText(){
      return selectedRating == 0 ? _buildTextField() :  
      Text(
        '${selectedRating}/10',
        style: TextStyle(color: Colors.white,));
  }

  Widget _buildTextField(){
    return SizedBox(
      width: 120,
      height: 30,
      child: DropdownButton<int>(
        // style: TextStyle(color: Colors.white),
      value: selectedRating,
      hint: Text('Select Rating', style: TextStyle(color: Colors.white,)),
      onChanged: (value) {
        setState(() {
          selectedRating = value!;
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
    )

    );
  }


}
