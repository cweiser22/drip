# Drip

**Drip** is a real-time chat application built with [Phoenix](https://www.phoenixframework.org/) and Elixir.

🚧 **This project is still under active development. Expect incomplete features, potential bugs, and unrefined code.**  

---

## Getting Started

### Prerequisites

Ensure you have the following installed:

- Elixir ~> 1.14
- Erlang/OTP ~> 25
- PostgreSQL
- Node.js (for asset building)

### Setup

Clone the repo and set up the project:

```bash
git clone https://github.com/cweiser22/drip.git
cd drip
mix deps.get
cd assets && npm install && cd ..
