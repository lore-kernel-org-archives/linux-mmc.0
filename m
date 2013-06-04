From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Hynix eMMC RPMB: Access timeouts, broken?
Date: Tue, 4 Jun 2013 13:32:15 +0200
Message-ID: <51ADD03F.5030407@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from imta22.fe.bosch.de ([139.15.243.26]:10885 "EHLO
	imta22.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044Ab3FDLlg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jun 2013 07:41:36 -0400
Received: from smtp6-v.fe.bosch.de (imta23.fe.bosch.de [139.15.243.227])
	by imta22.fe.bosch.de (Postfix) with ESMTP id BCBA5840301
	for <linux-mmc@vger.kernel.org>; Tue,  4 Jun 2013 13:33:06 +0200 (CEST)
Received: from vsmta12.fe.internet.bosch.com (unknown [10.4.98.52])
	by imta23.fe.bosch.de (Postfix) with ESMTP id 9608E158020A
	for <linux-mmc@vger.kernel.org>; Tue,  4 Jun 2013 13:32:19 +0200 (CEST)
Received: from localhost (vsgw4.fe.internet.bosch.com [10.4.98.12])
	by vsmta12.fe.internet.bosch.com (Postfix) with SMTP id 327FC1B80870
	for <linux-mmc@vger.kernel.org>; Tue,  4 Jun 2013 13:31:48 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Using some recent Hynix eMMC devices [1] on our Freescale i.MX6 boards 
we get harmless (?), but annoying access timeouts accessing the RPMB 
partition:

mmcblk1rpmb: error -110 transferring data, sector 0, nr 32, cmd response 
0x900, card status 0xb00
mmcblk1rpmb: retrying using single block read
...

The output with MMC debug enabled below [2].

This seems to be harmless because it stops, but is annoying due to some 
auto mounter trying to access all available partitions.

Any idea about this issue?

Or any hint how to further debug this?

It seems to us that this doesn't happen with some older Hynix devices, 
because it just appeared recently with the HW guys switching to a new eMMC.

We think we have all RPMB related patches, including [3]. But maybe we 
missed anything?

Best regards

Dirk

[1]

mmc1: new high speed MMC card at address 0001
mmcblk1: mmc1:0001 H4G1d 3.64 GiB
mmcblk1boot0: mmc1:0001 H4G1d partition 1 4.00 MiB
mmcblk1boot1: mmc1:0001 H4G1d partition 2 4.00 MiB
mmcblk1rpmb: mmc1:0001 H4G1d partition 3 4.00 MiB
  mmcblk1: p1
  mmcblk1boot1: unknown partition table
  mmcblk1boot0: unknown partition table

(below dd is the manual test case simulating the auto mounter access 
mentioned above)

 > dd if=/dev/mmcblk1rpmb of=/dev/null bs=1 count=1
[  124.185513] mmcblk1rpmb: error -110 transferring data, sector 0, nr 
32, cmd response 0x900, card status 0xb00
[  124.195506] mmcblk1rpmb: retrying using single block read
[  124.201035] mmcblk1rpmb: timed out sending r/w cmd command, card 
status 0x400900
[  124.208559] mmcblk1rpmb: timed out sending r/w cmd command, card 
status 0x400900
[  124.216049] mmcblk1rpmb: timed out sending r/w cmd command, card 
status 0x400900
[  124.223567] mmcblk1rpmb: timed out sending r/w cmd command, card 
status 0x400900
[  124.231087] mmcblk1rpmb: timed out sending r/w cmd command, card 
status 0x400900
[  124.238600] mmcblk1rpmb: timed out sending r/w cmd command, card 
status 0x400900
[  124.246012] end_request: I/O error, dev mmcblk1rpmb, sector 0
[  124.251773] Buffer I/O error on device mmcblk1rpmb, logical block 0
[  124.258065] end_request: I/O error, dev mmcblk1rpmb, sector 8
[  124.263822] Buffer I/O error on device mmcblk1rpmb, logical block 1
[  124.270102] end_request: I/O error, dev mmcblk1rpmb, sector 16
[  124.275944] Buffer I/O error on device mmcblk1rpmb, logical block 2
[  124.282222] end_request: I/O error, dev mmcblk1rpmb, sector 24
[  124.288064] Buffer I/O error on device mmcblk1rpmb, logical block 3
[  129.717711] mmcblk1rpmb: error -110 transferring data, sector 0, nr 
8, cmd response 0x900, card status 0xb00
[  129.727590] mmcblk1rpmb: retrying using single block read
[  129.733088] mmcblk1rpmb: timed out sending r/w cmd command, card 
status 0x400900
[  129.740605] mmcblk1rpmb: timed out sending r/w cmd command, card 
status 0x400900
[  129.748121] mmcblk1rpmb: timed out sending r/w cmd command, card 
status 0x400900
[  129.755612] mmcblk1rpmb: timed out sending r/w cmd command, card 
status 0x400900
[  129.763125] mmcblk1rpmb: timed out sending r/w cmd command, card 
status 0x400900
[  129.770639] mmcblk1rpmb: timed out sending r/w cmd command, card 
status 0x400900
[  129.778073] end_request: I/O error, dev mmcblk1rpmb, sector 0
[  129.783834] Buffer I/O error on device mmcblk1rpmb, logical block 0
dd: /dev/mmcblk1rpmb: Input/output error


[2] (mmc0 is the SD card we are booting from)

 > dd if=/dev/mmcblk1rpmb of=/dev/null bs=1 count=1
<mmc1: starting CMD23 arg 00000020 flags 00000015>
mmc1: starting CMD18 arg 00000000 flags 000000b5
mmc1:     blksz 512 blocks 32 flags 00000200 tsac 150 ms nsac 1000
mmc1:     CMD12 arg 00000000 flags 0000049d
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc0: starting CMD25 arg 003440d8 flags 000000b5
mmc0:     blksz 512 blocks 40 flags 00000100 tsac 3000 ms nsac 0
mmc0:     CMD12 arg 00000000 flags 0000049d
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000a
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x1c220000, transferred 
0x060000 bytes, next 0x1c280000
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
mmc0:     20480 bytes transferred: 0
mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
mmc0: starting CMD13 arg 12340000 flags 00000195
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
mmc0: starting CMD25 arg 00344100 flags 000000b5
mmc0:     blksz 512 blocks 8 flags 00000100 tsac 3000 ms nsac 0
mmc0:     CMD12 arg 00000000 flags 0000049d
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000a
sdhci [sdhci_data_irq()]: mmc0: DMA base 0x1c220000, transferred 
0x060000 bytes, next 0x1c280000
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
mmc0:     4096 bytes transferred: 0
mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
mmc0: starting CMD13 arg 12340000 flags 00000195
sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00100000
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD18): 0: 00000900 00000000 00000000 00000000
mmc1:     0 bytes transferred: -110
mmc1:     (CMD12): 0: 00000b00 00000000 00000000 00000000
mmc1: starting CMD13 arg 00010000 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD13): 0: 00000900 00000000 00000000 00000000
mmcblk1rpmb: error -110 transferring data, sector 0, nr 32, cmd response 
0x900, card status 0xb00
mmcblk1rpmb: retrying using single block read
mmc1: starting CMD17 arg 00000000 flags 000000b5
mmc1:     blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
mmc1: req done (CMD17): -110: 00000000 00000000 00000000 00000000
mmc1:     0 bytes transferred: 0
mmc1: starting CMD13 arg 00010000 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD13): 0: 00400900 00000000 00000000 00000000
mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
mmc1: starting CMD17 arg 00000000 flags 000000b5
mmc1:     blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
mmc1: req done (CMD17): -110: 00000000 00000000 00000000 00000000
mmc1:     0 bytes transferred: 0
mmc1: starting CMD13 arg 00010000 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD13): 0: 00400900 00000000 00000000 00000000
mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
mmc1: starting CMD17 arg 00000000 flags 000000b5
mmc1:     blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
mmc1: req done (CMD17): -110: 00000000 00000000 00000000 00000000
mmc1:     0 bytes transferred: 0
mmc1: starting CMD13 arg 00010000 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD13): 0: 00400900 00000000 00000000 00000000
mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
mmc1: starting CMD17 arg 00000000 flags 000000b5
mmc1:     blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
mmc1: req done (CMD17): -110: 00000000 00000000 00000000 00000000
mmc1:     0 bytes transferred: 0
mmc1: starting CMD13 arg 00010000 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD13): 0: 00400900 00000000 00000000 00000000
mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
mmc1: starting CMD17 arg 00000000 flags 000000b5
mmc1:     blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
mmc1: req done (CMD17): -110: 00000000 00000000 00000000 00000000
mmc1:     0 bytes transferred: 0
mmc1: starting CMD13 arg 00010000 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD13): 0: 00400900 00000000 00000000 00000000
mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
mmc1: starting CMD17 arg 00000000 flags 000000b5
mmc1:     blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
mmc1: req done (CMD17): -110: 00000000 00000000 00000000 00000000
mmc1:     0 bytes transferred: 0
mmc1: starting CMD13 arg 00010000 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD13): 0: 00400900 00000000 00000000 00000000
mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
end_request: I/O error, dev mmcblk1rpmb, sector 0
Buffer I/O error on device mmcblk1rpmb, logical block 0
end_request: I/O error, dev mmcblk1rpmb, sector 8
Buffer I/O error on device mmcblk1rpmb, logical block 1
end_request: I/O error, dev mmcblk1rpmb, sector 16
Buffer I/O error on device mmcblk1rpmb, logical block 2
end_request: I/O error, dev mmcblk1rpmb, sector 24
Buffer I/O error on device mmcblk1rpmb, logical block 3
<mmc1: starting CMD23 arg 00000008 flags 00000015>
mmc1: starting CMD18 arg 00000000 flags 000000b5
mmc1:     blksz 512 blocks 8 flags 00000200 tsac 150 ms nsac 1000
mmc1:     CMD12 arg 00000000 flags 0000049d
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00100000
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD18): 0: 00000900 00000000 00000000 00000000
mmc1:     0 bytes transferred: -110
mmc1:     (CMD12): 0: 00000b00 00000000 00000000 00000000
mmc1: starting CMD13 arg 00010000 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD13): 0: 00000900 00000000 00000000 00000000
mmcblk1rpmb: error -110 transferring data, sector 0, nr 8, cmd response 
0x900, card status 0xb00
mmcblk1rpmb: retrying using single block read
mmc1: starting CMD17 arg 00000000 flags 000000b5
mmc1:     blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
mmc1: req done (CMD17): -110: 00000000 00000000 00000000 00000000
mmc1:     0 bytes transferred: 0
mmc1: starting CMD13 arg 00010000 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD13): 0: 00400900 00000000 00000000 00000000
mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
mmc1: starting CMD17 arg 00000000 flags 000000b5
mmc1:     blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
mmc1: req done (CMD17): -110: 00000000 00000000 00000000 00000000
mmc1:     0 bytes transferred: 0
mmc1: starting CMD13 arg 00010000 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD13): 0: 00400900 00000000 00000000 00000000
mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
mmc1: starting CMD17 arg 00000000 flags 000000b5
mmc1:     blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
mmc1: req done (CMD17): -110: 00000000 00000000 00000000 00000000
mmc1:     0 bytes transferred: 0
mmc1: starting CMD13 arg 00010000 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD13): 0: 00400900 00000000 00000000 00000000
mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
mmc1: starting CMD17 arg 00000000 flags 000000b5
mmc1:     blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
mmc1: req done (CMD17): -110: 00000000 00000000 00000000 00000000
mmc1:     0 bytes transferred: 0
mmc1: starting CMD13 arg 00010000 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD13): 0: 00400900 00000000 00000000 00000000
mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
mmc1: starting CMD17 arg 00000000 flags 000000b5
mmc1:     blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
mmc1: req done (CMD17): -110: 00000000 00000000 00000000 00000000
mmc1:     0 bytes transferred: 0
mmc1: starting CMD13 arg 00010000 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD13): 0: 00400900 00000000 00000000 00000000
mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
mmc1: starting CMD17 arg 00000000 flags 000000b5
mmc1:     blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00010000
mmc1: req done (CMD17): -110: 00000000 00000000 00000000 00000000
mmc1:     0 bytes transferred: 0
mmc1: starting CMD13 arg 00010000 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD13): 0: 00400900 00000000 00000000 00000000
mmcblk1rpmb: timed out sending r/w cmd command, card status 0x400900
end_request: I/O error, dev mmcblk1rpmb, sector 0
Buffer I/O error on device mmcblk1rpmb, logical block 0
dd: /dev/mmcblk1rpmb: Input/output error
 >

[3] 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/core/mmc.c?id=d0123ccac55088811bde4f76c4a3fdbd39c3cfba
