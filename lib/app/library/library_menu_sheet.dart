import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:tubesync/model/playlist.dart';
import 'package:tubesync/provider/library_provider.dart';
import 'package:tubesync/provider/playlist_provider.dart';
import 'package:tubesync/services/media_service.dart';

class LibraryMenuSheet extends StatelessWidget {
  final Playlist playlist;
  final Isar isar;

  const LibraryMenuSheet(this.isar, this.playlist, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Drag Handle
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 4,
              width: kMinInteractiveDimension,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          if (MediaService().isPlayerActive)
            ListTile(
              onTap: () {
                MediaService().enqueue(
                  PlaylistProvider(isar, playlist, sync: false),
                );
                Navigator.pop(context);
              },
              leading: const Icon(Icons.playlist_add_rounded),
              title: const Text("Enqueue"),
            ),
          ListTile(
            onTap: () {
              context.read<LibraryProvider>().delete(playlist);
              Navigator.pop(context);
            },
            leading: const Icon(Icons.delete_rounded),
            title: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
