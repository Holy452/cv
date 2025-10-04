# Sky Runner - Endless Runner Game

An endless runner 2D game similar to Jetpack Joyride, built with Godot 4.

## 🎮 Game Features

- **Jetpack Flight Mechanics**: Hold space or click to fly up, release to fall
- **Dynamic Obstacles**: 
  - Laser beams from top and bottom
  - Homing missiles
  - Electric zappers
- **Collectibles**: Coins in various patterns (single, lines, waves)
- **Progressive Difficulty**: Game speed increases over time
- **Score System**: Based on distance traveled and coins collected
- **Particle Effects**: Thrust particles, exhaust trails, and collection effects
- **Parallax Scrolling Background**: Multi-layered clouds and ground

## 🚀 How to Run

1. **Install Godot 4.2 or later**
   - Download from [godotengine.org](https://godotengine.org/download)

2. **Open the Project**
   - Launch Godot
   - Click "Import"
   - Navigate to this folder and select `project.godot`
   - Click "Import & Edit"

3. **Play the Game**
   - Press F5 or click the Play button in the top-right corner
   - Or right-click on `scenes/Main.tscn` and select "Run Scene"

## 🎯 Controls

- **Space** or **Left Mouse Button**: Fly up
- Release to fall down

## 📁 Project Structure

```
/workspace/
├── project.godot          # Main project configuration
├── icon.svg              # Project icon
├── scenes/               # Game scenes
│   ├── Main.tscn        # Main game scene
│   ├── Player.tscn      # Player character
│   ├── LaserObstacle.tscn
│   ├── MissileObstacle.tscn
│   ├── ZapperObstacle.tscn
│   ├── Coin.tscn
│   └── ParallaxBG.tscn  # Scrolling background
└── scripts/             # GDScript files
    ├── Main.gd          # Game manager
    ├── Player.gd        # Player controller
    ├── Obstacle.gd      # Obstacle behavior
    ├── Coin.gd          # Coin collection
    └── ParallaxBackground.gd
```

## 🎨 Gameplay Mechanics

### Player
- Gravity constantly pulls the player down
- Press and hold to activate jetpack and fly up
- Tilt animation based on vertical velocity
- Death occurs on collision with obstacles or hitting ground

### Obstacles
- **Lasers**: Static vertical beams from top or bottom
- **Missiles**: Fast-moving projectiles with exhaust particles
- **Zappers**: Electric barriers with pulsing effects

### Coins
- Three spawn patterns: single, horizontal line, and wave
- Collect for bonus points (10 points each)
- Animated collection effect

### Difficulty
- Game speed increases every 10 seconds
- Obstacles spawn more frequently
- Parallax background speed adjusts to game speed

## 🏆 Scoring

- **Distance**: 1 point per meter traveled
- **Coins**: 10 points per coin collected
- **Final Score**: Distance + (Coins × 10)

## 🎓 Learning Resources

This project demonstrates:
- Character physics and movement
- Procedural obstacle spawning
- Collision detection
- UI and game state management
- Particle systems
- Parallax scrolling
- Signal-based communication between nodes

## 🔧 Customization

Feel free to modify:
- `GRAVITY` and `FLY_FORCE` in `Player.gd` for different flight feel
- `OBSTACLE_SPAWN_INTERVAL` in `Main.gd` for difficulty
- Obstacle speeds and sizes in respective scenes
- Colors and visual effects

## 📝 License

This is a learning project. Feel free to use and modify as needed!

---

**Have fun playing! 🎮✨**
