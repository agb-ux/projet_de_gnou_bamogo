import 'package:math_expressions/math_expressions.dart';
import 'package:projetcalculatrice/button.dart';


class Fonctionalite{
  static String laSaisie = ""; // recupere ce que l'utilsateur entre a partir des boutons.
  static String leResultat = ""; // Recupere le resultat( resultats intermediaire et final)
  static bool virgulePresent = false; //verifie presence de virgule
  static bool operateurPresent = false; // verifie presence d'un operateur .


  // conction pour recuperer la saisie.
  static void ajouterSaisie( String s, Function setState){
    setState(() {

      int l = laSaisie.length;

      // si le l'operation contient deja une egalite, remplacer l'operation par le resultat avant de chercher a ajouter la nouvelle saisie
      if ( laSaisie.isNotEmpty && (laSaisie[l-1] == "=")){
        laSaisie = leResultat;
      }

      // les diffents cas que la saisie de  l'utilisateurs peux prendre.
      switch (s){
        case String digit when Buttons.digitButtons.contains(s):
          laSaisie += digit;
          leResultat = calculerResultat(laSaisie);
          operateurPresent = false;
          break;
        case "C":
          laSaisie = "";
          leResultat = "";  // les champs de l'operation et du resultat
          break;
        case "+/-":
          if (laSaisie.isNotEmpty) {
            laSaisie = laSaisie.substring(0, laSaisie.length - 1); // effacer le dernier element de l'operation
          }
          break;

        case ".":
          if (virgulePresent) {
            return;
          }
          if (!laSaisie.isNotEmpty || (operateurPresent && s != "=" )){
            laSaisie += "0.";
            virgulePresent = true;
          }
          else {
            laSaisie += ".";
            virgulePresent = true;

          }
          break;

        case String op when Buttons.operationButtons.contains(s):
          if (op == "=" && laSaisie.isNotEmpty && !LeDerniereEstOperateur(laSaisie)){

            leResultat = calculerResultat(laSaisie); // affecter le resultat de loperation a l variable leResultat
            laSaisie += "=";

          }
          else if (!operateurPresent && op != "="){
            if (op =="x") {
              laSaisie += "*"; // prendre * a la place x car x n'est pas reconnu par dart comme un operateur
            }
            else{
              laSaisie += op;


            }
            operateurPresent = true;
            virgulePresent = false;
          }
      }
    });
  }


/*


fonction pour evaluer l'operation saisie


NB: l'operateur % permet de calculer le reste de la division entiere d'une nombre par un autre.
Exemple: A%B donne le reste de la division entiere de A par B.
*/


  static String calculerResultat(String operation){
    ExpressionParser ep = GrammarParser();
    ContextModel contextModel = ContextModel();
    Expression exp = ep.parse(operation);

    double result = exp.evaluate(EvaluationType.REAL, contextModel);


    bool isInt = estEntier(result);
    if ( isInt){
      return result.toInt().toString(); // garder le resultat sous forme entiere
    }
    else{
      return result.toStringAsFixed(2); // affichage decimal avec deux chiffre apres la virgule.
    }
  }

  // verifier si un nombre est entier ou dicimal.
  static bool estEntier(double num){
    if (num % 1 == 0){
      return true;
    }
    else {
      return false;
    }
  }


  // verifier si le dernier caractere d'une chaine est un operateur
  static bool LeDerniereEstOperateur(String s ){
    int n = s.length;
    return Buttons.operationButtons.contains(s[n-1]);
  }

}