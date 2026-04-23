import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "MotiNotes",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Inspire. Reflect. Grow.",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.settings, color: Colors.purple),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quote Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("QUOTE OF THE DAY",
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey)),
                  SizedBox(height: 10),
                  Text(
                    "“God put that dream in your heart for a reason.”",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text("- Unknown",
                        style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Explore
            const Text(
              "EXPLORE",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.format_quote, color: Colors.white),
                        SizedBox(height: 10),
                        Text("QUOTES",
                            style: TextStyle(color: Colors.white)),
                        Text("Browse quotes",
                            style: TextStyle(
                                color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.note, color: Colors.white),
                        SizedBox(height: 10),
                        Text("NOTES",
                            style: TextStyle(color: Colors.white)),
                        Text("Write reflections",
                            style: TextStyle(
                                color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Bottom motivation card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(Icons.bolt, color: Colors.purple),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Keep going!",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Every day is a new chance to grow.",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
