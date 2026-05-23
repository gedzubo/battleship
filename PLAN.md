# Long term plan + goals

## Technology

- **Rely on core Rails as much as possible** — avoid adding external gems unless there is no reasonable built-in alternative. Every dependency should be justified.
- **Use Minitest instead of RSpec** — keep the test stack minimal and close to Rails defaults; no additional DSL or configuration overhead.
- **Use SQLite as the only database** — no PostgreSQL. SQLite handles all persistence: primary DB, Solid Cache, Solid Cable (ActionCable backend), and Solid Queue (background jobs if needed).
- **Use Rails built-in authentication** (`rails generate authentication`) — no Devise or other auth gems. Goal is to stay on first-party Rails functionality.
- **Use Active Job + Solid Queue if background processing is needed** — Solid Queue runs on SQLite, so no extra infrastructure is required.
- **Use Action Text for rich content fields** — initially for player notes; may extend to in-game chat if rich formatting is needed.
- **Use Hotwire (Turbo + Stimulus) for the frontend** — Turbo Streams over ActionCable for real-time board updates (hit/miss, game state changes); Stimulus for local UI interactions that don't require a server round-trip.
- **Use Tailwind CSS for styling** — utility-first approach for all UI, no custom CSS frameworks or additional component libraries.
- **Keep models, views, and controllers focused on their core responsibilities** — models handle persistence, controllers handle HTTP, views handle presentation. A `app/services/` folder will be introduced to house business logic and prevent these layers from accumulating domain concerns.

## Features

### Authentication & Players
- Players can register and log in using Rails built-in authentication.
- A player can see a list of other registered players and their current online status (online/offline).

### Lobby & Matchmaking
- A player can invite another player to start a game.
- The invited player receives the invite and can accept or decline.

### Gameplay
- Before the game starts, each player places their ships on their own board.
- During the game, each player sees two boards: their own board (with ship positions and incoming hits marked) and the enemy board (with their own hit/miss attempts marked).
- Players take turns firing at the enemy board. Hit or miss results are shown in real time for both players.
- The game ends when all ships of one player are sunk. The winner is declared.
- Both players can see the enemy's online status during the game.

### In-game Chat
- Players can send messages to each other during a game via a real-time chat.

### Game History & Replay
- A player can view a list of their completed games.
- A player can replay a completed game — stepping through the moves that were made.
- A player can leave notes on a completed game (e.g. reflections, strategy notes).

### Social
- **Friend list** — players can add others as friends, filter the lobby to show only friends, and get notified when a friend comes online.
- **Rematch** — after a game ends, either player can propose a rematch with one click.
- **Spectator mode** — any player can watch an ongoing game between two others in read-only mode.

### Gameplay Enhancements
- **Pre-select next coordinate** — while waiting for the enemy's turn, a player can mark their intended next shot on the board; it fires automatically when their turn arrives.
- **Turn timer** — an optional game mode selected when sending a game invite. The invited player can see that it is a timed game before accepting. Once in game, each player has a fixed time per turn; the turn is forfeited if the timer expires.
- **Random ship placement** — a button to auto-place ships randomly for players who prefer not to place manually.
- **Shot tracking on the enemy board** — all fired coordinates are permanently marked on the enemy board (hits and misses clearly distinguished), so players always have a full picture of which squares have been targeted.

### Progression & Stats
- **Player profile page** — displays win/loss record, total games played, and shot accuracy (hits vs. total shots fired).
- **Leaderboard** — ranked list of all players by wins or win rate.

### Notifications
- **Turn notifications** — in-app alert when it is your turn, in case you have navigated away from the game.
- **Invite notifications** — real-time alert when another player sends a game invite.


