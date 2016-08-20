#!/usr/bin/env bash

if [ $# -eq 0 ]
  then
    echo "Arguments: server-key"
    return -2
    # in case we're still running...
    exit -2
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

outdir=`pwd`
echo "out dir $outdir"

target=$1
echo "name: $target"
dstdir=$DIR/openvpn

# where are the keys stored
srcdir=$DIR/../../src_vpn_keys/keys

# clean up
rm -rf $dstdir
rm -rf $dstdir/openvpn.tar.gz

# make new data
mkdir $dstdir

# server keys
cp $DIR/server_openvpn.conf $dstdir/openvpn.conf
cp $srcdir/ta.key $dstdir
cp $srcdir/ca.crt $dstdir
cp $srcdir/ca.key $dstdir
cp $srcdir/dh2048.pem $dstdir

echo "getting server certificate  $srcdir/$target.crt"
cp $srcdir/$target.crt $dstdir/server.crt
echo "getting server key  $srcdir/$target.key"
cp $srcdir/$target.key $dstdir/server.key

# we need to tar in a way that files will uncompress
# in the current directory (this is expected by docker)
pushd .
cd $dstdir
tar -zcvf $outdir/server_vpn.tar.gz *
echo "removing $dstdir"
rm -rf $dstdir
popd


