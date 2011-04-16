From: Andrei Warkentin <andreiw@motorola.com>
Subject: [patchv3 4/5] MMC: Block CMD23 support for UHS104/SDXC cards.
Date: Sat, 16 Apr 2011 05:40:57 -0500
Message-ID: <1302950458-1969-5-git-send-email-andreiw@motorola.com>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og114.obsmtp.com ([64.18.0.28]:40306 "EHLO
	exprod5og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758928Ab1DPKCo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Apr 2011 06:02:44 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3GA36bJ006195
	for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 06:03:06 -0400 (EDT)
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com [209.85.213.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3GA339E006178
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 06:03:06 -0400 (EDT)
Received: by mail-yw0-f42.google.com with SMTP id 1so1629744ywh.15
        for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 03:02:42 -0700 (PDT)
In-Reply-To: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: arindam.nath@amd.com, Andrei Warkentin <andreiw@motorola.com>, cjb@laptop.org, arnd@arndb.de

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
index 4b1a58e..23da6e6 100644
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
index c758181..b33186a 100644
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

