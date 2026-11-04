FROM node:22-bookworm-slim

WORKDIR /app

# Use the exact package manager version declared by package.json.
RUN corepack enable && corepack prepare pnpm@10.33.0 --activate

# Install dependencies using the committed lockfile. Local tarballs and the
# pnpm patch must be present before installation.
COPY package.json pnpm-lock.yaml ./
COPY patches/ ./patches/
COPY vendor/ ./vendor/
RUN pnpm install --frozen-lockfile

# Copy the application and generate its production assets.
COPY . .
RUN pnpm build && pnpm prune --prod

ENV NODE_ENV=production
ENV PORT=8080

EXPOSE 8080

CMD ["node", "src/server.js"]
