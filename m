From: Andrei Warkentin <andreiw@motorola.com>
Subject: [RFC 3/3] MMC: Toshiba eMMC - Split 8K-unaligned accesses.
Date: Tue,  1 Mar 2011 16:09:04 -0600
Message-ID: <1299017344-25361-4-git-send-email-andreiw@motorola.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og103.obsmtp.com ([64.18.0.145]:43167 "EHLO
	exprod5og103.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755828Ab1CAV7V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2011 16:59:21 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p21LOv9t021456
	for <linux-mmc@vger.kernel.org>; Tue, 1 Mar 2011 16:24:57 -0500 (EST)
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com [209.85.161.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p21LOJbv021260
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 1 Mar 2011 16:24:56 -0500 (EST)
Received: by mail-gx0-f170.google.com with SMTP id 1so769968gxk.15
        for <linux-mmc@vger.kernel.org>; Tue, 01 Mar 2011 13:24:41 -0800 (PST)
In-Reply-To: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>

These cards show abysmal write performance when an
8K unaligned write crosses an 8K barrier. This is
the manufacturer recommendation.

Change-Id: I527fc44ff968f7ead61328bf655515fdf27b9f48
Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/Kconfig        |    7 +++++++
 drivers/mmc/card/block-quirks.c |   30 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
index 063fa16..6d9f391 100644
--- a/drivers/mmc/card/Kconfig
+++ b/drivers/mmc/card/Kconfig
@@ -21,6 +21,13 @@ config MMC_BLOCK_QUIRKS
        help
          Say Y here to enable various workarounds for known cards.
 
+config MMC_BLOCK_QUIRK_TOSHIBA_MMC32G
+       tristate "Toshiba MMC32G quirks"
+       depends on MMC_BLOCK_QUIRKS
+       default n
+       help
+         Say Y if you have a Toshiba MMC32G eMMC card.
+
 config MMC_BLOCK_BOUNCE
 	bool "Use bounce buffer for simple hosts"
 	depends on MMC_BLOCK
diff --git a/drivers/mmc/card/block-quirks.c b/drivers/mmc/card/block-quirks.c
index ceae70c..8aea551 100644
--- a/drivers/mmc/card/block-quirks.c
+++ b/drivers/mmc/card/block-quirks.c
@@ -109,3 +109,33 @@ int mmc_blk_quirk_register(struct mmc_blk_quirk *quirk, bool is_mmc)
 	rb_insert_color(&quirk->rb_node, &quirk_tree[!is_mmc]);
 	return 0;
 }
+
+#ifdef CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_MMC32G
+static int toshiba_mmc32g(struct mmc_blk_data *md, struct mmc_card *card)
+{
+	printk(KERN_INFO "Applying Toshiba MMC32G workarounds\n");
+
+	/* Page size 8K, this card doesn't like unaligned writes
+	   across 8K boundary. */
+	md->write_align_size = 8192;
+	return 0;
+}
+
+static struct mmc_blk_quirk toshiba_mmc32g_q = {
+	.name = "MMC32G",
+	.manfid = 0x11,
+	.oemid = 0x0100,
+
+	/* Any date, any revision, */
+	.rev_start = 0,
+	.rev_end = (u64) -1,
+	.probe = toshiba_mmc32g
+};
+
+int __init mmc_toshiba_quirks(void)
+{
+	return mmc_blk_quirk_register(&toshiba_mmc32g_q, true);
+}
+
+device_initcall(mmc_toshiba_quirks);
+#endif /* CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_MMC32G */
-- 
1.7.0.4

