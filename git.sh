echo "커밋 메시지를 입력하세요"
read line
git add .
git commit -am "$line"