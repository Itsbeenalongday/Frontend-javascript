echo "############################################"
echo "#                                          #"
echo "#                                          #"
echo "#                                          #"
echo "#                                          #"
echo "#    git pull push auto script ver 1.0     #"
echo "#                                          #"
echo "#         written by sungminyou            #"
echo "#                                          #"
echo "#                                          #"
echo "#                                          #"
echo "############################################"
echo -e "\n"
echo "*** start pull ***"; git pull
echo -e "\n"
echo -n "please enter a commit message >> "
read line
git add .
git commit -am "$line"
git push
echo "Pushing ended successfully"