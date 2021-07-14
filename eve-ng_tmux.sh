#! /bin/bash

# Tmuxing multiple network nodes in EVE-ng

echo Please enter remote host IP : 
read IP
echo Please Enter Number of Devices In Your Topology
read nodecount
chmod u+x t.sh

SESSION=1
WINDOW=1
NODE=1
sport=32769
eport=$(($sport + $nodecount));
# tmux list-windows -a
killall tmux
for (( SP=$sport; SP<$eport; SP++ ))
	do
  		nc -z -v -w5 $IP $SP
  		eval=$?
	 if [[ "$eval" == "0" ]]
  	  then
		{
		    echo "tmux new-session -d -s $SESSION"
		    # echo "tmux new-window -t $SESSION:$WINDOW -n $tm"
		    echo "tmux select-window -t $SESSION:$WINDOW"
		    echo "tmux rename-window $NODE"
		    echo "tmux send-keys -t $NODE 'telnet $IP $SP' C-m"
		    echo "tmux send-keys -t $NODE 'enable' C-m"
		    echo "tmux a -t $SESSION:$NODE"
		} > t.sh
             open t.sh
             sleep 1
  	  else
	   echo Device $NODE is not avaliable
	   read -n1 -r -p 'Press any key to continue'
      fi
	 ((SESSION++))
	 ((NODE++))
done
