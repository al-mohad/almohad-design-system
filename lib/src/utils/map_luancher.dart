import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';

class MapsSheet {
  static Future<void> show({
    required BuildContext context,
    required void Function(AvailableMap map) onMapTap,
  }) async {
    final availableMaps = await MapLauncher.installedMaps;

    if (!context.mounted) return;

    showModalBottomSheet(
      context: context,
      builder:
          (BuildContext modalContext) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var map in availableMaps)
                  ListTile(
                    onTap: () {
                      Navigator.pop(modalContext);
                      onMapTap(map);
                    },
                    title: Text(map.mapName),
                    leading: SvgPicture.asset(
                      map.icon,
                      height: 30.0,
                      width: 30.0,
                    ),
                  ),
              ],
            ),
          ),
    );
  }
}
