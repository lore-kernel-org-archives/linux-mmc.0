From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH 2/3] SDHCI: Don't assign mmc->caps at SDHCI directly
Date: Sat, 12 Jun 2010 14:44:50 +0900
Message-ID: <20100612054450.GA25682@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:34748 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab0FLFo7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Jun 2010 01:44:59 -0400
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L3V00BRSZYXOD70@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 12 Jun 2010 14:44:57 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L3V00IMPZYXHD@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 12 Jun 2010 14:44:57 +0900 (KST)
Content-disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, akpm@linux-foundation.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Some host controller can set mmc->caps before sdhci_add_host.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4321e0c..142419c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1791,7 +1791,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	else
 		mmc->f_min = host->max_clk / 256;
 	mmc->f_max = host->max_clk;
-	mmc->caps = MMC_CAP_SDIO_IRQ;
+	mmc->caps |= MMC_CAP_SDIO_IRQ;
 
 	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
-- 
1.5.3.3

