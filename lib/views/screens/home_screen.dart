import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_onsume_best_bractice/views/screens/products_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

import '../../controller/article_controller.dart';
import '../../controller/product_controller.dart';
import 'all_the_products.dart';

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
final productController = Get.put(ProductController());
    return Scaffold(
      appBar: AppBar(
        title:Text('Home Page'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/search');
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      drawer: Drawer(
        child:  ListView(
          children: [
               DrawerHeader(
              child: const Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: const Text('Product'),
              onTap: () {
                Get.to(ProductScreen()) ;
              },
            ),
            ListTile(
              title: const Text('All teh products'),
              onTap: () {
                Get.to(()=>AllProducts()) ;
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: articleController.getArticles(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: articleController.articles.length,
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
                      curve: Curves.easeInCircle,
                    );*/
                  },
                  onTap: () {

                    Get.defaultDialog(
                      title: articleController.articles[index].title!,
                      content: Column(
                        children: [
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
                          "Source ${articleController.articles[index].source.name!}",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
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
                        articleController.articles[index].content!=null?Text(
                            "Content ${articleController.articles[index].content!}"): Container(),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
                child: SizedBox(
              width: 200.0,
              height: 100.0,
              child: Shimmer.fromColors(
                baseColor: Colors.red,
                highlightColor: Colors.yellow,
                enabled: true,
                child: const Text(
                  'Loading ...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
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
