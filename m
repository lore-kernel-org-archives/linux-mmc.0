From: Kyungmin Park <kmpark@infradead.org>
Subject: [PATCH] SDHCI: add no hi-speed bit quirk support
Date: Sat, 05 Jun 2010 13:50:09 +0900
Message-ID: <20100605045009.GA25452@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:40688 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab0FEEuR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 5 Jun 2010 00:50:17 -0400
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L3I00LD2YRSWW90@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 05 Jun 2010 13:50:16 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L3I00DETYRSI9@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 05 Jun 2010 13:50:16 +0900 (KST)
Content-disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, akpm@linux-foundation.org

Some SDHCI controllr like s5pc110 doesn't have HISPD bit at HOSTCTL register.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c6d1bd8..cba08ce 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1164,7 +1164,8 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		ctrl &= ~SDHCI_CTRL_4BITBUS;
 
-	if (ios->timing == MMC_TIMING_SD_HS)
+	if (ios->timing == MMC_TIMING_SD_HS &&
+	    !(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
 		ctrl |= SDHCI_CTRL_HISPD;
 	else
 		ctrl &= ~SDHCI_CTRL_HISPD;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c846813..a78152d 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -240,6 +240,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
 /* Controller cannot support End Attribute in NOP ADMA descriptor */
 #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
+/* Controller doesn't have HISPD bit field in HI-SPEED SD card */
+#define SDHCI_QUIRK_NO_HISPD_BIT			(1<<27)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
