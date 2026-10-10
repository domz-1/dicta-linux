#!/usr/bin/env bash
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${RED}Uninstalling Dicta Linux...${NC}"

rm -f "$HOME/.local/bin/dicta"
rm -f "$HOME/.local/share/applications/dicta.desktop"

echo -e "${GREEN}✓ Dicta Linux has been removed.${NC}"
