#!/bin/bash


password_file="step2.sh"

# パスワード追加する関数

add_password() {
	read -p 	"サービス名を入力してください：" service_name
	read -p 	"ユーザー名を入力してください：" username
	read -s -p 	"パスワードを入力してください：" password
	echo ""
	echo ""
	echo "${service_name}:${username}:${password}" >> "$password_file"
	echo 		"パスワードの追加は成功しました。"
}

# パスワード取得する関数

get_password() {
	read -p 	"サービス名を入力してください：" service_name
	found=$(grep -c "^$service_name:" "$password_file")
	if [ $found -eq 0 ]; then
		echo ""
		echo ""
		echo 	"そのサービスは登録されていません。"
	else
        	password_info=$(grep "^$service_name:" "$password_file")
        	username=$(echo "$password_info" | cut -d':' -f2)
        	password=$(echo "$password_info" | cut -d':' -f3)
        	echo 	"サービス名：$service_name"
        	echo 	"ユーザー名：$username"
        	echo 	"パスワード：$password"
	fi
}

# メインメニュー
while true; do
    echo 		"パスワードマネージャーへようこそ！"
    echo 		"次の選択肢から入力してください(Add Password/Get Password/Exit)："
    read choice

    case $choice in
        "add")
            add_password
            ;;
        "get")
            get_password
            ;;
        "exit")
            echo 	"Thank you!"
            exit 0
            ;;
        *)
            echo 	"入力が間違えています。Add Password/Get Password/Exit から入力してください。"
            ;;
    esac
done

