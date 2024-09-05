import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class ManualCheckInCheckOut extends StatefulWidget {
  @override
  _ManualCheckInCheckOutState createState() => _ManualCheckInCheckOutState();
}

class _ManualCheckInCheckOutState extends State<ManualCheckInCheckOut> {
  final ImagePicker _picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  XFile? _imageFile;
  String _location = 'Unknown location';
  String _checkInTime = '';
  String _checkOutTime = '';
  String _duration = '00:00:00';
  Timer? _timer;
  DateTime? _checkInDateTime;
  bool _isLoading = false;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manual Check-In/Check-Out',
          style: TextStyle(
              fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _imageFile == null
                      ? null
                      : FileImage(File(_imageFile!.path)),
                  child: _imageFile == null
                      ? Icon(Icons.camera_alt, size: 40, color: Colors.black54)
                      : null,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Location:',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Text(_location,
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    color: Colors.grey[700])),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text('Fetch Location',
                  style: TextStyle(fontFamily: 'Roboto', fontSize: 18)),
            ),
            SizedBox(height: 20),
            if (_checkInTime.isEmpty) ...[
              ElevatedButton(
                onPressed: _imageFile == null ? null : _checkIn,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('Check-In',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 18)),
              ),
            ] else if (_checkOutTime.isEmpty) ...[
              ElevatedButton(
                onPressed: _checkOut,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('Check-Out',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 18)),
              ),
            ],
            SizedBox(height: 20),
            if (_checkInTime.isNotEmpty) ...[
              Text('Checked In At:',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Text(_checkInTime,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      color: Colors.grey[700])),
              SizedBox(height: 10),
              Text('Duration:',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Text(_duration,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      color: Colors.grey[700])),
            ],
            if (_checkOutTime.isNotEmpty) ...[
              Text('Checked Out At:',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Text(_checkOutTime,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      color: Colors.grey[700])),
              SizedBox(height: 10),
              Text('Location on Checkout:',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Text(_location,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      color: Colors.grey[700])),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetCheckInCheckOut,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('Check-In Again',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 18)),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      setState(() {
        _imageFile = pickedFile;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera permission is required.')),
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);

        Placemark place = placemarks[0];
        setState(() {
          _location =
          '${place.street ?? ''}, ${place.locality ?? ''}, ${place.postalCode ?? ''}, ${place.country ?? ''}';
        });
      } catch (e) {
        print(e);
        setState(() {
          _location = 'Unable to fetch location';
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permission is required.')),
      );
    }
  }

  Future<void> _checkIn() async {
    setState(() {
      _isLoading = true;
    });
    if (_imageFile != null) {
      String imageUrl = await _uploadImageToFirebase(_imageFile!);

      setState(() {
        _checkInDateTime = DateTime.now();
        _checkInTime = _formatDateTime(_checkInDateTime!);
        _startTimer();
      });

      await _firestore.collection('checkins').add({
        'userId': _user?.uid,
        'checkInTime': _checkInTime,
        'location': _location,
        'imageUrl': imageUrl,
        'duration': _duration,
        'type': 'Check-In'
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please take a picture for check-in.')),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _checkOut() async {
    setState(() {
      _checkOutTime = _formatDateTime(DateTime.now());
      _stopTimer();
    });

    await _firestore.collection('checkins').add({
      'userId': _user?.uid,
      'checkOutTime': _checkOutTime,
      'location': _location,
      'duration': _duration,
      'type': 'Check-Out'
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_checkInDateTime != null) {
        final duration = DateTime.now().difference(_checkInDateTime!);
        setState(() {
          _duration = _formatDuration(duration);
        });
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<String> _uploadImageToFirebase(XFile imageFile) async {
    final ref = _storage.ref().child('checkin_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final uploadTask = ref.putFile(File(imageFile.path));
    final snapshot = await uploadTask.whenComplete(() {});
    final imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  void _resetCheckInCheckOut() {
    setState(() {
      _checkInTime = '';
      _checkOutTime = '';
      _location = 'Unknown location';
      _duration = '00:00:00';
      _imageFile = null;
      _checkInDateTime = null;
    });
  }
}
