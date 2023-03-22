@echo off
setlocal EnableDelayedExpansion

set OPENAI_API_KEY=sk-xxxxxxxx
python src\1_generate_things.py data -n 25
python src\2_sort_things.py data 
python src\3_build_things.py data .\out -n 25

xcopy /s .\out\parts\* ..\ui\public\data\parts\
copy .\data\catalogue.json ..\ui\public\data\catalogue.json