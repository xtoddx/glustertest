include_recipe 'glustertest::loopback_brick'

package 'glusterfs-server'

# Executing this on .13 will do nothing (but isn't error) and doing it on .12
# will peer the two toghether and each machine will see the other.
#
# Use .13 because it comes up first from defiintion in Vagratnfile.
execute 'gluster peer probe 10.1.1.13'

