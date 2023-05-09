# Clone repos
git clone https://github.com/OpenMPDK/xNVMe.git xnvme
git clone https://github.com/spdk/spdk.git
git clone https://github.com/axboe/fio.git

# Checkout correct branch and build
pushd xnvme
git checkout v0.6.0
make && make install
popd

pushd spdk
git checkout v23.01
git submodule update --init
./configure
make
pushd app/nvmf_tgt
make
popd
popd

pushd fio
git checkout fio-3.34
./configure
make
make install
popd

