.PHONY: up down build seed logs frontend-logs backend-logs mongo-logs clean

# Start all services
up:
	docker compose -f docker-compose.dev.yml up -d

# Start services and rebuild
rebuild:
	docker compose -f docker-compose.dev.yml up -d --build

# Stop all services
down:
	docker compose -f docker-compose.dev.yml down

# Build all services
build:
	docker compose -f docker-compose.dev.yml build

# Seed the database
seed:
	docker compose -f docker-compose.dev.yml exec backend python seed_db.py

# View logs for all services
logs:
	docker compose -f docker-compose.dev.yml logs -f

# View logs for frontend
frontend-logs:
	docker compose -f docker-compose.dev.yml logs -f frontend

# View logs for backend
backend-logs:
	docker compose -f docker-compose.dev.yml logs -f backend

# View logs for MongoDB
mongo-logs:
	docker compose -f docker-compose.dev.yml logs -f mongo

# Remove containers, volumes and networks
clean:
	docker compose -f docker-compose.dev.yml down -v

# Enter backend container shell
backend-shell:
	docker compose -f docker-compose.dev.yml exec backend sh

# Enter frontend container shell
frontend-shell:
	docker compose -f docker-compose.dev.yml exec frontend sh

# Package backend dependencies
backend-install:
	cd backend && poetry install

# Package frontend dependencies
frontend-install:
	cd frontend && npm install
	
# Fix permissions in the frontend container
fix-frontend-permissions:
	docker compose -f docker-compose.dev.yml exec frontend sh -c "mkdir -p /app/node_modules/.cache && chmod -R 777 /app/node_modules/.cache"