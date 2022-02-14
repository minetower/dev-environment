# Development workspace

## Setup

```bash
git clone https://github.com/minetower/dev-workspace.git minetower
# or, with ssh
git clone git@github.com:minetower/dev-workspace.git minetower

cd minetower

# clone repositories except optional
./scripts/clone.sh
# clone with ssh
./scripts/clone.sh --ssh
# clone all repositories
./scripts/clone.sh --all
# clone only repositories needed for one project
./scripts/clone.sh --needed=minecraft-tweaks
```

## Run whole site with docker

```bash
# you must clone at least without '--needed' argument
./scripts/clone.sh

docker-compose up site
```

Open http://localhost:8080
