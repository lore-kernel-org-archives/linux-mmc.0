From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci-pxa: add platform specific code for UHS signaling
Date: Fri, 22 Apr 2011 13:25:45 -0700
Message-ID: <95F7D594-60D3-49AA-87DA-63B5970D9787@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:50368 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752128Ab1DVUZ5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Apr 2011 16:25:57 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Arindam Nath <arindam.nath@amd.com>


Marvell controller requires 1.8V bit in UHS control register 2
be set when doing UHS.  eMMC does not require 1.8V for DDR.
add platform code to handle this.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci-pxa.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 0e64d66..279d677 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -94,7 +94,42 @@ static void platform_reset_exit(struct sdhci_host *host, u8 mask)
 	}
 }
 
+static int set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
+{
+	u16 ctrl_2;
+
+	/*
+	 * Set V18_EN -- UHS modes do not work without this.
+	 * does not change signaling voltage
+	 */
+	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+		/* Select Bus Speed Mode for host */
+	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
+	if (uhs == MMC_TIMING_UHS_SDR12)
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
+	else if (uhs == MMC_TIMING_UHS_SDR25)
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
+	else if (uhs == MMC_TIMING_UHS_SDR50) {
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
+		ctrl_2 |= SDHCI_CTRL_VDD_180;
+	}
+	else if (uhs == MMC_TIMING_UHS_SDR104) {
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
+		ctrl_2 |= SDHCI_CTRL_VDD_180;
+	}
+	else if (uhs == MMC_TIMING_UHS_DDR50) {
+		ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
+		ctrl_2 |= SDHCI_CTRL_VDD_180;
+	}
+	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+	pr_debug("%s:%s uhs = %d, ctrl_2 = %04X\n",
+		__func__, mmc_hostname(host->mmc), uhs, ctrl_2);
+	return 0;
+}
+
 static struct sdhci_ops sdhci_pxa_ops = {
+	.set_uhs_signaling = set_uhs_signaling,
 	.platform_reset_exit = platform_reset_exit,
 };
 
@@ -172,6 +207,9 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
 	/* enable mmc bus width testing */
 	host->mmc->caps |= MMC_CAP_BUS_WIDTH_TEST;
 
+	/* enable 1/8V DDR capable */
+	host->mmc->caps |= MMC_CAP_1_8V_DDR;
+
 	/* If slot design supports 8 bit data, indicate this to MMC. */
 	if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
 		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
-- 
1.7.0.4


