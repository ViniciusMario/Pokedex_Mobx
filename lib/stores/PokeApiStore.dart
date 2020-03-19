import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:mobx/mobx.dart';
import 'package:pokedex_mobx/consts/consts_api.dart';
import 'package:pokedex_mobx/models/pokeApi.model.dart';
import 'package:cached_network_image/cached_network_image.dart';

part 'PokeApiStore.g.dart';

class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {
  
  @observable
  PokeApi _pokeApi;

  

  @computed
  PokeApi get pokeApi => _pokeApi;

  @action 
  getPokemon({int index}){
    return _pokeApi.pokemon[index];
  }

  @action
  fetchPokemonList(){
    _pokeApi = null;
    loadPokeApi().then((pokeList){
      _pokeApi = pokeList;
    });
  }

  Future<PokeApi> loadPokeApi()async{
    
    try{
    final response =  await http.get(ConstsApi.pokeApiUrl);
    var decodeJson = jsonDecode(response.body);

    return PokeApi.fromJson(decodeJson);
    }catch(error){
      print("Erro ao carregar lista");
      return null;  
    }

  }

  @action 
    Widget getImage({String numero}) {
      return CachedNetworkImage(
        placeholder: (context, url) => new Container(
          color: Colors.transparent,
        ),
        imageUrl:
            'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$numero.png',
      );
    }

}