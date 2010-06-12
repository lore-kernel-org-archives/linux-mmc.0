From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH 3/3] SDHCI: 8-bit data transfer width support
Date: Sat, 12 Jun 2010 14:45:02 +0900
Message-ID: <20100612054502.GA25686@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:34819 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab0FLFpK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Jun 2010 01:45:10 -0400
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L3V00GZCZZ9SH60@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 12 Jun 2010 14:45:09 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L3V003UDZZ9IJ@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 12 Jun 2010 14:45:09 +0900 (KST)
Content-disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, akpm@linux-foundation.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Some host constroller such as s5pc110 has WIDE8 support feature.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci.c |    5 +++++
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 142419c..6cf018a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1159,6 +1159,11 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 
+	if (ios->bus_width == MMC_BUS_WIDTH_8)
+		ctrl |= SDHCI_CTRL_8BITBUS;
+	else
+		ctrl &= ~SDHCI_CTRL_8BITBUS;
+
 	if (ios->bus_width == MMC_BUS_WIDTH_4)
 		ctrl |= SDHCI_CTRL_4BITBUS;
 	else
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c846813..eb5efe0 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -72,6 +72,7 @@
 #define   SDHCI_CTRL_ADMA1	0x08
 #define   SDHCI_CTRL_ADMA32	0x10
 #define   SDHCI_CTRL_ADMA64	0x18
+#define  SDHCI_CTRL_8BITBUS	0x20
 
 #define SDHCI_POWER_CONTROL	0x29
 #define  SDHCI_POWER_ON		0x01
-- 
1.5.3.3

