import 'package:flutter/material.dart';
import 'package:simple_animations/multi_tween/multi_tween.dart';
import 'package:simple_animations/simple_animations.dart' as anim;
import 'package:simple_animations/stateless_animation/play_animation.dart';

// Create your Animation Example
enum AniProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AniProps>()
      ..add(AniProps.opacity, Tween(begin: 0.0, end: 1.0))
      ..add(AniProps.translateY, Tween(begin: -130.0, end: 0.0), Duration(milliseconds: 500), Curves.easeOut);

    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, animation) => Opacity(
        opacity: animation.get(AniProps.opacity),
        child: Transform.translate(
            offset: Offset(0, animation.get(AniProps.translateY)),
            child: child
        ),
      ),
    );
  }
}

/*class FadeAnimation extends StatelessWidget{
  final double delay;
  final double child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(Duration(milliseconds: 500), Tween(begin: -130.0, end: 0.0),
      curve: Curves.easeOut)
    ]);   //Multitracktween

    return ControlledAnimation(
      delay:Duration(milliseconds: (500 * delay).round()),
      duration:tween.duration,
      tween:tween,
      child:child,
      builderWidthChild:(context,child,animation) => Opacity(
      opacity: animation["opacity"],
      child: Transform.translate(
          offset: Offset(0,animation["translateY"]),
        child: child,
      ),
      ),
    );
  }
}*/