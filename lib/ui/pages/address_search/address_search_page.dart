import 'package:flutter/material.dart';
import 'package:flutter_market_app/core/geolocator_helper.dart';
import 'package:flutter_market_app/ui/pages/address_search/address_view_model.dart';
import 'package:flutter_market_app/ui/pages/join/join_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          // 이 텍스트 필드는 재활용할 필요 없음
          title: Consumer(
            builder: (context, ref, child) {
              return TextField(
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    ref.read(addressSearchViewModel.notifier).search(value);
                  }
                },
                decoration: InputDecoration(
                  hintText: '동명(읍,면)으로 검색 (ex. 서초동)',
                  // 이 텍스트 필드 contentPadding으로 사이즈 조정
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                ),
              );
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 10),
              // ElevatedButton 사이즈 줄이기(얘만)
              Consumer(
                builder: (context, ref, child) {
                  return SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        final position = await GeolocatorHelper.getPositon();
                        if (position != null) {
                          await ref
                              .read(addressSearchViewModel.notifier)
                              .searchByAddress(
                                position.latitude,
                                position.longitude,
                              );
                        }
                      },
                      child: Text('현재 위치로 찾기'),
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(addressSearchViewModel);
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      itemCount: state.length,
                      itemBuilder: (context, index) {
                        final address = state[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return JoinPage(address: address);
                              },
                            ));
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            // 터치영역 설정을 위해 색상 지정
                            color: Colors.transparent,
                            child: Text(
                              address,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
