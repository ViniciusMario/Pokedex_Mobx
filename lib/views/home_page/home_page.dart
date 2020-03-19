import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pokedex_mobx/consts/consts_app.dart';
import 'package:pokedex_mobx/models/pokeApi.model.dart';
import 'package:pokedex_mobx/stores/PokeApiStore.dart';
import 'package:pokedex_mobx/views/home_page/poke_item.dart';
import 'package:pokedex_mobx/views/home_page/widgets/appBarHome.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PokeApiStore pokeApiStore;
  @override
  void initState() {
    super.initState();
    pokeApiStore = PokeApiStore();
    pokeApiStore.fetchPokemonList();
  }


  @override
  Widget build(BuildContext context) {
   

    double screenWidget = MediaQuery.of(context).size.width;
    double statusWidth = MediaQuery.of(context).padding.top;


    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: <Widget>[ 
          Positioned(
            top: -(240/4.0),
            left: screenWidget - (240/1.6),
            child: Opacity(
              child: Image.asset(ConstsApp.blackPokeball, height: 240, width: 240,), 
              opacity: 0.1,
            )
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: statusWidth,
                ),

                AppBarHome(),

              Expanded(
                  child: Container(
                    child: Observer(
                      name: 'ListaHomePage',
                      builder: (BuildContext context) {
                        return (pokeApiStore.pokeApi != null)
                            ? AnimationLimiter(
                                child: GridView.builder(
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.all(12),
                                  addAutomaticKeepAlives: true,
                                  gridDelegate:
                                      new SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemCount: pokeApiStore.pokeApi.pokemon.length,
                                  itemBuilder: (context, index) {
                                    Pokemon pokemon = pokeApiStore.getPokemon(index: index);
                                    return AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      columnCount: 2,
                                      child: ScaleAnimation(
                                        child: GestureDetector(
                                          child: PokeItem(
                                            index: index,
                                            name: pokemon.name,
                                            image: pokeApiStore.getImage(numero: pokemon.num),
                                            types: pokemon.type,                                       
                                          
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute( builder: (BuildContext context) =>
                                                    Container() 
                                                    /*PokeDetailPage(index: index)*/,
                                                  fullscreenDialog: true,
                                                ));
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}