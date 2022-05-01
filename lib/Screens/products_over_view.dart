// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fleur_d_or/data/url_silde_images.dart';
import 'package:flutter/material.dart';

import '../data/categories.dart';
import '../widgets/category_widget.dart';
import '../widgets/products_grid.dart';

enum FiltersOptions {
  Favorites,
  All,
}

class ProductsOverView extends StatefulWidget {
  @override
  State<ProductsOverView> createState() => _ProductsOverViewState();
}

class _ProductsOverViewState extends State<ProductsOverView> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            //showSearch(
            //context: context,
            //delegate: CustomSearchDelegate(),
            // );
          },
          icon: const Icon(
            Icons.menu,
          ),
        ),
        title: const Text(
          'Fleur Dor',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (FiltersOptions selectedValue) {
                setState(() {
                  if (selectedValue == FiltersOptions.Favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              itemBuilder: (_) => [
                    const PopupMenuItem(
                      child: Text(
                        'Only Favorites',
                        style: TextStyle(fontSize: 15),
                      ),
                      value: FiltersOptions.Favorites,
                    ),
                    const PopupMenuItem(
                      child: Text(
                        'Show All',
                        style: TextStyle(fontSize: 15),
                      ),
                      value: FiltersOptions.All,
                    ),
                  ]),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: <Widget>[
            Column(children: <Widget>[
              Visibility(
                visible: _showOnlyFavorites ? false : true,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: CATEGORIES
                          .map((catData) => CategoryWidget(
                                image: catData.image,
                                name: catData.name,
                                id: catData.id,
                              ))
                          .toList()),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: _showOnlyFavorites ? false : true,
                child: Container(
                  height: 200,
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: CarouselSlider.builder(
                      itemCount: SlidesImagesUrl.urlImages.length,
                      itemBuilder: (BuildContext context, index, realIndex) {
                        final urlImage = SlidesImagesUrl.urlImages[index];
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              urlImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 400,
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        initialPage: 0,
                        enlargeCenterPage: true,
                      )),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.only(top: 3),
                  color:
                      const Color.fromARGB(255, 243, 242, 242).withOpacity(0.5),
                  height: 30,
                  width: 200,
                  child: const Text(
                    'Boutique',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 243, 242, 242).withOpacity(0.5),
                    const Color.fromARGB(255, 243, 242, 242).withOpacity(0.5),
                  ],
                )),
                //color: Color.fromARGB(255, 243, 242, 242),
                child: ProductsGrid(_showOnlyFavorites),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
