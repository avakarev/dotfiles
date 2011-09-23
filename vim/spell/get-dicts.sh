#!/bin/bash

DICT_RU="ru.utf-8.spl"
DICT_EN="en.utf-8.spl"

URLBASE="http://ftp.vim.org/vim/runtime/spell"

DOWNLD_PATH="$PWD"

echo "Attempting to download vim dicts"
curl "$URLBASE/{$DICT_EN,$DICT_RU}" --progress-bar --location --output "$DOWNLD_PATH/#1"

echo "Done!"
