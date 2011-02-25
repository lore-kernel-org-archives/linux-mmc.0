From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/3] dw_mmc: set fixed burst in BMOD register
Date: Fri, 25 Feb 2011 11:08:13 +0900
Message-ID: <4D670F0D.8020102@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:54276 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756312Ab1BYCIl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Feb 2011 21:08:41 -0500
Received: from epmmp1 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LH5004URHXPPG20@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 25 Feb 2011 11:08:13 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LH500787HXPHU@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 25 Feb 2011 11:08:13 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: will.newton@imgtec.com, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

This patch is applied fixed burst.
If use internal DMA controller, i think that need to set this bit.

I tested when set this bit or not. I found that increase performance with IDMAC

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 58476c1..46e5a89 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -315,7 +315,7 @@ static void dw_mci_idmac_stop_dma(struct dw_mci *host)
 
 	/* Stop the IDMAC running */
 	temp = mci_readl(host, BMOD);
-	temp &= ~SDMMC_IDMAC_ENABLE;
+	temp &= ~(SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB);
 	mci_writel(host, BMOD, temp);
 }
 
@@ -384,7 +384,7 @@ static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
 
 	/* Enable the IDMAC */
 	temp = mci_readl(host, BMOD);
-	temp |= SDMMC_IDMAC_ENABLE;
+	temp |= SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB;
 	mci_writel(host, BMOD, temp);
 
 	/* Start it running */
