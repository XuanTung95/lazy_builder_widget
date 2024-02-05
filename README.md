A builder widget that can prevent rebuilding.

Caution: Preventing rebuilds is a potentially risky action, so use it judiciously.

## Usage

```dart

Widget build(BuildContext context) {
  return LazyBuilderWidget<MediaQueryData>(
    builder: (BuildContext context, MediaQueryData data) {
      return Text('Screen width = ${data.size.width}');
    },
    selector: (BuildContext context) {
      // Return the data used to build
      return MediaQuery.of(context);
    },
    buildWhen: (MediaQueryData prev, MediaQueryData curr) {
      // Do not rebuild when this route is not the top-most route on the navigator
      return ModalRoute.of(context)?.isCurrent ?? true;
    },
  );
}

```
