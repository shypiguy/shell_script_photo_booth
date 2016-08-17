#/bin/sh


#MIT License

#Copyright (c) 2016 Bill Jones

#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:

#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.

#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.


suffix1="_1.jpg"
suffix2="_2.jpg"
suffix3="_3.jpg"
suffixc="_canvas.jpg"
prefix=$1
filename1=${prefix}$suffix1
filename2=${prefix}$suffix2
filename3=${prefix}$suffix3
filenamec=${prefix}$suffixc
convert_count=$(ps -f | grep convert | grep -v grep | wc -l)
while [ $convert_count -gt 1 ]
do
  sleep 10
  convert_count=$(ps -f | grep convert | grep -v grep | wc -l)
done
convert -size 1311x2055 xc:white \
logo.jpg -geometry +1027+0 -composite \
${filename1} -geometry 955X637+36+36 -composite \
${filename2} -geometry 955x637+36+709 -composite \
${filename3} -geometry 955x637+36+1382 -composite \
${filenamec}
rm ${filename1}
rm ${filename2}
rm ${filename3}
./dropbox_uploader.sh upload ${filenamec} ${filenamec}
