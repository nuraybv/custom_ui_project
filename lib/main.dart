import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const CustomUIApp();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const DetailsScreen();
          },
        ),
      ],
    ),
  ],
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class CustomUIApp extends StatelessWidget {
  const CustomUIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Layout & Navigation'),
        backgroundColor: Colors.blueAccent,
      ),
      // LayoutBuilder ekran ölçüsünü dinamik olaraq yoxlayır
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Əgər ekranın eni 600 pikseldən böyükdürsə (Geniş ekran dizaynı)
          if (constraints.maxWidth > 600) {
            return Row(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: _buildMainContent(context),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.blue[50],
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.desktop_mac, size: 80, color: Colors.blueAccent),
                          SizedBox(height: 10),
                          Text(
                            'Tablet/Desktop View Active',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Əgər ekranın eni kiçikdirsə (Mobil telefon dizaynı)
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: _buildMainContent(context),
            );
          }
        },
      ),
    );
  }

  // Əsas vizual elementlərin siyahısı
  List<Widget> _buildMainContent(BuildContext context) {
    return [
      const Text('1. Stack Element (Custom Card):', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      Stack(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.image, size: 80, color: Colors.blue),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text('PRO', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      const SizedBox(height: 25),
      const Text('2. Column & Row (Information Block):', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User Profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.blueAccent),
                    SizedBox(width: 8),
                    Text('John Doe'),
                  ],
                ),
                Text('Premium Member', style: TextStyle(color: Colors.green)),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 25),
      const Text('3. Navigation:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      ElevatedButton.icon(
        onPressed: () => context.go('/details'),
        icon: const Icon(Icons.arrow_forward),
        label: const Text('Go to Details Screen'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
      const SizedBox(height: 25),
      const Text('4. Custom Widgets:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomActionButton(title: 'Like', icon: Icons.thumb_up, color: Colors.blue),
          CustomActionButton(title: 'Share', icon: Icons.share, color: Colors.green),
          CustomActionButton(title: 'Comment', icon: Icons.comment, color: Colors.orange),
        ],
      ),
    ];
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            const Text('Welcome to the Second Screen!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => context.go('/'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),
              child: const Text('Go Back', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const CustomActionButton({super.key, required this.title, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(backgroundColor: color.withOpacity(0.2), child: Icon(icon, color: color)),
        const SizedBox(height: 5),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}