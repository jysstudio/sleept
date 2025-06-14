import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../habit/service/habit_database.dart';
import '../habit_tracking_screen.dart';

class HabitCard extends StatelessWidget {
  final HabitModel data;

  const HabitCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HabitTrackinglScreen(
              // Pass habit ID
              habitId: data.id?.toString() ?? '',
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 16,right: 16,bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: const Color(0xFF242030) /* Primitive-Color-gray-900 */,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 11,
          children: [
            Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 9,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 2,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(),
                        child:   SvgPicture.asset('assets/svg/icon_clover.svg',), // 아이콘 예시
                      ),
                      Text(
                        data.selectedHabit,
                        style: TextStyle(
                          color: Colors.white /* Primitive-Color-White */,
                          fontSize: 16,
                          fontFamily: 'Min Sans',
                          fontWeight: FontWeight.w700,
                          height: 1.50,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      spacing: 199,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 3,
                          children: [
                            Text(
                              '${data.count}',
                              style: TextStyle(
                                color: Colors.white /* Primitive-Color-White */,
                                fontSize: 14,
                                fontFamily: 'Min Sans',
                                fontWeight: FontWeight.w400,
                                height: 1.50,
                              ),
                            ),
                            Text(
                              '/',
                              style: TextStyle(
                                color: const Color(0xFFAAA8B4) /* Primitive-Color-gray-400 */,
                                fontSize: 14,
                                fontFamily: 'Min Sans',
                                fontWeight: FontWeight.w400,
                                height: 1.50,
                              ),
                            ),
                            Text(
                              '${data.duration}번',
                              style: TextStyle(
                                color: const Color(0xFFAAA8B4) /* Primitive-Color-gray-400 */,
                                fontSize: 14,
                                fontFamily: 'Min Sans',
                                fontWeight: FontWeight.w400,
                                height: 1.50,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          countPercent(data.count,data.duration),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white /* Primitive-Color-White */,
                            fontSize: 22,
                            fontFamily: 'Min Sans',
                            fontWeight: FontWeight.w700,
                            height: 1.50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 5,
                children: [
                  for(int i=0; i<5;i++ )
                  Expanded(
                    child: Container(
                      height: 4,
                      decoration: ShapeDecoration(
                        color: isCountPercentPicesColor(data.count,data.duration,i)?
                        Color(0xFFECFF87):Color(0xFF403C4F) /* Primitive-Color-Sub-Color-Lime */,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
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

  bool isCountPercentPicesColor(count,duration,index){
    var percent = ((count/duration)*100);
    var pice =0;
    if(percent<=20){
     pice = 1;
    }else if(percent<=40){
      pice = 2;
    }else if(percent<=60){
      pice = 3;
    }else if(percent<=80){
      pice = 4;
    }else if(percent<=100){
      pice = 5;
    }

    return index<pice;
  }

  String countPercent(count,duration){
    return ((count/duration)*100).toStringAsFixed(1)+'%';
  }
}