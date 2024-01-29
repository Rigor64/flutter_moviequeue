//animazione per la pagine di ricerca
import 'package:flutter/cupertino.dart';
import 'package:moviequeue/models/media.dart';
import 'package:moviequeue/pages/accountPage.dart';
import 'package:moviequeue/pages/detailScreen.dart';

PageRouteBuilder animationDetailPage(Media media, titolo, release) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => DetailScreen(
      media: media,
      titolo: titolo,
      release: release,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 0.8); // Inizio animazione dal basso
      const end = Offset.zero;
      const curve = Curves.fastEaseInToSlowEaseOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

PageRouteBuilder animationAccountPage() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const AccountPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 0.8); // Inizio animazione dal basso
      const end = Offset.zero;
      const curve = Curves.fastEaseInToSlowEaseOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
