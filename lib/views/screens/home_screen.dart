import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

import '../../controller/article_controller.dart';

class HomePage extends StatefulWidget {

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final articleController = Get.put(ArticleController());

  late VideoPlayerController videoPlayerController;

  late CustomVideoPlayerController _customVideoPlayerController;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: articleController.getArticles(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: articleController.articles.length,
              itemExtent: Get.height ,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onDoubleTap: () {
                    Get.showSnackbar(GetBar(
                      message: articleController.articles[index].description!,
                      duration: const Duration(seconds: 3),
                    ));
                    /* Get.to(() => const Material(child: const Center(child: Text("data")),color: Colors.red, ),
                    transition: Transition.fadeIn,
                      duration: const Duration(seconds: 3),
                      curve: Curves.easeInCirc,
                    );*/
                  },
                  onTap: () {
                    Get.defaultDialog(
                      title: articleController.articles[index].title!,
                      content: Column(
                        children: [
                          Container(
                            height: 100,
                            child: CustomVideoPlayer(
                                customVideoPlayerController: CustomVideoPlayerController(
                                  context: context,
                                  videoPlayerController:  VideoPlayerController.network(
                                      'https://www.youtube.com/watch?v=W6vAQdzLcu4&ab_channel=RivaanRanawat'),
                                )),
                          ),

                          Image.network(

                              articleController.articles[index].imageUrl!),
                          const Text(
                            'Description',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(articleController.articles[index].description!),
                          const SizedBox(height: 10),
                          Text(articleController.articles[index].content!),
                        ],
                      ),
                      textConfirm: 'Close',
                      confirmTextColor: Colors.white,
                      onConfirm: () {
                        Get.back();
                      },
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(10),

                    child: Column(
                      children: [
                        Text(
                            "Source ${articleController.articles[index].source.name!}"),
                        Image.network(
                          articleController.articles[index].imageUrl!,
                        ),
                        Card(
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          child: ListTile(
                            title:
                                Text(articleController.articles[index].title!),
                            subtitle: Text(
                                articleController.articles[index].description!),
                          ),
                        ),
                        articleController.articles[index].author != null
                            ? Card(
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                child: ListTile(
                                  title: Text(
                                      "Author ${articleController.articles[index].author!}"),
                                  subtitle: Text(
                                      "Published At ${articleController.articles[index].publishedAt}"),
                                ),
                              )
                            : Container(),
                        Text(
                            "Content ${articleController.articles[index].content!}"),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return  Center(child: SizedBox(
              width: 200.0,
              height: 100.0,
              child: Shimmer.fromColors(
                baseColor: Colors.red,
                highlightColor: Colors.yellow,
                enabled: true,
                child: Text(
                  'Loading ...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ));
          }
        },
      ),
    );
  }
}
