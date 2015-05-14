From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Help with writing to micro SD card
Date: Thu, 14 May 2015 15:03:02 -0500
Message-ID: <5554FF76.2010206@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Benny Silberstein <bennys@benchmarkmerchantsolutions.com>, "peretz@benchmarkmerchantsolutions.com >> Peretz Mockin" <peretz@benchmarkmerchantsolutions.com>
List-Id: linux-mmc@vger.kernel.org

I am helping to get wifi and Bluetooth woring under Linux using a Winbook TW100 
tablet. The main goal is working quite well; however, I am only able to run 
using Live media. Whenever I try to load Linux onto either the internal SD card, 
or one mounted in the external slot, the process stalls with nothing logged.

I know the external card is OK as I can read or write it when it is mounted in 
my laptop.

When I received the tablet, I used dd to back up the internal card. When I used 
a block size of 4M in that operation, it also froze; however, the standard block 
size (512) worked. That suggests that the standard Linux r/w operations on the 
device are too fast.

What should I do to get some debug information? If my idea is correct, how might 
I slow down the I/O to the device?

Thanks,

Larry
