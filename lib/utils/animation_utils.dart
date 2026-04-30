import 'package:app/config/colors_config.dart';
import 'package:flutter/widgets.dart';

class AnimationUtils {

  Widget buildDotsAnimation(AnimationController _controller,
      BuildContext context){
    return Row(
      children: List.generate(3, (i) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            final delay = i * 0.2;
            final t = (_controller.value - delay).clamp(0.0, 1.0);
            final opacity = (t < 0.4) ? t / 0.4 : (t < 0.8) ? 1.0 : 1.0 - (t - 0.8) / 0.2;
            return Container(
              width: 4,
              height: 4,
              margin: const EdgeInsets.only(left: 3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsConfig.brandPurple.withOpacity(opacity.clamp(0.2, 1.0)),
              ),
            );
          },
        );
      }),
    );
  }
}