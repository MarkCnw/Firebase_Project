import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planmate/Selection%20Profile/Widgets/avatar_widget.dart';
import 'package:planmate/Home/presentation/home.dart';

// สร้าง Avatar Model เพื่อความชัดเจน
class AvatarData {
  final String name;
  final String imagePath;
  
  const AvatarData({
    required this.name,
    required this.imagePath,
  });
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? selectedAvatar;
  
  // รายการ Avatar ที่มีให้เลือก
  static const List<AvatarData> availableAvatars = [
    AvatarData(
      name: "Ironman",
      imagePath: 'assets/avatar/avatar1.png',
    ),
    AvatarData(
      name: "Batman", 
      imagePath: 'assets/avatar/avatar3.png',
    ),
    AvatarData(
      name: "Spiderman",
      imagePath: 'assets/avatar/avatar2.png',
    ),
  ];

  void _selectAvatar(String avatarName) {
    setState(() {
      selectedAvatar = avatarName;
    });
  }

  void _confirmSelection() {
    if (selectedAvatar == null) return;
    
    // หา avatar data ที่เลือก
    final selectedAvatarData = availableAvatars.firstWhere(
      (avatar) => avatar.name == selectedAvatar,
    );
    
    // นำทางไปยัง HomeScreen พร้อมส่งข้อมูล avatar
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomeScreen(selectedAvatar: selectedAvatarData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6874E),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTitle(),
                  const SizedBox(height: 40),
                  _buildHeaderImage(),
                  const SizedBox(height: 35),
                  _buildAvatarSelection(),
                  const SizedBox(height: 60),
                  _buildConfirmButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text(
        "Who is You?",
        style: GoogleFonts.chakraPetch(
          fontSize: 37,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return SvgPicture.asset(
      'assets/avatar/team_profile.svg',
      width: 300,
      height: 300,
    );
  }

  Widget _buildAvatarSelection() {
    return Wrap(
      spacing: 10,
      alignment: WrapAlignment.center,
      children: availableAvatars.map((avatar) {
        return AvatarItem(
          imagePath: avatar.imagePath,
          name: avatar.name,
          isSelected: selectedAvatar == avatar.name,
          onTap: () => _selectAvatar(avatar.name),
        );
      }).toList(),
    );
  }

  Widget _buildConfirmButton() {
    final bool isEnabled = selectedAvatar != null;
    
    return ElevatedButton(
      onPressed: isEnabled ? _confirmSelection : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? Colors.black : Colors.grey,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: const Size(330, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      child: Text(
        "Confirm",
        style: GoogleFonts.chakraPetch(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}