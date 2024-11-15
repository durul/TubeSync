import 'package:flutter/material.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:provider/provider.dart';
import 'package:tube_sync/app/playlist/media_menu_sheet.dart';
import 'package:tube_sync/extensions.dart';
import 'package:tube_sync/model/media.dart';
import 'package:tube_sync/provider/playlist_provider.dart';
import 'package:tube_sync/services/media_service.dart';

class MediaEntryBuilder extends StatelessWidget {
  final Media media;
  final void Function()? onTap;

  const MediaEntryBuilder(this.media, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.only(left: 16, right: 8),
      leading: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              width: 80,
              height: double.maxFinite,
              image: NetworkToFileImage(
                url: media.thumbnail.medium,
                file: MediaService().thumbnailFile(media.thumbnail.medium),
              ),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 4,
            right: 4,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                media.duration.formatHHMM(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
      title: Text(
        media.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      titleTextStyle: Theme.of(context).textTheme.titleSmall,
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            TextSpan(
              children: [
                if (media.downloaded == true)
                  const WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.only(right: 2),
                      child: Icon(
                        Icons.download_for_offline_rounded,
                        size: 16,
                      ),
                    ),
                  ),
                TextSpan(text: media.author),
              ],
            ),
          ),
        ],
      ),
      trailing: IconButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          useSafeArea: true,
          useRootNavigator: true,
          backgroundColor: Colors.transparent,
          builder: (_) => ChangeNotifierProvider.value(
            value: context.read<PlaylistProvider>(),
            child: MediaMenuSheet(media),
          ),
        ),
        icon: const Icon(Icons.more_vert_rounded, size: 18),
      ),
    );
  }
}
