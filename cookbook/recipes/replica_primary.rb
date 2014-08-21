include_recipe 'glustertest::replica'

execute 'gluster volume create gv0 replica 2 10.1.1.13:/home/ubuntu/glustervol/brick 10.1.1.12:/home/ubuntu/glustervol/brick'
execute 'gluster volume start gv0'
