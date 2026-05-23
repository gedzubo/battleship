# Battleship — Claude instructions

Refer to [PLAN.md](PLAN.md) for the full feature roadmap and technology rationale.

## Technology constraints

Follow these strictly — they are intentional learning choices, not defaults to override:

- **No new gems** unless there is no reasonable Rails built-in alternative. Every dependency must be justified.
- **Minitest only** — no RSpec.
- **SQLite only** — no PostgreSQL. SQLite is used for the primary DB, Solid Cache, Solid Cable, and Solid Queue.
- **Rails built-in authentication** (`rails generate authentication`) — no Devise.
- **Hotwire (Turbo + Stimulus)** for all frontend interactivity — no React, Vue, or other JS frameworks.
- **Tailwind CSS** for styling — no custom CSS frameworks or component libraries.
- **No business logic in models or controllers** — use `app/services/` for domain logic.
