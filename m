From: Roy Zang <tie-fei.zang@freescale.com>
Subject: [PATCH] eSDHC: Access Freescale eSDHC registers by 32-bit
Date: Fri, 9 Sep 2011 20:05:46 +0800
Message-ID: <1315569946-21386-1-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:36746
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933824Ab1IILXa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Sep 2011 07:23:30 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, cbouatmailru@gmail.com, Xu lei <B33228@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>, Kumar Gala <galak@kernel.crashing.org>

From: Xu lei <B33228@freescale.com>

Freescale eSDHC registers only support 32-bit accesses,
this patch ensures that all Freescale eSDHC register accesses
are 32-bit.

Signed-off-by: Xu lei <B33228@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
This is a patch resend 
http://patchwork.ozlabs.org/patch/106245/
based on latest Linus tree.

Andrew,
Could you help to  pick up this patch first?
Thanks.
Roy

 drivers/mmc/host/sdhci-of-esdhc.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index fe604df..40036f6 100644
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
@@ -22,11 +22,21 @@
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
 
@@ -74,7 +84,7 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = sdhci_be32bs_readl,
 	.read_w = esdhc_readw,
-	.read_b = sdhci_be32bs_readb,
+	.read_b = esdhc_readb,
 	.write_l = sdhci_be32bs_writel,
 	.write_w = esdhc_writew,
 	.write_b = esdhc_writeb,
-- 
1.6.0.6


