#!/usr/bin/env bash

NVMET_SUBNQN="nqn.2016-06.io.spdk:cnode1"
NVMET_IP="127.0.0.1"
NVMET_TRTYPE="TCP"
NVMET_PORT="4420"
NVMET_ADRFAM="ipv4"

# Change pcie_id to match device
NVMET_PCIE_ID="0000:01:00.0"
SPDK_REPO="spdk"
SPDK_RPC="${SPDK_REPO}/scripts/rpc.py"

# Check kernel modules
modprobe nvme
modprobe nvmet
modprobe nvmet_tcp
modprobe nvme_fabrics
modprobe nvme_tcp

# Kill any existing fabrics target
pkill -f nvmf_tgt

# Switch to userspace driver
xnvme-driver

# Start the fabrics target
pushd ${SPDK_REPO}/build/bin
# Apply cpumask with '-m'
(nohup ./nvmf_tgt -m [1]  > foo.out 2> foo.err < /dev/null &)
sleep 2
popd


# Setup default fabrics target according to the description found here:
# https://spdk.io/doc/nvmf.html
# In the subsection "Configuring the SPDK NVMe over Fabrics Target"
# The only deviation is the use of a bdev_nvme controller instead of a bdev_malloc controller 

${SPDK_RPC} nvmf_create_transport \
            -t ${NVMET_TRTYPE} \
            -u 16384 \
            -m 8 \
            -c 8192

${SPDK_RPC} nvmf_create_subsystem \
            ${NVMET_SUBNQN} \
            -a \
            -s SPDK00000000000001 \
            -d SPDK_Controller1

${SPDK_RPC} bdev_nvme_attach_controller \
            -b Nvme0 \
            -t PCIe \
            -a ${NVMET_PCIE_ID}

${SPDK_RPC} nvmf_subsystem_add_ns \
            ${NVMET_SUBNQN} \
            Nvme0n1

${SPDK_RPC} nvmf_subsystem_add_listener \
            ${NVMET_SUBNQN} \
            -t ${NVMET_TRTYPE} \
            -a ${NVMET_IP} \
            -s ${NVMET_PORT} \
            -f ${NVMET_ADRFAM}
