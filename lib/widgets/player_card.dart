import 'package:flutter/material.dart';
import 'package:project_supabase/utils/my_assets.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Center(
            child: Image.asset(
              MyAssets.splashImage,
              height: 100,
              width: 150,
              fit: BoxFit.cover,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
