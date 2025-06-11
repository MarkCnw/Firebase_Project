import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planmate/theme/app_theme.dart'


import 'package:planmate/widgets/botttom_widget.dart';class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundOnboarding,

      body: SafeArea(
        child: Column(
          children: [
            // ส่วนบน - Character และ floating elements
            Expanded(
              flex: 3, // ให้พื้นที่มากกว่า
              child: Stack(
                children: [
                  // Character อยู่กลางส่วนบน
                  Center(child: SvgPicture.asset('assets/onboarding.svg')),
                ],
              ),
            ),

            // ส่วนล่าง - Card ขาว
            Expanded(
              flex: 2, // พื้นที่น้อยกว่า
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Easiest Way to\nManage Your Plan',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.chakraPetch(
                          fontSize: 37,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Organized all your task in list and\nproject to help you build new habits',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w400, // Regular
                          color: Colors.grey[600],
                        ),
                      ),
                      Spacer(),
                      
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
