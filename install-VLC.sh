echo -e "\n--- setting up server to stream videos ---\n"
sudo apt-get -qq update
sudo apt-get -y install vlc > /dev/null 2>&1
echo -e "\n--- vlc -vvv --loop /home/vagrant/DemoVideo.mp4 --sout '#transcode{vcodec=mp4v,acodec=mpga,vb=800,ab=128}:standard{access=http,mux=ogg,dst=demo.com:8090}'  ---\n"
sudo cp /vagrant/DemoVideo.mp4 /home/vagrant/DemoVideo.mp4
sudo cat > /home/vagrant/startstream.sh << "EOF"
vlc -vvv --loop /home/vagrant/DemoVideo.mp4 --sout '#transcode{vcodec=mp4v,acodec=mpga,vb=800,ab=128}:standard{access=http,mux=ogg,dst=demo.com:8090}' 
EOF
sudo chmod a+x /home/vagrant/startstream.sh
sudo chown vagrant:vagrant /home/vagrant/startstream.sh






