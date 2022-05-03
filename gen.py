#!/usr/bin/env python3

from math import degrees, radians, sin
import sys
import time

if __name__ == "__main__":

    num = int(sys.argv[1])
    if len(sys.argv) > 2:
        device = sys.argv[2]
    else:
        device = "device1"

    print ("\"time\",\"device_id\",\"temperature\"")

    start = int(time.time()) - num

    for i in range(num):
        now = start + i
        value = sin(radians(now)) * 100

        tm = time.gmtime(now)

        print ('%04d-%02d-%02d %02d:%02d:%02d,"%s",%f' % (tm.tm_year, tm.tm_mon, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec, device, value) )
