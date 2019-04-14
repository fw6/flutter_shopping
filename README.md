# flutter_shopping

A new Flutter project.

## Getting Started

flutter_screenutil
flutter_swiper
flutter_easyrefresh
url_launch
flutter_provide

path_provider 加载本地图片相对路径

```dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';

// Image.file(File('/sdcard/Download/Static/bg.png'))
FutureBuilder(
  future: _getLocalFile('/Download/Static/bg.png'),
  builder: (BuildContext context, AsyncSnapshot<file> snapshot) {
    return snapshot.data != null ? Image.file(snapshot.data) : Container(
      child: Text('Failed to load image')
    );
  }
)

// 获取SDCard 的路径
Future<File> _getLocalFile(String filename) async {
  String dir = (await getExternalStorageDirectory()).path;
  File f = new File('$dir/$filename');
  return f
}
```

**内存中加载 placeholder**

```dart
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

void main() {
  runApp(myApp())
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Fade in image';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Stack(
          children: <Widget>[
            Center(
              child: CircularProgressIndicator()
            ),
            Center(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: './imagenetwrok.png'
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

cached_network_image 图片缓存
从网络上加载图片并下载到本地，以供下次使用

动画

```dart
// 创建一个控制器、一条曲线、一个Tween
final AnimationController controller = new AnimationController(
  duration: const Duration(milliseconds: 500),
  vsync: this,
);
final Animation curve = new CurvedAnimation(
  parent: controller,
  curve: Curves,easeIn,
);
Animation<int> alpha = new IntTween(begin:0, end: 255).animate(curve);
```

实现径向 Hero 动画

```dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scehduler.dart' show timeDilation;

class Photo extends StatelessWidget {
  Photo({Key key, this.photo, this.color, this.onTap}) : super(key:key);

  final String photo;
  final Color color;
  final VoidCallback onTap;

  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor.withOpacity(0.25),
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints size) {
            return Image.network(
              photo,
              fit: BoxFit.contain,
            );
          }
        ),
      ),
    );
  }
}

class RadicalExpansion extends StatelessWidget {
  RadicalExpansion({Key key, this.maxRadius, this.child}):super(key: key);

  final double maxRadius;
  final clipRectSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizeBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(
            child: child,
          ),
        ),
      ),
    );
  }
}

class RadicalExpansionDemo extends StatelessWidget {
  static const double kMinRadius = 32.0;
  static const double kMaxRadius = 128.0;
  static const opacityCurve = const Interval(
    0.0,
    0.75,
    curve: Curves.fastOutSlowIn,
  );

  static RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  static Widget _buildPage(BuildContext context, String imageName, String description) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Column(
        children: <Widget>[]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

### Flutter 调试

1. 断点
2. 变量视窗和观察视窗
3. 通过 Frames 回退
4. 控制台

## ARIA Attribute
