k3d cluster create devcluster --servers 1 --agents 2 --api-port 127.0.0.1:6445 --k3s-arg "--disable=traefik@server:0" \
-p "8092:30040@agent:0" -p "8082:30030@agent:0" -p "8081:30090@agent:0" -p "443:30091@agent:0" -p "8200:30080@agent:0" \
-p "27017:30070@agent:0"  -p "5432:30060@agent:0" -p "9021:30100@agent:0" \
--agents-memory 3G --servers-memory 6G --k3s-arg '--kubelet-arg=eviction-hard=imagefs.available<1%,nodefs.available<1%@server:0' \
--k3s-arg '--kubelet-arg=eviction-minimum-reclaim=imagefs.available=1%,nodefs.available=1%@server:0' \
--k3s-arg '--kubelet-arg=eviction-hard=imagefs.available<1%,nodefs.available<1%@agent:0,1' \
--k3s-arg '--kubelet-arg=eviction-minimum-reclaim=imagefs.available=1%,nodefs.available=1%@agent:0,1' \
--registry-use k3d-dev-app-registry:5050 --registry-config local-registry.yaml \
--wait
