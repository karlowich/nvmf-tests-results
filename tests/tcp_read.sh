#!/usr/bin/env bash

# Change IP to match target
NVMET_IP="106.110.32.97"
NVMET_PORT="4420"

xnvme-driver

fio --name="tcp-read" --rw="randread" --size="1G" --iodepth="16" --bs="4k" --direct="1" --thread="1" --allow_file_create="0" --ioengine="xnvme" --xnvme_be="spdk" --xnvme_dev_nsid="1" --filename="${NVMET_IP}\:${NVMET_PORT}" --output-format="normal,json" --output="tcp-read.txt"
