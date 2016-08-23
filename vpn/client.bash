#!/usr/bin/env bash

if [ $# -eq 0 ]
  then
    echo "Arguments: client remoteip "
    return -2
    exit -2
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

outdir=`pwd`
echo "out dir $outdir"

target=$1
echo "name: $target"

remote=$2
echo "remote: $remote"

dstdir=$DIR/openvpn

# where are the keys stored
srcdir=$DIR/../../src_vpn_keys/keys

# clean up
rm -rf $dstdir
rm -rf $dstdir/openvpn.tar.gz

# make new data
mkdir $dstdir

# server keys
cp $DIR/client_openvpn.conf $dstdir/openvpn.conf
echo "remote $remote" >> $dstdir/openvpn.conf

cp $srcdir/ta.key $dstdir
cp $srcdir/ca.crt $dstdir

echo "getting server certificate  $srcdir/$target.crt"
cp $srcdir/$target.crt $dstdir/client.crt
echo "getting server key  $srcdir/$target.key"
cp $srcdir/$target.key $dstdir/client.key

# we need to tar in a way that files will uncompress
# in the current directory (this is done by docker)
pushd .
cd $dstdir
tar -zcvf $outdir/openvpn-client.tar.gz *
echo "removing $dstdir"
rm -rf $dstdir
popd

