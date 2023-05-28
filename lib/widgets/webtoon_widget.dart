import 'package:flutter/material.dart';
import 'package:nomad_toonflix/models/webtoon_model.dart';
import 'package:nomad_toonflix/screens/detail_screen.dart';

class WebtoonWidget extends StatelessWidget {
  final WebtoonModel webtoon;

  const WebtoonWidget({
    super.key,
    required this.webtoon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          /* nico 버전 */
          // MaterialPageRoute(
          //   builder: (context) => DetailScreen(webtoon: webtoon),
          // ),
          /* 6.9 강의 댓글의 @jungbin 참조 버전 (IOS냐 안드로이드이냐 등에 따라 같은 코딩이라도 다르게 동작함) */
          PageRouteBuilder(
            fullscreenDialog: true,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(1.0, 0.0);
              var end = Offset.zero;
              var curve = Curves.ease;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) =>
                DetailScreen(
              webtoon: webtoon,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: webtoon.id,
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(10, 10),
                    color: Colors.black.withOpacity(0.5),
                  )
                ],
              ),
              child: Image.network(
                webtoon.thumb,
                /* 네이버에서 아무곳에서나 이미지 참조를 하지못하도록 차단한 것을 우회하려면, 아래와 같이 헤더를 추가해야한다. */
                headers: const {
                  "User-Agent":
                      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            webtoon.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
