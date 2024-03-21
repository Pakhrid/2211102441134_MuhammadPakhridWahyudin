import 'dart:ffi';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Commerce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Commerce'),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: Expanded(
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: viewportConstraints.maxWidth,
                          child: const Image(
                            image:
                                NetworkImage('https://picsum.photos/id/60/400'),
                          ),
                        ),
                      ),
                      const ListSceneries(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: viewportConstraints.maxWidth,
                          child: const Image(
                            image:
                                NetworkImage('https://picsum.photos/id/90/400'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ListSceneries extends StatelessWidget {
  const ListSceneries({Key? key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SceneryImage(
              rndSeed: 1,
              nama: "Gunung",
              deskripsi: "Pemandangan indah gunung",
            ),
            SceneryImage(
              rndSeed: 2,
              nama: "Pantai",
              deskripsi: "Pemandangan eksotis pantai",
            ),
            SceneryImage(
              rndSeed: 3,
              nama: "Hutan",
              deskripsi: "Pemandangan menakjubkan hutan",
            ),
          ],
        ),
      ),
    );
  }
}

class SceneryImage extends StatelessWidget {
  final int rndSeed;
  final String nama;
  final String deskripsi;
  const SceneryImage({
    Key? key,
    this.rndSeed = 81,
    this.nama = "Scenery Name",
    this.deskripsi = "Deskripsi",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Image(
            image: NetworkImage('https://picsum.photos/200/?random=$rndSeed'),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(nama),
              Text(deskripsi),
            ],
          ),
        ],
      ),
    );
  }
}

class SceneryDetailPage extends StatelessWidget {
  final String nama;
  final String deskripsi;

  const SceneryDetailPage({
    Key? key,
    required this.nama,
    required this.deskripsi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nama),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              nama,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              deskripsi,
              style: TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _sceneries = [
    {"nama": "Gunung", "deskripsi": "Pemandangan indah gunung"},
    {"nama": "Pantai", "deskripsi": "Pemandangan eksotis pantai"},
    {"nama": "Hutan", "deskripsi": "Pemandangan menakjubkan hutan"},
  ];
  List<Map<String, dynamic>> _filteredSceneries = [];

  @override
  void initState() {
    super.initState();
    _filteredSceneries = _sceneries;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Cari pemandangan",
                suffixIcon: IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _filteredSceneries = _sceneries;
                    });
                  },
                  icon: Icon(Icons.clear),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _filteredSceneries = _sceneries
                      .where((scenery) => scenery['nama']
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredSceneries.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_filteredSceneries[index]['nama']),
                  subtitle:
                      Text(_filteredSceneries[index]['deskripsi']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SceneryDetailPage(
                          nama: _filteredSceneries[index]['nama'],
                          deskripsi: _filteredSceneries[index]['deskripsi'],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
s