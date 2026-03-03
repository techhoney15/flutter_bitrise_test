import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _assetInfo = 'Tap the button to load bulk assets info...';
  bool _loading = false;

  static const List<String> _assetPaths = [
    'assets/bulk_data/data_chunk_1.bin',
    'assets/bulk_data/data_chunk_2.bin',
    'assets/bulk_data/data_chunk_3.bin',
    'assets/bulk_data/data_chunk_4.bin',
    'assets/bulk_data/data_chunk_5.bin',
    'assets/bulk_data/data_chunk_6.bin',
  ];

  Future<void> _loadAssetInfo() async {
    setState(() => _loading = true);
    int totalBytes = 0;
    for (final path in _assetPaths) {
      final data = await rootBundle.load(path);
      totalBytes += data.lengthInBytes;
    }
    final totalMB = (totalBytes / (1024 * 1024)).toStringAsFixed(1);
    setState(() {
      _assetInfo = 'Loaded ${_assetPaths.length} assets — $totalMB MB total';
      _loading = false;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            if (_loading)
              const CircularProgressIndicator()
            else
              Text(
                _assetInfo,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loading ? null : _loadAssetInfo,
              child: const Text('Load Bulk Assets Info'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
