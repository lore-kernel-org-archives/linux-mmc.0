From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH v4 12/15] sdhci pxa add platform specific code for UHS signaling
Date: Thu,  5 May 2011 12:19:08 +0530
Message-ID: <1304578151-1775-13-git-send-email-arindam.nath@amd.com>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f173.google.com ([209.85.212.173]:62422 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab1EEGxC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 May 2011 02:53:02 -0400
Received: by pxi16 with SMTP id 16so1439619pxi.4
        for <linux-mmc@vger.kernel.org>; Wed, 04 May 2011 23:53:02 -0700 (PDT)
In-Reply-To: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: prakity@marvell.com, zhangfei.gao@gmail.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

Marvell controller requires 1.8V bit in UHS control register 2
be set when doing UHS.  eMMC does not require 1.8V for DDR.
add platform code to handle this.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Reviewed-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/host/sdhci-pxa.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 5a61208..b52c3e6 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -69,7 +69,40 @@ static void set_clock(struct sdhci_host *host, unsigned int clock)
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
+	} else if (uhs == MMC_TIMING_UHS_SDR104) {
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
+		ctrl_2 |= SDHCI_CTRL_VDD_180;
+	} else if (uhs == MMC_TIMING_UHS_DDR50) {
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
 	.set_clock = set_clock,
 };
 
@@ -141,6 +174,9 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
 	if (pdata->quirks)
 		host->quirks |= pdata->quirks;
 
+	/* enable 1/8V DDR capable */
+	host->mmc->caps |= MMC_CAP_1_8V_DDR;
+
 	/* If slot design supports 8 bit data, indicate this to MMC. */
 	if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
 		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
-- 
1.7.1

