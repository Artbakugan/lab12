import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ContainerSettings(),
      child: const MyApp(),
    ),
  );
}

class ContainerSettings extends ChangeNotifier {
  static const double minSize = 80;
  static const double maxSize = 240;
  static const double maxRadius = 80;

  double _width = 150;
  double _height = 150;
  double _radius = 30;

  double get width => _width;
  double get height => _height;
  double get radius => _radius;

  void setWidth(double value) {
    _width = value;
    notifyListeners();
  }

  void setHeight(double value) {
    _height = value;
    notifyListeners();
  }

  void setRadius(double value) {
    _radius = value;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Лабораторна №12',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Конфігуратор контейнера'),
          centerTitle: true,
        ),
        body: const SafeArea(
          child: ListViewContent(),
        ),
      ),
    );
  }
}

class ListViewContent extends StatelessWidget {
  const ListViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        SliderSection(),
        SizedBox(height: 24),
        ContainerPreview(),
      ],
    );
  }
}

class SliderSection extends StatelessWidget {
  const SliderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<ContainerSettings>();

    return Column(
      children: [
        SettingSlider(
          title: 'Ширина',
          value: settings.width,
          min: ContainerSettings.minSize,
          max: ContainerSettings.maxSize,
          onChanged: settings.setWidth,
        ),
        SettingSlider(
          title: 'Висота',
          value: settings.height,
          min: ContainerSettings.minSize,
          max: ContainerSettings.maxSize,
          onChanged: settings.setHeight,
        ),
        SettingSlider(
          title: 'Радіус верхнього правого кута',
          value: settings.radius,
          min: 0,
          max: ContainerSettings.maxRadius,
          onChanged: settings.setRadius,
        ),
      ],
    );
  }
}

class SettingSlider extends StatelessWidget {
  const SettingSlider({
    super.key,
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String title;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title: ${value.round()}'),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).round(),
          label: '${value.round()}',
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class ContainerPreview extends StatelessWidget {
  const ContainerPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<ContainerSettings>();

    return Center(
      child: Container(
        width: settings.width,
        height: settings.height,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(settings.radius),
          ),
        ),
      ),
    );
  }
}