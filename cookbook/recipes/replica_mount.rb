package 'glusterfs-client'

mount '/mnt' do
  device '10.1.1.12:gv0'
  fstype 'glusterfs'
end
