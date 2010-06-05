From: Kyungmin Park <kmpark@infradead.org>
Subject: [PATCH] s5pc110: SDHCI-s3c support on s5pc110
Date: Sat, 05 Jun 2010 12:46:05 +0900
Message-ID: <20100605034605.GA23576@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:33674 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757358Ab0FEDqN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Jun 2010 23:46:13 -0400
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L3I000E8VSZDQ80@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 05 Jun 2010 12:46:11 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L3I00MAIVSZK1@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 05 Jun 2010 12:46:11 +0900 (KST)
Content-disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, akpm@linux-foundation.org, ben-linux@fluff.org

s5pc110 (aka s5pv210) uses the same SDHCI IP.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e171e77..acf5bf6 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -123,7 +123,7 @@ config MMC_SDHCI_PLTFM
 
 config MMC_SDHCI_S3C
 	tristate "SDHCI support on Samsung S3C SoC"
-	depends on MMC_SDHCI && (PLAT_S3C24XX || PLAT_S3C64XX)
+	depends on MMC_SDHCI && PLAT_SAMSUNG
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  often referrered to as the HSMMC block in some of the Samsung S3C
