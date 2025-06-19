import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
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
                      "Let's Sign You in",
                      style: GoogleFonts.chakraPetch(
                        fontSize: 37,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/avatar/avatar1.svg',height: 100,width: 100,),
                      SvgPicture.asset('assets/avatar/avatar2.svg',height: 100,width: 100,),
                      SvgPicture.asset('assets/avatar/avatar3.svg',height: 100,width: 100,)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
