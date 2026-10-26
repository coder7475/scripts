#!/usr/bin/env python3
"""
Node.js Application Project Scaffolder.
Generates an opinionated, production-ready directory and file layout for Node.js / Express services.
"""

import sys
from pathlib import Path

DEFAULT_FILES = [
    "src/app.js",
    "src/config/database.js",
    "src/controllers/authController.js",
    "src/controllers/userController.js",
    "src/middleware/auth.js",
    "src/middleware/error.js",
    "src/models/User.js",
    "src/routes/auth.js",
    "src/routes/users.js",
    "src/utils/logger.js",
    "src/utils/validation.js",
    "tests/auth.test.js",
    "tests/users.test.js",
    ".env.example",
    "package.json",
]


def scaffold_project(base_path: Path) -> None:
    print(f"Scaffolding Node.js project in: {base_path.resolve()}")
    for rel_path in DEFAULT_FILES:
        target = base_path / rel_path
        target.parent.mkdir(parents=True, exist_ok=True)
        if not target.exists() or target.stat().st_size == 0:
            target.touch()
            print(f"  [+] Created: {rel_path}")
        else:
            print(f"  [.] Skipped (exists): {rel_path}")
    print("\nProject scaffold complete.")


if __name__ == "__main__":
    target_dir = Path(sys.argv[1]) if len(sys.argv) > 1 else Path.cwd()
    scaffold_project(target_dir)
