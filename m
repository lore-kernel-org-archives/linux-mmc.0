From: Franz <flash86@gmx.at>
Subject: mmc_spi broken?
Date: Sat, 23 Apr 2016 10:37:05 +0200
Message-ID: <1461400625.27953.5.camel@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:56395 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798AbcDWIhU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 23 Apr 2016 04:37:20 -0400
Received: from debianServer ([77.117.64.198]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MVeCF-1bDzAR1LPb-00Z2g8 for
 <linux-mmc@vger.kernel.org>; Sat, 23 Apr 2016 10:37:16 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

I am trying to get an SD Card to work via SPI interface. I am using a
RaspberryPI Compute Module with kernel Version 4.4, but I can't get it
to work properly. I've tried it with the native spi interface as well as
with the spi aux interface and also with a gpio bitbang spi interface.
It's always the same error:
 
[ 2639.558282] mmc1: new SD card on SPI
[ 2639.566325] mmcblk1: mmc1:0000 SD256 243 MiB 
[ 2639.646120]  mmcblk1: p1 < >
[ 2639.833759] mmcblk1: error -38 sending status command, retrying
[ 2639.839973] mmcblk1: error -38 sending status command, retrying
[ 2639.846170] mmcblk1: error -38 sending status command, aborting
[ 2639.853406] mmc1: SPI card removed
[ 2640.240223] mmc1: host does not support reading read-only switch,
assuming write-enable
[ 2640.248328] mmc1: new SD card on SPI
[ 2640.256373] mmcblk1: mmc1:0000 SD256 243 MiB 
[ 2640.336068]  mmcblk1: p1 < >
[ 2640.523545] mmcblk1: error -38 sending status command, retrying
[ 2640.529757] mmcblk1: error -38 sending status command, retrying
[ 2640.535893] mmcblk1: error -38 sending status command, aborting
[ 2640.543129] mmc1: SPI card removed
[ 2640.930176] mmc1: host does not support reading read-only switch,
assuming write-enable
[ 2640.938313] mmc1: new SD card on SPI
[ 2640.946679] mmcblk1: mmc1:0000 SD256 243 MiB 
[ 2641.026395]  mmcblk1: p1 < >
[ 2641.213996] mmcblk1: error -38 sending status command, retrying
[ 2641.220208] mmcblk1: error -38 sending status command, retrying
[ 2641.226344] mmcblk1: error -38 sending status command, aborting
[ 2641.233435] mmc1: SPI card removed
[ 2641.620177] mmc1: host does not support reading read-only switch,
assuming write-enable
[ 2641.628277] mmc1: new SD card on SPI
[ 2641.636530] mmcblk1: mmc1:0000 SD256 243 MiB 
[ 2641.716114]  mmcblk1: p1 < >
[ 2641.903636] mmcblk1: error -38 sending status command, retrying
[ 2641.909852] mmcblk1: error -38 sending status command, retrying
[ 2641.915987] mmcblk1: error -38 sending status command, aborting
[ 2641.923056] mmc1: SPI card removed
 
I don't have any RO or CD pins configured, just plain SPI interface
directly to the SD Card. I've tried it with different SD cards with
differen capacities. It's always the same error. The above messages
appear in a endless loop.The last time I've used the mmc_spi driver was
kernel 3.8 I think with this version everything worked without any
problems.  Does anyone know how to fix this?
 
Thanks,
Franz
 

