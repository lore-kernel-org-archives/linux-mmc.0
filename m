From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: sdhci-pxa.c enable CAP support for cards marked
 permanent
Date: Fri, 22 Apr 2011 13:17:59 -0700
Message-ID: <C9816D50-7A48-4A2E-BECA-F461C7AAF176@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:44509 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756240Ab1DVUU4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Apr 2011 16:20:56 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Zhangfei Gao <zgao6@marvell.com>


eMMC and Wifi cards that are fixed to the board are marked
permanent in the developemnt board files (eg brownstone.c for mmp2)

The platform specific code nows informs the mmc layer about this.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci-pxa.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index ec70d14..c8abf0f 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -131,6 +131,11 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
 	if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
 		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
 
+	if (pdata->flags & PXA_FLAG_CARD_PERMANENT) {
+		host->mmc->caps |= MMC_CAP_NONREMOVABLE;
+		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+	}
+
 	/* do not rely on u-boot to enable the clocks */
 	enable_clock(host);
 
-- 
1.7.0.4


