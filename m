From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 3/5] sdhci: sdhci-pxa.c enable CAP support for cards marked
 permanent
Date: Sun, 13 Feb 2011 23:00:01 -0800
Message-ID: <661A4182-B064-4C75-A590-16FED7ACE220@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:46560 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751594Ab1BNHDu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:03:50 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


eMMC and Wifi cards that are fixed to the board are marked
permanent in the developemnt board files (eg brownstone.c for mmp2)

The platform specific code nows informs the mmc layer about this.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci-pxa.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 8c60d5c..c42d326 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -128,6 +128,11 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
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


