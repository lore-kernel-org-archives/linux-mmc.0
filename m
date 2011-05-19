From: Andrei Warkentin <andreiw@motorola.com>
Subject: [v5 4/5] MMC: Block CMD23 support for UHS104/SDXC cards.
Date: Thu, 19 May 2011 16:46:29 -0500
Message-ID: <1305841590-26963-5-git-send-email-andreiw@motorola.com>
References: <1303870235-29041-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og111.obsmtp.com ([64.18.0.22]:41815 "EHLO
	exprod5og111.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932627Ab1ESVMy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2011 17:12:54 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p4JLDMQn025057
	for <linux-mmc@vger.kernel.org>; Thu, 19 May 2011 17:13:22 -0400 (EDT)
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com [209.85.213.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p4JLDL7B025046
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 19 May 2011 17:13:22 -0400 (EDT)
Received: by yxi11 with SMTP id 11so1482203yxi.15
        for <linux-mmc@vger.kernel.org>; Thu, 19 May 2011 14:12:51 -0700 (PDT)
In-Reply-To: <1303870235-29041-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>, arindam.nath@amd.com, arnd@arndb.de, malchev@google.com

SD cards operating at UHS104 or better support SET_BLOCK_COUNT.

Cc: arindam.nath@amd.com
Cc: cjb@laptop.org
Cc: arnd@arndb.de
Cc: malchev@google.com
Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/block.c |    9 ++++++---
 drivers/mmc/core/sd.c    |    7 +++++++
 include/linux/mmc/card.h |    3 +++
 include/linux/mmc/sd.h   |    2 +-
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index a380acc..71da564 100755
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1057,9 +1057,12 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	blk_queue_logical_block_size(md->queue.queue, 512);
 	set_capacity(md->disk, size);
 
-	if (mmc_host_cmd23(card->host) &&
-	    mmc_card_mmc(card))
-		md->flags |= MMC_BLK_CMD23;
+	if (mmc_host_cmd23(card->host)) {
+		if (mmc_card_mmc(card) ||
+		    (mmc_card_sd(card) &&
+		     card->scr.cmds & SD_SCR_CMD23_SUPPORT))
+			md->flags |= MMC_BLK_CMD23;
+	}
 
 	if (mmc_card_mmc(card) &&
 	    md->flags & MMC_BLK_CMD23 &&
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 596d0b9..efff41d 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -203,6 +203,13 @@ static int mmc_decode_scr(struct mmc_card *card)
 	else
 		card->erased_byte = 0x0;
 
+	if (scr->sda_vsn == SCR_SPEC_VER_2) {
+
+		/* Check if Physical Layer Spec v3.0X is supported. */
+		scr->sda_spec3 = UNSTUFF_BITS(resp, 47, 1);
+		if (scr->sda_spec3)
+			scr->cmds = UNSTUFF_BITS(resp, 32, 2);
+	}
 	return 0;
 }
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 4a0e27b..c6927a4 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -72,6 +72,9 @@ struct sd_scr {
 	unsigned char		bus_widths;
 #define SD_SCR_BUS_WIDTH_1	(1<<0)
 #define SD_SCR_BUS_WIDTH_4	(1<<2)
+	unsigned char		cmds;
+#define SD_SCR_CMD20_SUPPORT   (1<<0)
+#define SD_SCR_CMD23_SUPPORT   (1<<1)
 };
 
 struct sd_ssr {
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index c648878..7d35d52 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -66,7 +66,7 @@
 
 #define SCR_SPEC_VER_0		0	/* Implements system specification 1.0 - 1.01 */
 #define SCR_SPEC_VER_1		1	/* Implements system specification 1.10 */
-#define SCR_SPEC_VER_2		2	/* Implements system specification 2.00 */
+#define SCR_SPEC_VER_2		2	/* Implements system specification 2.00-3.0X */
 
 /*
  * SD bus widths
-- 
1.7.0.4

