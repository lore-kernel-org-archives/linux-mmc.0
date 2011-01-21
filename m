From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: Enable BUS WIDTH testing for MMC/eMMC cards
Date: Fri, 21 Jan 2011 11:25:44 -0800
Message-ID: <162BA714-31AB-44B8-901A-5324E4F49F4C@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:36468 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753971Ab1AUT0e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Jan 2011 14:26:34 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


The PXA family of controllers (PXA168/PXA910/MMP2) support CMD14/CMD19
transactions that are used to test the MMC/eMMC bus width for 1, 4, or
8 bits.

Indicate to the mmc layer that it is safe to do bus width testing.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci-pxa.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index ed044a8..0afc763 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -121,6 +121,9 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
 	host->irq = irq;
 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+	/* enable mmc bus width testing */
+	host->mmc->caps |= MMC_CAP_BUS_WIDTH_TEST;
+
 	/* If slot design supports 8 bit data, indicate this to MMC. */
 	if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
 		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
-- 
1.7.0.4


