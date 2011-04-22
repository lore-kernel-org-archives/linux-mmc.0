From: Philip Rakity <prakity@marvell.com>
Subject: Subject: [PATCH] sdhci: sdhci-pxa.c: Enable BUS WIDTH testing for
 MMC/eMMC cards
Date: Fri, 22 Apr 2011 13:15:28 -0700
Message-ID: <3731BF72-B94E-43AA-82FF-46DF9B5E243C@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:41443 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756334Ab1DVUQ5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Apr 2011 16:16:57 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Zhangfei Gao <zgao6@marvell.com>

The PXA family of controllers (PXA168/PXA910/MMP2) support CMD14/CMD19
transactions that are used to test the MMC/eMMC bus width for 1, 4, or
8 bits.

Indicate to the mmc layer that it is safe to do bus width testing.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci-pxa.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 4713238..c6baf6c 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -132,6 +132,9 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
 	if (pdata->quirks)
 		host->quirks |= pdata->quirks;
 
+	/* enable mmc bus width testing */
+	host->mmc->caps |= MMC_CAP_BUS_WIDTH_TEST;
+
 	/* If slot design supports 8 bit data, indicate this to MMC. */
 	if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
 		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
-- 
1.7.0.4

