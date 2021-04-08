#! /usr/bin/env bash

echo "Digite o nome da linguagem desejada"
read linguagem

numero_linhas=$(grep -c ".*" Repositorios/$linguagem.txt)
urls=Repositorios/$linguagem.txt
echo "Números de repositórios: $numero_linhas ."
for minerar in `cat $urls`
    do
        echo "minerando no link: $minerar"
        caminho_repositorio=$(echo $minerar | sed 's/https:\/\/github.com\///g' -s)
        repositorio=$(echo $caminho_repositorio | sed 's/\//-/g' | sed 's/.*-//g')
		arquivo=$(echo "$linguagem\_$repositorio" | sed 's/\\//g')
		curl -H "Accept: application/vnd.github.v3+json"  https://api.github.com/repos/"$caminho_repositorio"/pulls?state=closed | grep login | head -200| sed 's/"login": "//g' | sed 's/[", ]//g' | sort | uniq -c | sort -n | sort -nr | awk '{ print $2 "," $1}' >$arquivo.csv
    done
