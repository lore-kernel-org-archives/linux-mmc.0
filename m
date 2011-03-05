From: Andrei Warkentin <andreiw@motorola.com>
Subject: [[RFC] 5/5] MMC: Toshiba eMMC - Part reliability improvement.
Date: Fri,  4 Mar 2011 21:21:14 -0600
Message-ID: <1299295274-32130-6-git-send-email-andreiw@motorola.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
 <1299295274-32130-1-git-send-email-andreiw@motorola.com>
 <1299295274-32130-2-git-send-email-andreiw@motorola.com>
 <1299295274-32130-3-git-send-email-andreiw@motorola.com>
 <1299295274-32130-4-git-send-email-andreiw@motorola.com>
 <1299295274-32130-5-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og115.obsmtp.com ([64.18.0.246]:40725 "EHLO
	exprod5og115.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab1CEChS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2011 21:37:18 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p252a1h6010502
	for <linux-mmc@vger.kernel.org>; Fri, 4 Mar 2011 21:36:01 -0500 (EST)
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com [209.85.160.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p252ZtnG010466
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 4 Mar 2011 21:36:00 -0500 (EST)
Received: by mail-gy0-f170.google.com with SMTP id 3so1679517gyf.15
        for <linux-mmc@vger.kernel.org>; Fri, 04 Mar 2011 18:37:16 -0800 (PST)
In-Reply-To: <1299295274-32130-5-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>

Split-up accesses into smaller chunks, to improve
lifespan, by using 8K reliable writes into 8K Buffer A,
instead of 4MB Buffer B, reducing number of 4MB write-erase
cycles. Upper and lower bounds should be experimentally
found to match the desired performance/reliability
characteristics.

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/Kconfig        |   31 ++++++++++++++++++++++++
 drivers/mmc/card/block-quirks.c |   50 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
index af2800e..5c2f090 100644
--- a/drivers/mmc/card/Kconfig
+++ b/drivers/mmc/card/Kconfig
@@ -29,6 +29,37 @@ config MMC_BLOCK_QUIRK_TOSHIBA_32NM
          Say Y if you have a Toshiba 32nm technology flash device,
 	 such as MMC32G or MMC16G eMMCs.
 
+config MMC_BLOCK_QUIRK_TOSHIBA_32NM_REL
+       tristate "Toshiba MMC 32nm reliability quirk"
+       depends on MMC_BLOCK_QUIRK_TOSHIBA_32NM
+       default n
+       help
+         Say Y if you want to enable the improved reliability workaround
+	 for your Toshiba 32nm parts. This will result in certain-sized
+	 writes to be split up into 8K chunks, to ensure they are placed
+	 in the smaller 8KB buffer instead of the 4MB buffer, which should
+	 reduce the number of flash write-erase cycles and improve
+	 reliability. By default accesses in the 24k-32k range are
+	 split.
+
+config MMC_BLOCK_QUIRK_TOSHIBA_32NM_REL_L
+       hex "Toshiba reliability lower bound (in blocks)"
+       depends on MMC_BLOCK_QUIRK_TOSHIBA_32NM_REL
+       default "30"
+       help
+         Accesses smaller than the lower bound will not be split.
+	 This value should be experimentally found to match load
+	 and performance characteristics.
+
+config MMC_BLOCK_QUIRK_TOSHIBA_32NM_REL_U
+       hex "Toshiba reliability upper bound (in blocks)"
+       depends on MMC_BLOCK_QUIRK_TOSHIBA_32NM_REL
+       default "40"
+       help
+         Accesses bigger than the upper bound will not be split.
+	 This value should be experimentally found to match load
+	 and performance characteristics.
+
 config MMC_BLOCK_BOUNCE
 	bool "Use bounce buffer for simple hosts"
 	depends on MMC_BLOCK
diff --git a/drivers/mmc/card/block-quirks.c b/drivers/mmc/card/block-quirks.c
index 4afa872..c918e12 100644
--- a/drivers/mmc/card/block-quirks.c
+++ b/drivers/mmc/card/block-quirks.c
@@ -9,8 +9,10 @@
  *
  */
 #include <linux/kernel.h>
+#include <linux/blkdev.h>
 #include <linux/semaphore.h>
 #include <linux/mmc/card.h>
+#include <linux/mmc/mmc.h>
 
 #include "queue.h"
 #include "blk.h"
@@ -19,6 +21,11 @@
 static int toshiba_32nm_probe(struct mmc_blk_data *md, struct mmc_card *card)
 {
 	printk(KERN_INFO "Applying Toshiba 32nm workarounds\n");
+#ifdef CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_32NM_REL
+	printk(KERN_INFO "Toshiba 32nm reliability splits over 0x%x-0x%x blocks\n",
+	       CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_32NM_REL_L,
+	       CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_32NM_REL_U);
+#endif
 
 	/* Page size 8K, this card doesn't like unaligned writes
 	   across 8K boundary. */
@@ -29,6 +36,43 @@ static int toshiba_32nm_probe(struct mmc_blk_data *md, struct mmc_card *card)
 	md->write_align_limit = 12288;
 	return 0;
 }
+
+#ifdef CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_32NM_REL
+static void toshiba_32nm_adjust(struct mmc_queue *mq,
+				struct request *req,
+				struct mmc_request *mrq)
+{
+
+	int err;
+	struct mmc_command cmd;
+	struct mmc_blk_data *md = mq->data;
+	struct mmc_card *card = md->queue.card;
+
+	if (rq_data_dir(req) != WRITE)
+		return;
+
+	if (blk_rq_sectors(req) > CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_32NM_REL_U ||
+	    blk_rq_sectors(req) < CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_32NM_REL_L)
+		return;
+
+	/* 8K chunks */
+	if (mrq->data->blocks > 16)
+		mrq->data->blocks = 16;
+
+	/*
+	  We know what the valid values for this card are,
+	  no need to check EXT_CSD_REL_WR_SEC_C.
+	 */
+	cmd.opcode = MMC_SET_BLOCK_COUNT | (1 << 31);
+	cmd.arg = mrq->data->blocks;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	err = mmc_wait_for_cmd(card->host, &cmd, 0);
+	if (!err)
+		mrq->stop = NULL;
+}
+#else
+#define toshiba_32nm_adjust NULL
+#endif /* CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_32NM_REL */
 #endif /* CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_32NM */
 
 /*
@@ -39,8 +83,10 @@ static int toshiba_32nm_probe(struct mmc_blk_data *md, struct mmc_card *card)
 */
 struct mmc_blk_quirk mmc_blk_quirks[] = {
 #ifdef CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_32NM
-        MMC_BLK_QUIRK("MMC16G", 0x11, 0x0, toshiba_32nm_probe, NULL),
-        MMC_BLK_QUIRK("MMC32G", 0x11, 0x0100, toshiba_32nm_probe, NULL),
+        MMC_BLK_QUIRK("MMC16G", 0x11, 0x0,
+		      toshiba_32nm_probe, toshiba_32nm_adjust),
+        MMC_BLK_QUIRK("MMC32G", 0x11, 0x0100,
+		      toshiba_32nm_probe, toshiba_32nm_adjust),
 #endif /* CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_32NM */
 };
 
-- 
1.7.0.4

