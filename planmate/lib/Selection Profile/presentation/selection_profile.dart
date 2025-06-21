import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planmate/Home/presentation/home.dart';
import 'package:planmate/Selection%20Profile/Widgets/avatar_widget.dart';

class ProfileScreen extends StatefulWidget {  // เปลี่ยนเป็น StatefulWidget
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? selectedAvatar;  // ประกาศตัวแปร selectedAvatar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      // backgroundColor: Color(0xFFF8F8F9),
      backgroundColor: Color(0xFFF6874E),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Who is You?",
                      style: GoogleFonts.chakraPetch(
                        fontSize: 37,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  SvgPicture.asset(
                    'assets/avatar/team_profile.svg',
                    width: 300,
                    height: 300,
                  ),
                  SizedBox(height: 35),
                  Wrap(
                    spacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      AvatarItem(
                        imagePath: 'assets/avatar/avatar1.png',
                        name: "Ironman",
                        isSelected: selectedAvatar == "Ironman",
                        onTap: () => setState(() => selectedAvatar = "Ironman"),
                      ),
                      AvatarItem(
                        imagePath: 'assets/avatar/avatar3.png',
                        name: "Batman",
                        isSelected: selectedAvatar == "Batman",
                        onTap: () => setState(() => selectedAvatar = "Batman"),
                      ),
                      AvatarItem(
                        imagePath: 'assets/avatar/avatar2.png',
                        name: "Spiderman",
                        isSelected: selectedAvatar == "Spiderman",
                        onTap: () => setState(() => selectedAvatar = "Spiderman"),
                      ),
                    ],
                  ),
                  SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: selectedAvatar != null ? () {
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                    } : null,  // ปิดปุ่มถ้ายังไม่เลือก avatar
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedAvatar != null ? Colors.black : Colors.grey,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      minimumSize: Size(330, 60),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}