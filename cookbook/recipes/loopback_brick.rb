execute 'dd if=/dev/zero of=/home/ubuntu/loopback.vol bs=1M count=500' do
  not_if { File.file?('/home/ubuntu/loopback.vol') }
end

execute 'mkfs.ext4 -F /home/ubuntu/loopback.vol' do
  not_if 'grep -qs /home/ubuntu/glustervol /proc/mounts'
end

# create the mountpoint
directory '/home/ubuntu/glustervol' do
  owner 'ubuntu'
  group 'ubuntu'
end

mount '/home/ubuntu/glustervol' do
  device '/home/ubuntu/loopback.vol'
end

directory '/home/ubuntu/glustervol/brick'
