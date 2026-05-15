#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
SOURCE_DIR="${REPO_ROOT}/skills"
DEFAULT_TARGET="${CODEX_HOME:-$HOME/.codex}/skills"

usage() {
  cat <<'EOF'
Usage:
  ./scripts/install.sh all [--target DIR]
  ./scripts/install.sh design-report [--target DIR]
  ./scripts/install.sh engineering-report [--target DIR]

Examples:
  ./scripts/install.sh all
  ./scripts/install.sh design-report
  ./scripts/install.sh engineering-report --target "$HOME/.codex/skills"
EOF
}

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  usage
  exit 0
fi

SELECTION="$1"
shift

TARGET_DIR="${DEFAULT_TARGET}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      if [[ $# -lt 2 ]]; then
        echo "Missing value for --target" >&2
        exit 1
      fi
      TARGET_DIR="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

install_skill() {
  local skill_name="$1"
  local source_path="${SOURCE_DIR}/${skill_name}"
  local target_path="${TARGET_DIR}/${skill_name}"

  if [[ ! -d "${source_path}" ]]; then
    echo "Skill not found: ${skill_name}" >&2
    exit 1
  fi

  mkdir -p "${TARGET_DIR}"
  rm -rf "${target_path}"
  cp -R "${source_path}" "${target_path}"
  echo "Installed ${skill_name} -> ${target_path}"
}

case "${SELECTION}" in
  all)
    install_skill "design-report"
    install_skill "engineering-report"
    ;;
  design-report|engineering-report)
    install_skill "${SELECTION}"
    ;;
  *)
    echo "Unknown skill selection: ${SELECTION}" >&2
    usage
    exit 1
    ;;
esac
