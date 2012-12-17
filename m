From: Heiko Schocher <hs@denx.de>
Subject: [PATCH][RFC] mmc, sd: do not read switch, if the host do not support high speed
Date: Mon, 17 Dec 2012 08:27:42 +0100
Message-ID: <1355729262-21269-1-git-send-email-hs@denx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:39245 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab2LQH1t (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Dec 2012 02:27:49 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Heiko Schocher <hs@denx.de>, Wolfgang Denk <wd@denx.de>, Dieter Schaffner <Dieter.Schaffner@ids.de>, linuxppc-dev@lists.ozlabs.org

If the host controller do not support high speed, do not send the
read switch CMD 6. Same as done in mmc_sd_switch_hs().

Signed-off-by: Heiko Schocher <hs@denx.de>
Cc: Wolfgang Denk <wd@denx.de>
Cc: Dieter Schaffner <Dieter.Schaffner@ids.de>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-mmc@vger.kernel.org

---
 drivers/mmc/core/sd.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

Found this on a MPC8313 based system with mmc over spi and a Transcend
2 GB SD card running a 2.6.37.6 kernel. Without this patch I get this
when reading the CMD6:

mmc1: starting CMD6 arg 00fffff1 flags 000000b5
mmc1:     blksz 64 blocks 1 flags 00000200 tsac 100 ms nsac 0
mmc_spi spi1.2:   mmc_spi: CMD6, resp R1
mmc_spi spi1.2:     mmc_spi: read block, 64 bytes
mmc_spi spi1.2: read error ffffff92 (-110)
mmc_spi spi1.2: read status -110
mmc1: req done (CMD6): 0: 00000000 00000000 00000000 00000000
mmc1:     0 bytes transferred: -110

Adding for example a longer timeout for the CMD6 did not helped.

With this patch the transcend card gets detected and can be used
fine. Here the infos from the card, shown in the sysfs:

-bash-3.2# cat /sys/bus/mmc/devices/mmc0\:0000/cid 
1b534d3030303030100bc3874c00c10b
-bash-3.2# cat /sys/bus/mmc/devices/mmc0\:0000/csd 
007fff325b5a83baf6dbdfff0e8000b5
-bash-3.2# cat /sys/bus/mmc/devices/mmc0\:0000/date 
01/2012
-bash-3.2# cat /sys/bus/mmc/devices/mmc0\:0000/erase_size 
512
-bash-3.2# cat /sys/bus/mmc/devices/mmc0\:0000/fwrev      
0x0
-bash-3.2# cat /sys/bus/mmc/devices/mmc0\:0000/hwrev 
0x1
-bash-3.2# cat /sys/bus/mmc/devices/mmc0\:0000/manfid 
0x00001b
-bash-3.2# cat /sys/bus/mmc/devices/mmc0\:0000/name   
00000
-bash-3.2# cat /sys/bus/mmc/devices/mmc0\:0000/oemid 
0x534d
-bash-3.2# cat /sys/bus/mmc/devices/mmc0\:0000/preferred_erase_size 
4194304
-bash-3.2# cat /sys/bus/mmc/devices/mmc0\:0000/scr                  
0225800000000000
-bash-3.2# cat /sys/bus/mmc/devices/mmc0\:0000/serial 
0x0bc3874c
-bash-3.2# cat /sys/bus/mmc/devices/mmc0\:0000/type 
SD

So the question raises, is this a known bug and/or a valid patch?
Other patches known to help here?

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 49da4df..3142df0 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -268,6 +268,10 @@ static int mmc_read_switch(struct mmc_card *card)
 		return 0;
 	}
 
+	/* no need, if the host do not support high speed */
+	if (!(card->host->caps & MMC_CAP_SD_HIGHSPEED))
+		return 0;
+
 	err = -EIO;
 
 	status = kmalloc(64, GFP_KERNEL);
-- 
1.7.7.6

