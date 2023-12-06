#!/bin/bash

mkdir testdir
mkdir testdir/{files,images,songs}
mkdir -p testdir/dir1/dir2/dir3

touch testdir/files/file{1..5}.txt
touch testdir/images/image{1..5}.jpg
touch testdir/songs/song{1..5}.mp3
touch testdir/dir1/dir2/dir3/.hiddenfile{1..5}


cd testdir
dd if=/dev/random of=test.img bs=1M count=1 status=progress
tar -czvf docs.tar.gz files/
tar -czvf images.tar.gz images/
tar -czvf songs.tar.gz songs/

tar -tf docs.tar.gz
tar -tf images.tar.gz

cd ..
ls -l testdir/*/
find testdir/
tree testdir/

echo
echo "rm -rf testdir/"
