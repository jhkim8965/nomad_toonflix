import 'package:flutter/material.dart';
import 'package:nomad_toonflix/services/api_service.dart';
import 'package:nomad_toonflix/widgets/webtoon_widget.dart';

import '../models/webtoon_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Today's WebToons",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // return ListView.builder(
            //   scrollDirection: Axis.horizontal,
            //   itemCount: snapshot.data!.length,
            //   itemBuilder: (context, index) {
            //     var webtoon = snapshot.data![index];
            //     return Text(webtoon.title);
            //   },
            // );
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: makeList(snapshot),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return WebtoonWidget(webtoon: webtoon);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 40,
        );
      },
    );
  }
}
