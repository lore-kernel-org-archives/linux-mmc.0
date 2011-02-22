From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v3] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Tue, 22 Feb 2011 19:50:46 +0800
Message-ID: <20110222115045.GB19871@S2100-06.ap.freescale.net>
References: <1298284528-14761-1-git-send-email-shawn.guo@freescale.com>
 <20110221174016.GN2616@pengutronix.de>
 <20110222085256.GA19871@S2100-06.ap.freescale.net>
 <20110222103349.GA2755@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:3999
	"EHLO DB3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754130Ab1BVLvU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 06:51:20 -0500
Received: from mail19-db3 (localhost.localdomain [127.0.0.1])	by
 mail19-db3-R.bigfish.com (Postfix) with ESMTP id 6D59CBC82A6	for
 <linux-mmc@vger.kernel.org>; Tue, 22 Feb 2011 11:51:17 +0000 (UTC)
Received: from DB3EHSMHS004.bigfish.com (unknown [10.3.81.243])	by
 mail19-db3.bigfish.com (Postfix) with ESMTP id 86335C0051	for
 <linux-mmc@vger.kernel.org>; Tue, 22 Feb 2011 11:51:16 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
 [10.64.34.199])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
 p1MBp8M6016554	for <linux-mmc@vger.kernel.org>; Tue, 22 Feb 2011 04:51:13
 -0700 (MST)
Received: from S2100-06.ap.freescale.net (S2100-06.ap.freescale.net
 [10.192.242.50])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 p1MBp7wo026575	for <linux-mmc@vger.kernel.org>; Tue, 22 Feb 2011 05:51:08
 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20110222103349.GA2755@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, arnd@arndb.de

On Tue, Feb 22, 2011 at 11:33:49AM +0100, Wolfram Sang wrote:
> 
> > > What throughput rates do you get on a mx28-regulated slot serving a card
> > > at 50Mhz? This is poor here (55kb/s) while it is OK at 25Mhz. Could be a
> > 
> > To make sure we are on the same test, can you share the test case
> > you ran to get the result?  So that I can run it here for the result
> > on my board.
> 
> # mount -t vfat /dev/mmcblk0p1 /mnt
> # dd if=/mnt/test.dat of=/tmp/a bs=1024
> # umount /mnt
> # ./dd --version
> dd (coreutils) 8.5
> ...
> 
> 'test.dat' was a 8MB file of random data on a 4GB SDHC card
> (extrememory) on a slot powered by the mx28. Operating the card at
> 50Mhz, dd will report ~55 kb/s. If I add 'rate /= 2;' to the beginning
> of set_clk_rate, so it will operate at 25Mhz, I have 8mb/s.
> 
My busybox version of dd does not report the speed.  But I tried to
dd 8MB data and saw it's done in 1~2 seconds.

Also here is mmc host driver test performance related result on my
board if you are interested.

mmc0: Test case 23. Best-case read performance...
mmc0: Transfer of 6630 sectors (3315 KiB) took 0.101999209 seconds (33280 kB/s,
32500 KiB/s)
mmc0: Result: OK
mmc0: Test case 24. Best-case write performance...
mmc0: Transfer of 6630 sectors (3315 KiB) took 0.388688317 seconds (8733 kB/s, 8
528 KiB/s)
mmc0: Result: OK
mmc0: Test case 25. Best-case read performance into scattered pages...
mmc0: Transfer of 416 sectors (208 KiB) took 0.006997933 seconds (30436 kB/s, 29
723 KiB/s)
mmc0: Result: OK
mmc0: Test case 26. Best-case write performance from scattered pages...
mmc0: Transfer of 416 sectors (208 KiB) took 0.020431605 seconds (10424 kB/s, 10
180 KiB/s)
mmc0: Result: OK
mmc0: Test case 27. Single read performance by transfer size...
mmc0: Transfer of 1 sectors (0.5 KiB) took 0.000906524 seconds (564 kB/s, 551 Ki
B/s)
mmc0: Transfer of 2 sectors (1 KiB) took 0.000625190 seconds (1637 kB/s, 1599 Ki
B/s)
mmc0: Transfer of 4 sectors (2 KiB) took 0.000687706 seconds (2978 kB/s, 2908 Ki
B/s)
mmc0: Transfer of 8 sectors (4 KiB) took 0.000718959 seconds (5697 kB/s, 5563 Ki
B/s)
mmc0: Transfer of 16 sectors (8 KiB) took 0.000812729 seconds (10079 kB/s, 9843
KiB/s)
mmc0: Transfer of 32 sectors (16 KiB) took 0.001094051 seconds (14975 kB/s, 1462
4 KiB/s)
mmc0: Transfer of 64 sectors (32 KiB) took 0.001625434 seconds (20159 kB/s, 1968
7 KiB/s)
mmc0: Transfer of 128 sectors (64 KiB) took 0.002594421 seconds (25260 kB/s, 246
68 KiB/s)
mmc0: Transfer of 256 sectors (128 KiB) took 0.004563644 seconds (28720 kB/s, 28
047 KiB/s)
mmc0: Transfer of 512 sectors (256 KiB) took 0.008439521 seconds (31061 kB/s, 30
333 KiB/s)
mmc0: Transfer of 1024 sectors (512 KiB) took 0.016253622 seconds (32256 kB/s, 3
1500 KiB/s)
mmc0: Transfer of 2048 sectors (1024 KiB) took 0.031886943 seconds (32884 kB/s,
32113 KiB/s)
mmc0: Transfer of 4096 sectors (2048 KiB) took 0.063176177 seconds (33195 kB/s,
32417 KiB/s)
mmc0: Transfer of 6630 sectors (3315 KiB) took 0.101735514 seconds (33366 kB/s,
32584 KiB/s)
mmc0: Result: OK
mmc0: Test case 28. Single write performance by transfer size...
mmc0: Transfer of 1 sectors (0.5 KiB) took 0.001781476 seconds (287 kB/s, 280 Ki
B/s)
mmc0: Transfer of 2 sectors (1 KiB) took 0.002250249 seconds (455 kB/s, 444 KiB/
s)
mmc0: Transfer of 4 sectors (2 KiB) took 0.002312719 seconds (885 kB/s, 864 KiB/
s)
mmc0: Transfer of 8 sectors (4 KiB) took 0.003437771 seconds (1191 kB/s, 1163 Ki
B/s)
mmc0: Transfer of 16 sectors (8 KiB) took 0.002718920 seconds (3012 kB/s, 2942 K
iB/s)
mmc0: Transfer of 32 sectors (16 KiB) took 0.001500142 seconds (10921 kB/s, 1066
5 KiB/s)
mmc0: Transfer of 64 sectors (32 KiB) took 0.003875336 seconds (8455 kB/s, 8257
KiB/s)
mmc0: Transfer of 128 sectors (64 KiB) took 0.006250472 seconds (10484 kB/s, 102
39 KiB/s)
mmc0: Transfer of 256 sectors (128 KiB) took 0.011563288 seconds (11335 kB/s, 11
069 KiB/s)
mmc0: Transfer of 512 sectors (256 KiB) took 0.022187432 seconds (11814 kB/s, 11
538 KiB/s)
mmc0: Transfer of 1024 sectors (512 KiB) took 0.049155884 seconds (10665 kB/s, 1
0415 KiB/s)
mmc0: Transfer of 2048 sectors (1024 KiB) took 0.085375335 seconds (12281 kB/s,
11994 KiB/s)
mmc0: Transfer of 4096 sectors (2048 KiB) took 0.262563987 seconds (7987 kB/s, 7
800 KiB/s)
mmc0: Transfer of 6630 sectors (3315 KiB) took 0.284787038 seconds (11919 kB/s,
11640 KiB/s)
mmc0: Result: OK
mmc0: Test case 29. Single trim performance by transfer size...
mmc0: Result: UNSUPPORTED (by card)
mmc0: Test case 30. Consecutive read performance by transfer size...
mmc0: Transfer of 8192 x 1 sectors (8192 x 0.5 KiB) took 4.091141441 seconds (10
25 kB/s, 1001 KiB/s)
mmc0: Transfer of 4096 x 2 sectors (4096 x 1 KiB) took 2.490875000 seconds (1683
 kB/s, 1644 KiB/s)
mmc0: Transfer of 2048 x 4 sectors (2048 x 2 KiB) took 1.316531250 seconds (3185
 kB/s, 3111 KiB/s)
mmc0: Transfer of 1024 x 8 sectors (1024 x 4 KiB) took 0.727437500 seconds (5765
 kB/s, 5630 KiB/s)
mmc0: Transfer of 512 x 16 sectors (512 x 8 KiB) took 0.437000000 seconds (9597
kB/s, 9372 KiB/s)
mmc0: Transfer of 256 x 32 sectors (256 x 16 KiB) took 0.283156250 seconds (1481
2 kB/s, 14465 KiB/s)
mmc0: Transfer of 128 x 64 sectors (128 x 32 KiB) took 0.205812500 seconds (2037
9 kB/s, 19901 KiB/s)
mmc0: Transfer of 64 x 128 sectors (64 x 64 KiB) took 0.165750000 seconds (25305
 kB/s, 24711 KiB/s)
mmc0: Transfer of 32 x 256 sectors (32 x 128 KiB) took 0.145343750 seconds (2885
7 kB/s, 28181 KiB/s)
mmc0: Transfer of 16 x 512 sectors (16 x 256 KiB) took 0.134968750 seconds (3107
6 kB/s, 30347 KiB/s)
mmc0: Transfer of 8 x 1024 sectors (8 x 512 KiB) took 0.130125000 seconds (32232
 kB/s, 31477 KiB/s)
mmc0: Transfer of 4 x 2048 sectors (4 x 1024 KiB) took 0.127531249 seconds (3288
8 kB/s, 32117 KiB/s)
mmc0: Transfer of 2 x 4096 sectors (2 x 2048 KiB) took 0.126343751 seconds (3319
7 kB/s, 32419 KiB/s)
mmc0: Transfer of 1 x 6630 sectors (1 x 3315 KiB) took 0.101687494 seconds (3338
2 kB/s, 32599 KiB/s)
mmc0: Result: OK
mmc0: Test case 31. Consecutive write performance by transfer size...
mmc0: Transfer of 8192 x 1 sectors (8192 x 0.5 KiB) took 14.309562500 seconds (2
93 kB/s, 286 KiB/s)
mmc0: Transfer of 4096 x 2 sectors (4096 x 1 KiB) took 9.871062499 seconds (424
kB/s, 414 KiB/s)
mmc0: Transfer of 2048 x 4 sectors (2048 x 2 KiB) took 4.814593750 seconds (871
kB/s, 850 KiB/s)
mmc0: Transfer of 1024 x 8 sectors (1024 x 4 KiB) took 2.296875000 seconds (1826
 kB/s, 1783 KiB/s)
mmc0: Transfer of 512 x 16 sectors (512 x 8 KiB) took 1.072843750 seconds (3909
kB/s, 3817 KiB/s)
mmc0: Transfer of 256 x 32 sectors (256 x 16 KiB) took 0.596312500 seconds (7033
 kB/s, 6868 KiB/s)
mmc0: Transfer of 128 x 64 sectors (128 x 32 KiB) took 0.455375000 seconds (9210
 kB/s, 8994 KiB/s)
mmc0: Transfer of 64 x 128 sectors (64 x 64 KiB) took 0.402875000 seconds (10410
 kB/s, 10166 KiB/s)
mmc0: Transfer of 32 x 256 sectors (32 x 128 KiB) took 0.375531250 seconds (1116
8 kB/s, 10907 KiB/s)
mmc0: Transfer of 16 x 512 sectors (16 x 256 KiB) took 0.362562500 seconds (1156
8 kB/s, 11297 KiB/s)
mmc0: Transfer of 8 x 1024 sectors (8 x 512 KiB) took 0.350500000 seconds (11966
 kB/s, 11686 KiB/s)
mmc0: Transfer of 4 x 2048 sectors (4 x 1024 KiB) took 0.351593796 seconds (1192
9 kB/s, 11649 KiB/s)
mmc0: Transfer of 2 x 4096 sectors (2 x 2048 KiB) took 0.346812955 seconds (1209
3 kB/s, 11810 KiB/s)
mmc0: Transfer of 1 x 6630 sectors (1 x 3315 KiB) took 0.280838757 seconds (1208
7 kB/s, 11803 KiB/s)
mmc0: Result: OK
mmc0: Test case 32. Consecutive trim performance by transfer size...
mmc0: Result: UNSUPPORTED (by card)
mmc0: Tests completed.

-- 
Regards,
Shawn

