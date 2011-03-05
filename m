From: Andrei Warkentin <andreiw@motorola.com>
Subject: [[RFC] 3/5] MMC: Toshiba eMMC - Split 8K-unaligned accesses.
Date: Fri,  4 Mar 2011 21:21:12 -0600
Message-ID: <1299295274-32130-4-git-send-email-andreiw@motorola.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
 <1299295274-32130-1-git-send-email-andreiw@motorola.com>
 <1299295274-32130-2-git-send-email-andreiw@motorola.com>
 <1299295274-32130-3-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og103.obsmtp.com ([64.18.0.145]:44647 "EHLO
	exprod5og103.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079Ab1CEChP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2011 21:37:15 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p252ZwwQ010485
	for <linux-mmc@vger.kernel.org>; Fri, 4 Mar 2011 21:35:58 -0500 (EST)
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com [209.85.161.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p252ZhWn010460
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 4 Mar 2011 21:35:58 -0500 (EST)
Received: by mail-gx0-f170.google.com with SMTP id 1so1651605gxk.15
        for <linux-mmc@vger.kernel.org>; Fri, 04 Mar 2011 18:37:13 -0800 (PST)
In-Reply-To: <1299295274-32130-3-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>

These cards show abysmal write performance when
writes < 12K that are 8K unaligned cross an 8K barrier.

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/Kconfig        |    8 ++++++++
 drivers/mmc/card/block-quirks.c |   22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
index 063fa16..af2800e 100644
--- a/drivers/mmc/card/Kconfig
+++ b/drivers/mmc/card/Kconfig
@@ -21,6 +21,14 @@ config MMC_BLOCK_QUIRKS
        help
          Say Y here to enable various workarounds for known cards.
 
+config MMC_BLOCK_QUIRK_TOSHIBA_32NM
+       tristate "Toshiba MMC 32nm technology flash device quirks"
+       depends on MMC_BLOCK_QUIRKS
+       default n
+       help
+         Say Y if you have a Toshiba 32nm technology flash device,
+	 such as MMC32G or MMC16G eMMCs.
+
 config MMC_BLOCK_BOUNCE
 	bool "Use bounce buffer for simple hosts"
 	depends on MMC_BLOCK
diff --git a/drivers/mmc/card/block-quirks.c b/drivers/mmc/card/block-quirks.c
index e122a74..c142ffb 100644
--- a/drivers/mmc/card/block-quirks.c
+++ b/drivers/mmc/card/block-quirks.c
@@ -15,6 +15,23 @@
 #include "queue.h"
 #include "blk.h"
 
+#ifdef CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_32NM
+static int toshiba_32nm_probe(struct mmc_blk_data *md, struct mmc_card *card)
+{
+	printk(KERN_INFO "Applying Toshiba 32nm workarounds\n");
+
+	/* Page size 8K, this card doesn't like unaligned writes
+	   across 8K boundary. */
+	md->write_align_size = 8192;
+
+	/* Doing the alignment for accesses > 12K seems to
+	   result in decreased perf. */
+	md->write_align_limit = 12288;
+	return 0;
+}
+#endif /* CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_32NM */
+
+
 /*
    Caveat: Because this list is just looked up with a linear
    search, take care that either overlapping revision ranges
@@ -22,6 +39,10 @@
    a given revision has the desired effect.
 */
 struct mmc_blk_quirk mmc_blk_quirks[] = {
+#ifdef CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_32NM
+        MMC_BLK_QUIRK("MMC16G", 0x11, 0x0, toshiba_32nm_probe),
+        MMC_BLK_QUIRK("MMC32G", 0x11, 0x0100, toshiba_32nm_probe),
+#endif /* CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_32NM */
 };
 
 static int mmc_blk_quirk_cmp(const struct mmc_blk_quirk *quirk,
@@ -49,3 +70,4 @@ struct mmc_blk_quirk *mmc_blk_quirk_find(struct mmc_card *card)
 
 	return NULL;
 }
+
-- 
1.7.0.4

