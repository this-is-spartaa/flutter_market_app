import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/user_global_view_model.dart';
import 'package:flutter_market_app/ui/widgets/user_profile_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyProfileBox extends StatelessWidget {
  const MyProfileBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final user = ref.watch(userGlobalViewModel);
        // 회원정보 불러오는 중일때!
        if (user == null) {
          return SizedBox();
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UserProfileImage(dimension: 50, imgSrc: user.profileImage.url),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                '${user.nickname}님',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Text(
                  '프로필수정',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
