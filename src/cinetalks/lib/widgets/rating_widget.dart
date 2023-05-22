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
  final AppDatabase _databaseService = AppDatabase();
  bool _isEditing = false;
  TextEditingController _ratingController = TextEditingController();
  int rating = 0;

  @override
  initState() {
    super.initState();
      _databaseService.getRating(widget.uid, widget.id).then((value) {
      setState(() {
        rating = value;
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
      return rating == 0 ? _buildTextField() :  
      Text(
        '${rating}/10',
        style: TextStyle(color: Colors.white,));
  }

  Widget _buildTextField(){
    return SizedBox(
      width: 100,
      height: 30,
      child: TextField(
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
        controller: _ratingController,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          hintText: 'Enter rating...',
          hintStyle: TextStyle(color: Colors.white),
        ),
        onSubmitted: (value) {
          if (int.parse(_ratingController.text) > 10) {
            _ratingController.text = '10';
          }
          if (int.parse(_ratingController.text) < 1) {
            _ratingController.text = '1';
          }
          rating = _ratingController.text == '' ? 0 : int.parse(_ratingController.text);
          _databaseService.updateRating(widget.uid, widget.id, int.parse(_ratingController.text));
          setState(() {
            _isEditing = false;
          });
        },
      ),

    );
  }


}

