From: Kyungmin Park <kmpark@infradead.org>
Subject: [PATCH v2] SDHCI: add no hi-speed bit quirk support
Date: Tue, 17 Aug 2010 13:24:53 +0900
Message-ID: <20100817042453.GA21321@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:13839 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938Ab0HQEZA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Aug 2010 00:25:00 -0400
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L7A002DE49NL010@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 17 Aug 2010 13:24:59 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L7A00JU849NNO@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 17 Aug 2010 13:24:59 +0900 (KST)
Content-disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, akpm@linux-foundation.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Some SDHCI controller like s5pc110 doesn't have HISPD bit at HOSTCTL register.
Also fix the sdhci-s3c build since SDHCI_QUIRK_NO_HISPD_BIT defined at there.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7855121..87ab234 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1180,7 +1180,8 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		ctrl &= ~SDHCI_CTRL_4BITBUS;
 
-	if (ios->timing == MMC_TIMING_SD_HS)
+	if (ios->timing == MMC_TIMING_SD_HS &&
+	    !(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
 		ctrl |= SDHCI_CTRL_HISPD;
 	else
 		ctrl &= ~SDHCI_CTRL_HISPD;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 036cfae..d316bc7 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -245,6 +245,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_MISSING_CAPS			(1<<27)
 /* Controller uses Auto CMD12 command to stop the transfer */
 #define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<28)
+/* Controller doesn't have HISPD bit field in HI-SPEED SD card */
+#define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
