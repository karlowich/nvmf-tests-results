#!/usr/bin/env bash

# Change IP to match target
NVMET_IP="192.168.4.43"
NVMET_PORT="4420"

xnvme-driver

fio --name="mellanox-write" --rw="randwrite" --size="1G" --iodepth="16" --bs="4k" --direct="1" --thread="1" --allow_file_create="0" --ioengine="xnvme" --xnvme_be="spdk" --xnvme_dev_nsid="1" --filename="${NVMET_IP}\:${NVMET_PORT}" --output-format="normal,json" --output="mellanox-write.txt"
