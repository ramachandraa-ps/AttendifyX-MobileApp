import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:io';

class ManualCheckInCheckOut extends StatefulWidget {
  @override
  _ManualCheckInCheckOutState createState() => _ManualCheckInCheckOutState();
}

class _ManualCheckInCheckOutState extends State<ManualCheckInCheckOut> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  String _location = 'Unknown location';
  String _checkInTime = '';
  String _checkOutTime = '';
  String _duration = '00:00:00';
  Timer? _timer;
  DateTime? _checkInDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manual Check-In/Check-Out'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Image Section
            GestureDetector(
              onTap: _pickImage,
              child: Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _imageFile == null
                      ? null
                      : FileImage(File(_imageFile!.path)),
                  child: _imageFile == null
                      ? Icon(Icons.camera_alt, size: 40)
                      : null,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Location: $_location', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: Text('Fetch Location'),
            ),
            SizedBox(height: 20),
            if (_checkInTime.isEmpty) ...[
              ElevatedButton(
                onPressed: _checkIn,
                child: Text('Check-In'),
              ),
            ] else if (_checkOutTime.isEmpty) ...[
              ElevatedButton(
                onPressed: _checkOut,
                child: Text('Check-Out'),
              ),
            ],
            SizedBox(height: 20),
            if (_checkInTime.isNotEmpty) ...[
              Text('Checked In At: $_checkInTime'),
              SizedBox(height: 10),
              Text('Duration: $_duration'),
            ],
            if (_checkOutTime.isNotEmpty) ...[
              Text('Checked Out At: $_checkOutTime'),
              SizedBox(height: 10),
              Text('Location on Checkout: $_location'),
            ],
          ],
        ),
      ),
    );
  }

  // Method to pick image
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  // Method to get current location and detailed address
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);

      Placemark place = placemarks[0];
      setState(() {
        _location =
        '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
      });
    } catch (e) {
      print(e);
      setState(() {
        _location = 'Unable to fetch location';
      });
    }
  }

  // Method to handle Check-In
  void _checkIn() {
    setState(() {
      _checkInDateTime = DateTime.now();
      _checkInTime = _formatDateTime(_checkInDateTime!);
      _startTimer();
    });
  }

  // Method to handle Check-Out
  void _checkOut() {
    setState(() {
      _checkOutTime = _formatDateTime(DateTime.now());
      _stopTimer();
    });
  }

  // Method to start the timer
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

  // Method to stop the timer
  void _stopTimer() {
    _timer?.cancel();
  }

  // Method to format DateTime as a string
  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  // Method to format Duration as a string
  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
