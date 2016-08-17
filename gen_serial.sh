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



sudo echo 4 > /sys/class/gpio/export
sudo echo 17 > /sys/class/gpio/export
sudo echo 22 > /sys/class/gpio/export
sudo echo out > /sys/class/gpio/gpio4/direction
sudo echo in > /sys/class/gpio/gpio17/direction
sudo echo out > /sys/class/gpio/gpio22/direction

while true
do
  sudo echo 1 > /sys/class/gpio/gpio4/value
  input=$(cat /sys/class/gpio/gpio17/value)
  while [ ${input} -eq 0 ]
  do
    sleep .08
    input=$(cat /sys/class/gpio/gpio17/value)
  done
  sudo echo 0 > /sys/class/gpio/gpio4/value
  for blink in {1..3}
  do
    sudo echo 1 > /sys/class/gpio/gpio22/value
    sleep .5
    sudo echo 0 > /sys/class/gpio/gpio22/value
    sleep .5
  done
  sudo echo 1 > /sys/class/gpio/gpio22/value
  gphoto2 --capture-image -F 3 -I 3
  sudo echo 0 > /sys/class/gpio/gpio22/value
  root_num=$(date +"%s")
  sub_ex="_%n.jpg"
  file_format_string=${root_num}$sub_ex
  gphoto2 -p 1-3 --filename $file_format_string
  gphoto2 --folder '/DCIM/100EOS5D' --delete-file 1-3
  ./convert_serial.sh ${root_num} &
done

