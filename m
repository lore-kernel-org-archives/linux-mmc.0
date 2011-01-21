From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: enable CAP support for SD/eMMC/Wifi cards that are
 marked permanent
Date: Fri, 21 Jan 2011 11:29:37 -0800
Message-ID: <FC66E5C2-92C7-41CD-B5FB-6E51EB7FF9A0@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:46076 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754882Ab1AUTcO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Jan 2011 14:32:14 -0500
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
index 4c2a252..1a58c7b 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -136,6 +136,11 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
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


