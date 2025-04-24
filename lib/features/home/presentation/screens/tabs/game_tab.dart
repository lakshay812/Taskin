import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:task_in/features/home/presentation/screens/tabs/game/asteroid_game.dart';

class GameTab extends StatefulWidget {
  const GameTab({super.key});

  @override
  State<GameTab> createState() => _GameTabState();
}

class _GameTabState extends State<GameTab> {
  late AsteroidGame game;

  @override
  void initState() {
    super.initState();
    game = AsteroidGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget<AsteroidGame>(
            game: game,
            overlayBuilderMap: {
              'gameOver': (context, game) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Game Over',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Score: ${game.score}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          'Coins: ${game.coins}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            game.reset();
                          },
                          child: const Text('Play Again'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            },
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildControlButton(Icons.arrow_back, () {
                  game.player.position.x = (game.player.position.x - 10)
                      .clamp(0, game.size.x - game.player.size.x);
                }),
                _buildControlButton(Icons.arrow_forward, () {
                  game.player.position.x = (game.player.position.x + 10)
                      .clamp(0, game.size.x - game.player.size.x);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTapDown: (_) => onPressed(),
      onLongPressMoveUpdate: (_) => onPressed(),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }

  @override
  void dispose() {
    game.isActive = false;
    super.dispose();
  }
}
