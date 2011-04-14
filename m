From: Andrei Warkentin <andreiw@motorola.com>
Subject: [RFC 3/3] MMC: Block CMD23 support for UHS104/SDXC cards.
Date: Wed, 13 Apr 2011 19:38:43 -0500
Message-ID: <1302741523-22276-4-git-send-email-andreiw@motorola.com>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og115.obsmtp.com ([64.18.0.246]:36432 "EHLO
	exprod5og115.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818Ab1DNAAF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2011 20:00:05 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3E00Sgi019571
	for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2011 20:00:28 -0400 (EDT)
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com [209.85.161.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3E00Pxn019544
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2011 20:00:27 -0400 (EDT)
Received: by mail-gx0-f170.google.com with SMTP id 27so815542gxk.15
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2011 17:00:03 -0700 (PDT)
In-Reply-To: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: arnd@arndb.de, cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>

SD cards operating at UHS104 or better support SET_BLOCK_COUNT.

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/block.c |    9 ++++++---
 drivers/mmc/core/sd.c    |    1 +
 include/linux/mmc/card.h |    1 +
 include/linux/mmc/sd.h   |    1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 282e6ef..6573e36 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -846,9 +846,12 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
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
index 72a9868..337a851 100644
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

