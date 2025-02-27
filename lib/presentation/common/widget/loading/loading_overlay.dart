import 'package:flutter/material.dart';
import 'package:pokeview/presentation/common/widget/loading/loading_pokeball.dart';

class LoadingOverlay {
  static OverlayEntry? _overlay;

  static void show(BuildContext context, {Color? backgroundColor}) {
    if (_overlay != null) return;

    _overlay = OverlayEntry(builder: (BuildContext context) {
      return Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: PokeSpin(width: 50, height: 50, infinite: true))
        ],
      );
    });

    Overlay.of(context).insert(_overlay!);
  }

  static hide() {
    if (_overlay == null) return;
    _overlay!.remove();
    _overlay = null;
  }
}
