import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NIN Lookup',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const NINLookupPage(),
    );
  }
}

class NINLookupPage extends StatefulWidget {
  const NINLookupPage({super.key});

  @override
  State<NINLookupPage> createState() => _NINLookupPageState();
}

class _NINLookupPageState extends State<NINLookupPage> {
  final TextEditingController ninController = TextEditingController();
  bool _searched = false;
  Map<String, String>? userDetails;

  // Mock data simulating user records keyed by NIN
  final Map<String, Map<String, String>> mockData = {
    '123456789': {
      'Full Name': 'John Doe',
      'Date of Birth': '1990-01-01',
      'Address': '123 Main St, Springfield',
      'Gender': 'Male',
      'Phone': '+1 (555) 123-4567',
    },
    '987654321': {
      'Full Name': 'Jane Smith',
      'Date of Birth': '1985-05-15',
      'Address': '456 Elm St, Metropolis',
      'Gender': 'Female',
      'Phone': '+1 (555) 987-6543',
    },
  };

  void _lookupNIN() {
    final nin = ninController.text.trim();
    setState(() {
      userDetails = mockData[nin];
      _searched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NIN Lookup'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: ninController,
              decoration: const InputDecoration(
                labelText: 'Enter NIN',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _lookupNIN,
              child: const Text('Lookup'),
            ),
            const SizedBox(height: 24),
            if (_searched && userDetails == null) ...[
              const Text(
                'No record found for the provided NIN.',
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ] else if (userDetails != null) ...[
              Expanded(
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: userDetails!.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  '${entry.key}:',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(entry.value),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
