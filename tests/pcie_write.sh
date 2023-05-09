#!/usr/bin/env bash

# Change pcie_id to match device
NVMET_PCIE_ID="0000\:01\:00.0"

xnvme-driver

fio --name="pcie-write" --rw="randwrite" --size="1G" --iodepth="16" --bs="4k" --direct="1" --thread="1" --allow_file_create="0" --ioengine="xnvme" --xnvme_be="spdk" --xnvme_dev_nsid="1" --filename=${NVMET_PCIE_ID} --output-format="normal,json" --output="pcie-write.txt"


