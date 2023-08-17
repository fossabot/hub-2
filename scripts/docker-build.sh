#!/bin/sh

# Build docker images
GIT_SHA=$(git rev-parse HEAD)
TS=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
VERSION=devel

# ah
docker build \
    -f cmd/ah/Dockerfile \
    -t khulnasoft/ah \
    -t khulnasoft/ah:$GIT_SHA \
    -t localhost:5000/khulnasoft/ah:$VERSION \
    --build-arg VERSION=$VERSION \
    --build-arg GIT_COMMIT=$GIT_SHA \
    --label org.opencontainers.image.description='Artifact Hub command line tool' \
    --label org.opencontainers.image.version=$VERSION \
    --label org.opencontainers.image.created=$TS \
    --label org.opencontainers.image.documentation='https://khulnasoft.io/docs/topics/cli' \
    --label org.opencontainers.image.source='https://github.com/khulnasoft/hub/tree/${GIT_SHA}/cmd/ah' \
    --label org.opencontainers.image.vendor='Artifact Hub' \
    --label io.khulnasoft.package.readme-url='https://raw.githubusercontent.com/khulnasoft/hub/${GIT_SHA}/docs/cli.md' \
    --label io.khulnasoft.package.maintainers='[{"name":"Artifact Hub maintainers","email":"cncf-khulnasoft-maintainers@lists.cncf.io"}]' \
    --label io.khulnasoft.package.logo-url='https://raw.githubusercontent.com/khulnasoft/hub/master/docs/logo/logo.svg' \
    --label io.khulnasoft.package.keywords='artifact hub,cli,lint' \
    --label io.khulnasoft.package.license='Apache-2.0' \
    --label io.khulnasoft.package.alternative-locations='public.ecr.aws/khulnasoft/ah' \
.

# hub
docker build \
    -f cmd/hub/Dockerfile \
    -t khulnasoft/hub \
    -t khulnasoft/hub:$GIT_SHA \
.

# db-migrator
docker build \
    -f database/migrations/Dockerfile \
    -t khulnasoft/db-migrator \
    -t khulnasoft/db-migrator:$GIT_SHA \
.

# scanner
docker build \
    -f cmd/scanner/Dockerfile \
    -t khulnasoft/scanner \
    -t khulnasoft/scanner:$GIT_SHA \
.

# tracker
docker build \
    -f cmd/tracker/Dockerfile \
    -t khulnasoft/tracker \
    -t khulnasoft/tracker:$GIT_SHA \
.
