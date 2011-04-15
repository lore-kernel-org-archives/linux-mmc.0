From: Andrei Warkentin <andreiw@motorola.com>
Subject: [patchv2 3/3] MMC: Block CMD23 support for UHS104/SDXC cards.
Date: Fri, 15 Apr 2011 18:51:44 -0500
Message-ID: <1302911504-18287-3-git-send-email-andreiw@motorola.com>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og116.obsmtp.com ([64.18.0.147]:46955 "EHLO
	exprod5og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab1DOXNV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Apr 2011 19:13:21 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3FNBUb2016452
	for <linux-mmc@vger.kernel.org>; Fri, 15 Apr 2011 19:11:30 -0400 (EDT)
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3FNBT6p016444
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 15 Apr 2011 19:11:30 -0400 (EDT)
Received: by gwb17 with SMTP id 17so2195762gwb.15
        for <linux-mmc@vger.kernel.org>; Fri, 15 Apr 2011 16:13:19 -0700 (PDT)
In-Reply-To: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>, arindam.nath@amd.com, cjb@laptop.org, arnd@arndb.de

SD cards operating at UHS104 or better support SET_BLOCK_COUNT.

Cc: arindam.nath@amd.com
Cc: cjb@laptop.org
Cc: arnd@arndb.de
Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/block.c |    9 ++++++---
 drivers/mmc/core/sd.c    |    1 +
 include/linux/mmc/card.h |    1 +
 include/linux/mmc/sd.h   |    1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index bba0888..69b70ce 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -851,9 +851,12 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	blk_queue_logical_block_size(md->queue.queue, 512);
 	set_capacity(md->disk, size);
 
-	if (mmc_host_cmd23(card->host) &&
-	    mmc_card_mmc(card))
-		md->flags |= MMC_BLK_CMD23;
+	if (mmc_host_cmd23(card->host)) {
+		if (mmc_card_mmc(card) ||
+		    (mmc_card_sd(card) &&
+		     card->scr.cmds & SCR_CMDS_CMD23))
+			md->flags |= MMC_BLK_CMD23;
+	}
 
 	if (mmc_card_mmc(card) &&
 	    md->flags & MMC_BLK_CMD23 &&
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 6dac89f..16a1f10 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -195,6 +195,7 @@ static int mmc_decode_scr(struct mmc_card *card)
 	else
 		card->erased_byte = 0x0;
 
+	scr->cmds = UNSTUFF_BITS(resp, 32, 2);
 	return 0;
 }
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 1e6bd6c..c036a78 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -70,6 +70,7 @@ struct sd_scr {
 	unsigned char		bus_widths;
 #define SD_SCR_BUS_WIDTH_1	(1<<0)
 #define SD_SCR_BUS_WIDTH_4	(1<<2)
+	unsigned char		cmds;
 };
 
 struct sd_ssr {
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 3fd85e0..81ba37b 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -60,6 +60,7 @@
 #define SCR_SPEC_VER_0		0	/* Implements system specification 1.0 - 1.01 */
 #define SCR_SPEC_VER_1		1	/* Implements system specification 1.10 */
 #define SCR_SPEC_VER_2		2	/* Implements system specification 2.00 */
+#define SCR_CMDS_CMD23		(1 << 1) /* Supports CMD23 */
 
 /*
  * SD bus widths
-- 
1.7.0.4

