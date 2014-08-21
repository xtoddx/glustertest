directory '/home/ubuntu/gv1-mount'

package 'glusterfs-client'
mount '/home/ubuntu/gv1-mount' do
  device '10.1.1.14:gv1'
  fstype 'glusterfs'
end
