//+ Navigation Model | Scaffold
import 'package:flutter/material.dart';

class NavigationModel with ChangeNotifier {
  //+ Controlador del bottomNavigationBar
  final PageController _pageController = new PageController();
  //+ Indice de la página actual
  int _actualPage = 0;
  //+ Información adicional
  Map<String, dynamic> paramsPage = {};

  NavigationModel() {
    //+ Agregamos un listener para el cambio de página
    this._pageController.addListener(() {
      //+ Obtenemos el indice de la página actual
      int newPage = _pageController.page?.round() ?? 0;
      //+ Verificamos si se cambio de página
      if (this._actualPage != newPage) {
        //+ Setteamos _actualPage
        this._actualPage = newPage;
        //+ Notificamos a los oyentes
        this.notifyListeners();
      }
    });
  }

  //+ Getter _actualPage
  int get actualPage => this._actualPage;

  //+ Setter _actualPage
  set actualPage(int actualPage) {
    //+ Setteamos _actualPage
    this._actualPage = actualPage;
    //+ Cambiamos de página
    this._pageController.animateToPage(this._actualPage,
        duration: const Duration(milliseconds: 250), curve: Curves.linear);
    //+ Notificamos a los oyentes
    this.notifyListeners();
  }

  //+ Getter _pageController
  PageController get pageController => this._pageController;
}
