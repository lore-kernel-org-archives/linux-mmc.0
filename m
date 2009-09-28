From: Ohad Ben-Cohen <ohad@bencohen.org>
Subject: [PATCH] sdio: add MMC_CAP_VDD_165_195 host capability
Date: Mon, 28 Sep 2009 19:55:34 +0200
Message-ID: <1254160534.31101.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:55994 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbZI1RrX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Sep 2009 13:47:23 -0400
Received: by bwz6 with SMTP id 6so1443959bwz.37
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2009 10:47:26 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: ian@mnementh.co.uk, matt@console-pimps.org, pierre@ossman.eu, roberto.foglietta@gmail.com, david.vrabel@csr.com, linux-mmc@vger.kernel.org

[resending due to mailer issues - sorry]
---
From: Ohad Ben-Cohen <ohad@wizery.com>

To allow the usage of MMC_VDD_165_195, host capability
MMC_CAP_VDD_165_195 is introduced. This is necessary
because MMC_VDD_165_195 is currently reserved/undefined.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/mmc/core/sdio.c  |    7 +++++++
 include/linux/mmc/host.h |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index cdb845b..a9f3ed6 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -494,6 +494,13 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
 		ocr &= ~0x7F;
 	}
 
+	if ((ocr & MMC_VDD_165_195) && !(host->caps & MMC_CAP_VDD_165_195)) {
+		printk(KERN_WARNING "%s: SDIO card claims to support the "
+			"incompletely defined 'low voltage range'. This "
+			"will be ignored.\n", mmc_hostname(host));
+		ocr &= ~MMC_VDD_165_195;
+	}
+
 	host->ocr = mmc_select_voltage(host, ocr);
 
 	/*
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 81bb423..5fa95b3 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -150,6 +150,7 @@ struct mmc_host {
 #define MMC_CAP_DISABLE		(1 << 7)	/* Can the host be disabled */
 #define MMC_CAP_NONREMOVABLE	(1 << 8)	/* Nonremovable e.g. eMMC */
 #define MMC_CAP_WAIT_WHILE_BUSY	(1 << 9)	/* Waits while card is busy */
+#define MMC_CAP_VDD_165_195	(1 << 10)	/* Accepts MMC_VDD_165_195 */
 
 	/* host specific block data */
 	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
-- 
1.5.4.3



