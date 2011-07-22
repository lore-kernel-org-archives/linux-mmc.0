From: Roy Zang <tie-fei.zang@freescale.com>
Subject: [PATCH 1/2 v2] eSDHC: Access Freescale eSDHC registers by 32-bit
Date: Fri, 22 Jul 2011 18:15:16 +0800
Message-ID: <1311329717-13954-1-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:28145
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753523Ab1GVJf5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jul 2011 05:35:57 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, cbouatmailru@gmail.com, akpm@linux-foundation.org, Xu lei <B33228@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>, Kumar Gala <galak@kernel.crashing.org>

From: Xu lei <B33228@freescale.com>

For Freescale eSDHC registers only support 32-bit accesses,
this patch ensure that all Freescale eSDHC register accesses
are 32-bit.

Signed-off-by: Xu lei <B33228@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
this patch set replaces previous patches:
https://patchwork.kernel.org/patch/943332/
https://patchwork.kernel.org/patch/943342/
https://patchwork.kernel.org/patch/943322/

The last one is discarded according to the comment from Anton.


just resend with the new patch set. no change for this patch comparing
to previous version.

 drivers/mmc/host/sdhci-of-esdhc.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index ba40d6d..c9a8519 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1,7 +1,7 @@
 /*
  * Freescale eSDHC controller driver.
  *
- * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ * Copyright (c) 2007, 2010 Freescale Semiconductor, Inc.
  * Copyright (c) 2009 MontaVista Software, Inc.
  *
  * Authors: Xiaobo Xie <X.Xie@freescale.com>
@@ -23,11 +23,21 @@
 static u16 esdhc_readw(struct sdhci_host *host, int reg)
 {
 	u16 ret;
+	int base = reg & ~0x3;
+	int shift = (reg & 0x2) * 8;
 
 	if (unlikely(reg == SDHCI_HOST_VERSION))
-		ret = in_be16(host->ioaddr + reg);
+		ret = in_be32(host->ioaddr + base) & 0xffff;
 	else
-		ret = sdhci_be32bs_readw(host, reg);
+		ret = (in_be32(host->ioaddr + base) >> shift) & 0xffff;
+	return ret;
+}
+
+static u8 esdhc_readb(struct sdhci_host *host, int reg)
+{
+	int base = reg & ~0x3;
+	int shift = (reg & 0x3) * 8;
+	u8 ret = (in_be32(host->ioaddr + base) >> shift) & 0xff;
 	return ret;
 }
 
@@ -79,7 +89,7 @@ struct sdhci_of_data sdhci_esdhc = {
 	.ops = {
 		.read_l = sdhci_be32bs_readl,
 		.read_w = esdhc_readw,
-		.read_b = sdhci_be32bs_readb,
+		.read_b = esdhc_readb,
 		.write_l = sdhci_be32bs_writel,
 		.write_w = esdhc_writew,
 		.write_b = esdhc_writeb,
-- 
1.6.0.6


