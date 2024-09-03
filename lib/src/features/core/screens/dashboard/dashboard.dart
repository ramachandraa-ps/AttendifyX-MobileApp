import 'package:attendifyx/src/constants/image_strings.dart';
import 'package:attendifyx/src/constants/sizes.dart';
import 'package:attendifyx/src/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:attendifyx/src/features/manual_checkin_checkout.dart';  // Import the manual check-in/out page

import '../../../../constants/text_strings.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isMenuOpen = false;
  bool _isProfileOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  void _animateText(bool isMenuButton) {
    setState(() {
      if (isMenuButton) {
        _isMenuOpen = !_isMenuOpen;
      } else {
        _isProfileOpen = !_isProfileOpen;
      }
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              _animateText(true);
              _showMenu(context);
            },
          ),
          title: Text(tAppName, style: AppTextStyles.headline1),
          centerTitle: true,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                _animateText(false);
                _showProfileOptions(context);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10, top: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ClipOval(
                  child: Image.asset(
                    tUserIcon,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(tDashboardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Profile Section
                _buildUserProfileSection(),

                // Dashboard Sections
                SizedBox(height: 20),
                _buildProgressSection('Geo-location Based Attendance Tracking', 'In Progress', Colors.blue),
                SizedBox(height: 20),
                _buildProgressSection('Payroll Management', 'Pending', Colors.orange),

                // Manual Check-In/Check-Out Section
                SizedBox(height: 20),
                _buildManualCheckInCheckOutSection(),

                // Additional Sections (if needed)
                SizedBox(height: 20),
                _buildAdditionalSections(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget for User Profile Section
  Widget _buildUserProfileSection() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                tUserIcon,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Employee Name', // Replace with dynamic user name
                    style: AppTextStyles.headline2,
                  ),
                  Text(
                    'Employee@gmail.com', // Replace with dynamic email
                    style: AppTextStyles.bodyText1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Progress Section
  Widget _buildProgressSection(String title, String progress, Color color) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              Icons.check_circle_outline, // Replace with appropriate icons
              color: color,
              size: 40,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.headline2,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Status: $progress',
                    style: AppTextStyles.bodyText2.copyWith(color: color),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Manual Check-In/Check-Out Section
  Widget _buildManualCheckInCheckOutSection() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
          leading: Icon(
            Icons.access_time, // Replace with appropriate icons
            color: Colors.blue,
            size: 40,
          ),
          title: Text(
            'Manual Check-In/Check-Out',
            style: AppTextStyles.headline2,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ManualCheckInCheckOut()), // Navigate to the check-in/out page
            );
          },
        ),
      ),
    );
  }

  // Widget for Additional Sections
  Widget _buildAdditionalSections() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Information',
          style: AppTextStyles.headline2,
        ),
        SizedBox(height: 10),
        // Add any other sections or widgets as needed
      ],
    );
  }

  // Method to show menu options
  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle Settings
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                // Handle About
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help & Support'),
              onTap: () {
                // Handle Help & Support
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // Method to show profile options
  void _showProfileOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person),
              title: Text('My Profile'),
              onTap: () {
                // Navigate to My Profile
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.payments),
              title: Text('Payslip'),
              onTap: () {
                // Navigate to Payslip
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.analytics),
              title: Text('Summary'),
              onTap: () {
                // Navigate to Summary
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to Settings
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Handle Logout
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
