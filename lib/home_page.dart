import 'dart:math';
import 'package:flutter/material.dart';
import 'package:projetcalculatrice/button.dart';
import 'package:projetcalculatrice/fonctionalite.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [

                  // champ d'affichage de l'operation en cours
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse:  true,
                    child: Text (Fonctionalite.laSaisie, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),),

                  const SizedBox(height: 40), // espace entre operation et resultat


                  // champs d'affichage du resultat
                  Text (Fonctionalite.leResultat, style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold,),),

                  const SizedBox(height: 40), // espace entre resultat et clavier




                  Wrap(

                    children:
                    Buttons.allButtons.map(
                          (e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                          style : OutlinedButton.styleFrom(
                            fixedSize: e == "0"
                                ?Size(screenWidth * .43, 80) // taille du bouton 0
                                :Size(screenWidth * .20, 80), // taille des autres boutons
                            backgroundColor:
                            Buttons.operaButtons.contains(e)
                                ? Colors.orange
                                :Colors.grey,  // assignation des couleurs des boutons ( orange et gris)
                          ),
                          onPressed: (){
                            Fonctionalite.ajouterSaisie(e, setState); // recuperation de du caracgere lorsqu'il ya un clic sur un bouton.
                          },

                          // mise en forme des caracteres sur les boutons
                          child: Text(e, style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,fontWeight: FontWeight.bold,),
                          ),
                        ),
                      ),
                    ).toList(),
                  )
                ]
            )
        )
    );
  }
}
