From: Andrei Warkentin <andreiw@motorola.com>
Subject: [RFC 5/5] MMC: Toshiba eMMC - Split 8K-unaligned accesses.
Date: Wed,  9 Mar 2011 18:54:09 -0600
Message-ID: <1299718449-15172-6-git-send-email-andreiw@motorola.com>
References: <1299718449-15172-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og113.obsmtp.com ([64.18.0.26]:60764 "EHLO
	exprod5og113.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab1CJAKq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Mar 2011 19:10:46 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2A0B2YB009659
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 19:11:02 -0500 (EST)
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com [209.85.213.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2A0AjEa009594
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 19:11:02 -0500 (EST)
Received: by mail-yw0-f42.google.com with SMTP id 1so766091ywh.15
        for <linux-mmc@vger.kernel.org>; Wed, 09 Mar 2011 16:10:44 -0800 (PST)
In-Reply-To: <1299718449-15172-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>

These cards show abysmal write performance when
writes < 12K that are 8K unaligned cross an 8K barrier.

Change-Id: I3b015a93ae21d077b447e7d6fbe81255dbd2b0df
Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/Kconfig |    9 +++++++++
 drivers/mmc/card/block.c |   20 ++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
index 86948f9..1a9e4aa 100644
--- a/drivers/mmc/card/Kconfig
+++ b/drivers/mmc/card/Kconfig
@@ -14,6 +14,15 @@ config MMC_BLOCK
 	  mount the filesystem. Almost everyone wishing MMC support
 	  should say Y or M here.
 
+config MMC_BLOCK_QUIRK_TOSHIBA_32NM
+       tristate "Toshiba MMC 32nm technology flash device quirks"
+       depends on MMC_BLOCK
+       default n
+       help
+         Say Y if you have a Toshiba 32nm technology flash device,
+	 such as MMC32G or MMC16G eMMCs. This enables a performance
+	 improvement for flash page unaligned writes.
+
 config MMC_BLOCK_BOUNCE
 	bool "Use bounce buffer for simple hosts"
 	depends on MMC_BLOCK
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index a8f18c7..5250748 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -729,8 +729,28 @@ mmc_blk_set_blksize(struct mmc_blk_data *md, struct mmc_card *card)
 	return 0;
 }
 
+#ifdef CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_32NM
+static void toshiba_32nm_fixup(struct mmc_card *card, int data)
+{
+	struct mmc_blk_data *md = mmc_get_drvdata(card);
+	printk(KERN_INFO "Applying Toshiba 32nm workarounds\n");
+
+	/* Page size 8K, this card doesn't like unaligned writes
+	   across 8K boundary. */
+	md->write_align_size = 8192;
+
+	/* Doing the alignment for accesses > 12K seems to
+	   result in decreased perf. */
+	md->write_align_limit = 12288;
+}
+#endif /* CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_32NM */
+
 static const struct mmc_fixup blk_fixups[] =
 {
+#ifdef CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_32NM
+	MMC_FIXUP("MMC16G", 0x11, 0x0, toshiba_32nm_fixup, 0),
+	MMC_FIXUP("MMC32G", 0x11, 0x0100, toshiba_32nm_fixup, 0),
+#endif /* CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_32NM */
 	END_FIXUP
 };
 
-- 
1.7.0.4

