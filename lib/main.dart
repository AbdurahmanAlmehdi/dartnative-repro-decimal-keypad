import 'package:dartnative/dartnative.dart';

import 'dartnative_plugin_registrant.dart';

void main() {
  DartNativePluginRegistrant.registerAll();
  runApp(const DecimalRepro());
}

const _ink = TextStyle(fontSize: 15, color: Color(0xFF111111));
const _red = TextStyle(fontSize: 15, color: Color(0xFFC62828));

class DecimalRepro extends StatefulWidget {
  const DecimalRepro({super.key});

  @override
  State<DecimalRepro> createState() => _DecimalReproState();
}

class _DecimalReproState extends State<DecimalRepro> {
  final _amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      brightness: Brightness.light,
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(title: const Text('Decimal keypad')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Expected (Flutter): keyboardType: TextInputType.numberWithOptions(decimal: true) '
              'opens the decimal pad (digits and "."), so 12.5 can be typed.',
              style: _ink,
            ),
            const SizedBox(height: 8),
            const Text(
              'Actual: TextInputType has no numberWithOptions and no decimal value. '
              'The closest is TextInputType.number, used below: a digits-only pad with no "." key.',
              style: _red,
            ),
            const SizedBox(height: 24),
            const Text('Amount (LYD) — try to type 12.5', style: _ink),
            const Text('(focused at launch; tap it if the keypad is closed)',
                style: TextStyle(fontSize: 12, color: Color(0xFF777777))),
            const SizedBox(height: 8),
            TextField(
              controller: _amount,
              // Opens the keypad without a tap, so the problem shows at launch.
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: '0.00',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            Text('Typed: "${_amount.text}"', style: _ink),
          ],
        ),
      ),
    );
  }
}
