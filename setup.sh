#!/usr/bin/env bash

set -e

echo "🚀 Initializing Developer Tooling Mastery 2026..."

echo ""
echo "📁 Creating root documentation..."

touch README.md
touch ROADMAP.md
touch STUDY-PLAN.md
touch GLOSSARY.md
touch CHEATSHEET.md
touch FAQ.md
touch CONTRIBUTING.md
touch CHANGELOG.md
touch LICENSE

echo ""
echo "📁 Creating docs structure..."

mkdir -p docs

mkdir -p docs/00-mental-model
mkdir -p docs/01-development-environment
mkdir -p docs/02-terminal-and-shell
mkdir -p docs/03-editor-and-workspace
mkdir -p docs/04-runtime-management
mkdir -p docs/05-package-managers
mkdir -p docs/06-project-metadata
mkdir -p docs/07-project-files
mkdir -p docs/08-formatting
mkdir -p docs/09-linting
mkdir -p docs/10-typescript-tooling
mkdir -p docs/11-build-tools
mkdir -p docs/12-environment-configuration
mkdir -p docs/13-git-hooks-and-commit-quality
mkdir -p docs/14-ci-and-automation
mkdir -p docs/15-dependency-management
mkdir -p docs/16-repository-architectures
mkdir -p docs/17-monorepo-tooling
mkdir -p docs/18-nx-basics
mkdir -p docs/19-project-standards
mkdir -p docs/20-final-professional-workspace

echo ""
echo "📄 Creating README files..."

cat > docs/README.md <<EOF
# Documentation

---
EOF

cat > docs/00-mental-model/README.md <<EOF
# Mental Model

---
EOF

cat > docs/01-development-environment/README.md <<EOF
# Development Environment

---
EOF

cat > docs/02-terminal-and-shell/README.md <<EOF
# Terminal and Shell

---
EOF

cat > docs/03-editor-and-workspace/README.md <<EOF
# Editor and Workspace

---
EOF

cat > docs/04-runtime-management/README.md <<EOF
# Runtime Management

---
EOF

cat > docs/05-package-managers/README.md <<EOF
# Package Managers

---
EOF

cat > docs/06-project-metadata/README.md <<EOF
# Project Metadata

---
EOF

cat > docs/07-project-files/README.md <<EOF
# Project Files

---
EOF

cat > docs/08-formatting/README.md <<EOF
# Formatting

---
EOF

cat > docs/09-linting/README.md <<EOF
# Linting

---
EOF

cat > docs/10-typescript-tooling/README.md <<EOF
# TypeScript Tooling

---
EOF

cat > docs/11-build-tools/README.md <<EOF
# Build Tools

---
EOF

cat > docs/12-environment-configuration/README.md <<EOF
# Environment Configuration

---
EOF

cat > docs/13-git-hooks-and-commit-quality/README.md <<EOF
# Git Hooks and Commit Quality

---
EOF

cat > docs/14-ci-and-automation/README.md <<EOF
# CI and Automation

---
EOF

cat > docs/15-dependency-management/README.md <<EOF
# Dependency Management

---
EOF

cat > docs/16-repository-architectures/README.md <<EOF
# Repository Architectures

---
EOF

cat > docs/17-monorepo-tooling/README.md <<EOF
# Monorepo Tooling

---
EOF

cat > docs/18-nx-basics/README.md <<EOF
# Nx Basics

---
EOF

cat > docs/19-project-standards/README.md <<EOF
# Project Standards

---
EOF

cat > docs/20-final-professional-workspace/README.md <<EOF
# Final Professional Workspace

---
EOF

echo ""
echo "✅ Initial structure created successfully!"
echo ""
echo "Next step:"
echo "1. Complete README.md"
echo "2. Complete ROADMAP.md"
echo "3. Start Module 00 - Mental Model"