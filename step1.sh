#!/bin/bash

echo			"パスワードマネージャーへようこそ！"

read -p			"サービス名を入力してください：" service_name
read -p			"ユーザー名を入力してください: " username
read -s -p		"パスワードを入力してください: " password
echo ""

# パスワードをファイルに追記
echo "${service_name}:${username}:${password}" >> step1.sh

echo				"Thank you!"

1:2:3
