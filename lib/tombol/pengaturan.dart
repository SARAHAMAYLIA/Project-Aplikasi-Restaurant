import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_makanan/halaman_riwayat.dart';
import 'package:provider/provider.dart';
import 'package:menu_makanan/providers/theme_provider.dart';

import '../halaman_webview.dart';

class HalamanPengaturan extends StatefulWidget {
  final String email;
  const HalamanPengaturan({super.key, required this.email});

  @override
  State<HalamanPengaturan> createState() => _HalamanPengaturanState();
}

class _HalamanPengaturanState extends State<HalamanPengaturan> {
  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Keluar'),
          content: const Text('Apakah Anda yakin ingin keluar?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Center(
      child: Container(
        //constraints: const BoxConstraints(maxWidth: 400),
        child: ListView(
          children: [
            _SingleSection(
              title: "Umum",
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.dark_mode_outlined,
                    color: Colors.orange,
                  ),
                  title: const Text("Mode Gelap"),
                  trailing: Switch(
                    value: themeProvider.isDarkMode,
                    onChanged: (value) => themeProvider.toggleTheme(value),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.language_outlined,
                    color: Colors.orange,
                  ),
                  title: const Text ("Status Keamanan"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HalamanWebView(
                          title: "Status Keamanan",
                          // Ganti dengan URL asli milikmu
                          url:
                          "https://drive.google.com/drive/folders/1YUHXOt886dwnQr8IpQN9u4GtCKXp5PL_?usp=sharing",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const Divider(),
            _SingleSection(
              title: "Organisasi",
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.person_outline_rounded,
                    color: Colors.orange,
                  ),
                  title: const Text("Profil"),
                  onTap:(){
                    Navigator.pushNamed(context, '/profil');  
                  },
                ),
                /*const _CustomListTile(
                  title: "Keranjang",
                  icon: Icons.shopping_cart_checkout_outlined,
                ),*/
                ListTile(
                  leading: const Icon(
                    Icons.history_edu_outlined,
                    color: Colors.orange,
                  ),
                  title: const Text("Riwayat Transaksi"),
                  onTap: () {
                    // Navigator.of(context).pop(); // Consider if this is needed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HalamanRiwayat(email: widget.email),
                      ),
                    );
                  },
                ),
              ],
            ),
            const Divider(),
            _SingleSection(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.info_outline_rounded,
                    color: Colors.orange,
                  ),
                  title: const Text("Tentang"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HalamanWebView(
                          title: "Tentang",
                          // Ganti dengan URL asli milikmu
                          url:
                          "https://drive.google.com/drive/folders/1YUHXOt886dwnQr8IpQN9u4GtCKXp5PL_?usp=sharing",
                        ),
                      ),
                    );
                  },
                ),
                /*const _CustomListTile(
                  title: "Tentang",
                  icon: Icons.info_outline_rounded,
                  onTap: null,
                ),*/
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app_rounded,
                    color: Colors.orange,
                  ),
                  title: const Text ("Keluar"),
                  onTap: _logout,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;
  const _CustomListTile({
    required this.title,
    required this.icon,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const _SingleSection({this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        Column(children: children),
      ],
    );
  }
}