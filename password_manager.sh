#!/bin/bash


password_file="password_BOX.sh"
decrypted_file="temp_passwords.txt"

# パスワード追加する関数

add_password() {
	gpg -d "$password_file.gpg" > "$password_file" # 複数管理のために複号化
	read -p 	"サービス名を入力してください：" service_name
	read -p 	"ユーザー名を入力してください：" username
	read -s -p 	"パスワードを入力してください：" password
	echo ""
	echo ""
	echo "${service_name}:${username}:${password}" >> "$password_file"
	gpg -c "$password_file"  # 暗号化_password_file.gpg作成
   rm "$password_file" # 暗号化されていないファイルを削除 
   	echo    ""
	echo 		"パスワードの追加は成功しました。"
	echo    ""
}

# パスワード取得する関数

get_password() {
	gpg -d "$password_file.gpg" > $decrypted_file  # ファイルを復号化
	echo    ""
	read -p 	"サービス名を入力してください：" input_service_name
	echo    ""
	found=$(grep -c "^$input_service_name:" "$decrypted_file")
	if [ $found -eq 0 ]; then
		echo ""
		echo 	"そのサービスは登録されていません。"
		echo ""
	else
		password_info=$(grep "^$input_service_name:" "$decrypted_file")
        	username=$(echo "$password_info" | cut -d':' -f2)
        	password=$(echo "$password_info" | cut -d':' -f3)
		echo    ""
		echo 	"サービス名：$input_service_name"
        	echo 	"ユーザー名：$username"
        	echo 	"パスワード：$password"
		echo    ""
	fi
    rm "$decrypted_file"  # 一時ファイルを削除
}

# メインメニュー
while true; do
    echo 		"パスワードマネージャーへようこそ！"
    echo 		"次の選択肢から入力してください(Add Password/Get Password/Exit)："
    echo    ""
    read choice

    case $choice in
        "add")
		echo    ""
            add_password
	    	echo    ""
            ;;
        "get")
		echo    ""
            get_password
	    	echo    ""
            ;;
        "exit")
	    	echo ""	
            	echo 	"Thank you!"
            	exit 0
            ;;
        *)
	    echo    ""	
            echo 	"入力が間違えています。Add Password/Get Password/Exit から入力してください。"
	    echo    ""
	    ;;
    esac
done
