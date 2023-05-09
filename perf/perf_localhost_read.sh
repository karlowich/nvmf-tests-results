#!/usr/bin/env bash

NVMET_IP="127.0.0.1"
NVMET_PORT="4420"

perf record --call-graph dwarf fio --name="perf-localhost-read" --rw="randread" --size="1G" --iodepth="16" --bs="4k" --direct="1" --thread="1" --allow_file_create="0" --debug="all" --ioengine="xnvme" --xnvme_be="spdk" --xnvme_dev_nsid="1" --filename="${NVMET_IP}\:${NVMET_PORT}" --output-format="normal,json" --output="perf-localhost-read.txt"

