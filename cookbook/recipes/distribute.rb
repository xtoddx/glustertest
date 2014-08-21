include_recipe 'glustertest::loopback_brick'

package 'glusterfs-server'
execute 'gluster volume create gv1 10.1.1.14:/home/ubuntu/glustervol/brick'
execute 'gluster volume start gv1'
