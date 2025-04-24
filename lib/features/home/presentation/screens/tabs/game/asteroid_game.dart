import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AsteroidGame extends FlameGame with HasCollisionDetection {
  late Player player;
  late TextComponent scoreText;
  late TextComponent coinsText;
  late SpriteComponent scoreIcon;
  late SpriteComponent coinIcon;
  int score = 0;
  int coins = 0;
  bool isGameOver = false;
  final Random random = Random();
  bool isActive = true;
  final List<Vector2> starPositions = [];
  final double starSpeed = 200;

  @override
  Future<void> onLoad() async {
    // Load sprites
    final spaceshipSprite = await loadSprite('spaceship.png');
    final scoreSprite = await loadSprite('score.png');
    final coinSprite = await loadSprite('coin.png');

    // Initialize player with initial position
    player = Player(sprite: spaceshipSprite);
    add(player);

    // Initialize score icon and text (adjusted position to be visible)
    scoreIcon = SpriteComponent(
      sprite: scoreSprite,
      position: Vector2(size.x - 150, 14),
      size: Vector2(24, 24),
    );
    add(scoreIcon);

    scoreText = TextComponent(
      text: 'Score: 0',
      position: Vector2(size.x - 110, 19),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
    add(scoreText);

    // Initialize coin icon and text (adjusted position to be visible)
    coinIcon = SpriteComponent(
      sprite: coinSprite,
      position: Vector2(size.x - 150, 44),
      size: Vector2(24, 24),
    );
    add(coinIcon);

    coinsText = TextComponent(
      text: 'Coins: 0',
      position: Vector2(size.x - 110, 49),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
    add(coinsText);

    // Initialize stars
    for (int i = 0; i < 50; i++) {
      starPositions.add(Vector2(
        random.nextDouble() * size.x,
        random.nextDouble() * size.y,
      ));
    }

    // Add initial asteroids
    for (int i = 0; i < 5; i++) {
      addAsteroid();
    }

    // Start bullet timer
    add(
      TimerComponent(
        period: 0.5,
        repeat: true,
        onTick: () {
          if (!isGameOver && isActive) {
            final bullet = Bullet(
              position: player.position.clone()..y -= player.size.y / 2,
              direction: Vector2(0, -1),
            );
            add(bullet);
          }
        },
      ),
    );
  }

  void addAsteroid() async {
    final sprite = await loadSprite('granite.png');
    final asteroid = Asteroid(
      sprite: sprite,
      position: Vector2(
        random.nextDouble() * size.x,
        -50,
      ),
    );
    add(asteroid);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Render stars
    final paint = Paint()..color = Colors.white;
    for (final starPos in starPositions) {
      canvas.drawCircle(
        Offset(starPos.x, starPos.y),
        1,
        paint,
      );
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update stars
    for (int i = 0; i < starPositions.length; i++) {
      starPositions[i].y += starSpeed * dt;
      if (starPositions[i].y > size.y) {
        starPositions[i].y = 0;
        starPositions[i].x = random.nextDouble() * size.x;
      }
    }

    // Check for coin award
    if (score > 0 && score % 100 == 0) {
      coins++;
      coinsText.text = 'Coins: $coins';
    }
  }

  void gameOver() {
    isGameOver = true;
    overlays.add('gameOver');
  }

  void reset() async {
    isGameOver = false;
    score = 0;
    coins = 0;
    scoreText.text = 'Score: 0';
    coinsText.text = 'Coins: 0';

    // Reset player to original position
    player.position = Vector2(size.x / 2, Player.INITIAL_Y_POSITION);

    removeWhere((component) => component is Asteroid || component is Bullet);
    overlays.remove('gameOver');

    // Add initial asteroids after reset
    for (int i = 0; i < 5; i++) {
      addAsteroid();
    }
  }
}

class Player extends SpriteComponent
    with CollisionCallbacks, HasGameRef<AsteroidGame> {
  static const double INITIAL_Y_POSITION = 550;

  Player({required Sprite sprite})
      : super(
          sprite: sprite,
          size: Vector2(40, 40),
          position: Vector2(200, INITIAL_Y_POSITION),
        ) {
    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Asteroid && !gameRef.isGameOver) {
      gameRef.gameOver();
    }
  }
}

class Asteroid extends SpriteComponent
    with CollisionCallbacks, HasGameRef<AsteroidGame> {
  final Vector2 velocity = Vector2(0, 100);

  Asteroid({
    required Sprite sprite,
    required Vector2 position,
  }) : super(
          sprite: sprite,
          position: position,
          size: Vector2(30, 30),
        ) {
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!gameRef.isGameOver && gameRef.isActive) {
      position += velocity * dt;
      if (position.y > gameRef.size.y) {
        removeFromParent();
        gameRef.addAsteroid();
        gameRef.score++;
        gameRef.scoreText.text = 'Score: ${gameRef.score}';
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Bullet) {
      removeFromParent();
      other.removeFromParent();
      gameRef.addAsteroid();
      gameRef.score++;
      gameRef.scoreText.text = 'Score: ${gameRef.score}';
    }
  }
}

class Bullet extends PositionComponent
    with CollisionCallbacks, HasGameRef<AsteroidGame> {
  final Vector2 direction;
  final double speed = 300;

  Bullet({
    required Vector2 position,
    required this.direction,
  }) : super(
          position: position,
          size: Vector2(6, 6),
        ) {
    add(CircleHitbox());
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      Paint()..color = Colors.yellow,
    );
  }

  @override
  void update(double dt) {
    if (!gameRef.isGameOver && gameRef.isActive) {
      position += direction * speed * dt;
      if (position.y < 0) {
        removeFromParent();
      }
    }
  }
}
