#!/usr/bin/env bash

NVMET_IP="127.0.0.1"
NVMET_PORT="4420"

fio --name="baseline-localhost-write" --rw="randwrite" --size="1G" --iodepth="16" --bs="4k" --direct="1" --thread="1" --allow_file_create="0" --ioengine="xnvme" --xnvme_be="spdk" --xnvme_dev_nsid="1" --filename="${NVMET_IP}\:${NVMET_PORT}" --output-format="normal,json" --output="baseline-4k-localhost-write.txt"

