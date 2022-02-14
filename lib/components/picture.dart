import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../components/image.dart';
import '../generated/l10n.dart';
import '../util/http.dart';
import '../util/loading.dart';
import '../util/style.dart';
import '../util/toast.dart';

class PicturePage extends StatefulWidget {
  final String title;
  final String upload;
  final String? uri;
  final String? local;
  final double? ratio;
  final double scale;
  final void Function(String uri)? ok;

  const PicturePage(this.title, this.upload, {Key? key, this.uri, this.local, this.ratio, this.scale = 8, this.ok}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  final ImagePicker picker = ImagePicker();
  final GlobalKey<ExtendedImageEditorState> editor = GlobalKey<ExtendedImageEditorState>();
  final Divider divider = const Divider(height: 1);
  String? local;

  @override
  void initState() {
    super.initState();
    local = widget.local;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
          title: Text(widget.title),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: pick,
              icon: const Icon(Icons.add_photo_alternate_outlined),
            ),
            IconButton(
              onPressed: () async {
                Loading.show();
                List<int>? data = await cropImage(editor.currentState!);
                if (data == null) {
                  Loading.hide();
                  Toast.error(0, S.of(context).pictureCropFail);

                  return;
                }

                Map<String, dynamic>? map = await Http.upload('clivia.user.avatar', bytes: data, filename: 'avatar.jpg', contentType: 'image/jpeg');
                if (map == null || !map.containsKey('path')) {
                  Loading.hide();
                  Toast.error(0, S.of(context).pictureUploadFail);

                  return;
                }

                if (widget.ok != null) widget.ok!(map['path']);
                Loading.hide();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.done),
            ),
          ],
        ),
        body: body(),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            toolItem(Icons.crop, S.of(context).pictureCrop),
            toolItem(Icons.flip, S.of(context).pictureFlip),
            toolItem(Icons.rotate_left, S.of(context).pictureRotateLeft),
            toolItem(Icons.rotate_right, S.of(context).pictureRotateRight),
            toolItem(Icons.restore, S.of(context).pictureReset),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          onTap: (int index) {
            switch (index) {
              case 1:
                editor.currentState?.flip();
                break;
              case 2:
                editor.currentState?.rotate(right: false);
                break;
              case 3:
                editor.currentState?.rotate();
                break;
              case 4:
                editor.currentState?.reset();
                break;
            }
          },
        ),
      );

  Widget body() {
    if (local != null) {
      return ExtendedImage.file(
        File(local!),
        fit: BoxFit.contain,
        mode: ExtendedImageMode.editor,
        extendedImageEditorKey: editor,
        cacheRawData: true,
        initEditorConfigHandler: (state) => config(),
      );
    }

    if (widget.uri != null && widget.uri != '') {
      return ExtendedImage.network(
        Http.url(widget.uri!),
        cache: true,
        fit: BoxFit.contain,
        mode: ExtendedImageMode.editor,
        extendedImageEditorKey: editor,
        cacheRawData: true,
        initEditorConfigHandler: (state) => config(),
      );
    }

    return Center(
      child: GestureDetector(
        child: Icon(
          Icons.add_photo_alternate_outlined,
          size: 64,
          color: Style.tileIcon(context),
        ),
        onTap: pick,
      ),
    );
  }

  EditorConfig config() => EditorConfig(
        maxScale: widget.scale,
        cropRectPadding: const EdgeInsets.all(16),
        cropAspectRatio: widget.ratio,
      );

  void pick() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          pickerItem(
            Icons.photo_camera,
            S.of(context).pictureCamera,
            ImageSource.camera,
          ),
          divider,
          pickerItem(
            Icons.photo_album,
            S.of(context).pictureAlbum,
            ImageSource.gallery,
          )
        ],
      ),
    );
  }

  Widget pickerItem(IconData icon, String title, ImageSource source) => ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: () async {
          XFile? file = await picker.pickImage(source: source);
          if (file == null) return;

          setState(() {
            local = file.path;
            if (editor.currentState != null) editor.currentState!.reset();
          });
          Navigator.pop(context);
        },
      );

  BottomNavigationBarItem toolItem(IconData icon, String label) => BottomNavigationBarItem(
        icon: Icon(icon),
        label: label,
      );
}
