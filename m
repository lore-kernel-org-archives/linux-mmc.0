From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 2/2] sdhci: sdhci-pxa: add support for hardware clock gating
 callback
Date: Sun, 13 Feb 2011 23:22:58 -0800
Message-ID: <6EB22EE3-4A46-4059-98BE-5DC32AFC83A0@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:35018 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751367Ab1BNHYF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:24:05 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


enable controller caps to support h/w clock gating

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci-pxa.c |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 8527ac1..e736727 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -35,6 +35,7 @@
 #define SDCLK_DELAY_SHIFT    9
 #define SDCLK_SEL_SHIFT      8
 
+#define DISABLE_CLOCK_GATING 0
 
 struct sdhci_pxa {
 	struct sdhci_host		*host;
@@ -86,10 +87,25 @@ static void set_clock_and_burst_size(struct sdhci_host *host)
 	}
 }
 
+static void programFIFO(struct sdhci_host *host, int enable)
+{
+	unsigned short tmp;
+
+	tmp = readw(host->ioaddr + SDHCI_HOST_CONTROL_2);
+
+	if (enable)
+		tmp |= SDCTRL_2_ASYNC_INT_EN;
+	else
+		tmp &= ~SDCTRL_2_ASYNC_INT_EN;
+
+	writew(tmp, host->ioaddr + SDHCI_HOST_CONTROL_2);
+}
+
 static void platform_reset_exit(struct sdhci_host *host, u8 mask)
 {
 	if (mask == SDHCI_RESET_ALL) {
 		/* reset private registers */
+		programFIFO(host, DISABLE_CLOCK_GATING);
 		set_clock_and_burst_size(host);
 	}
 }
@@ -117,10 +133,23 @@ static unsigned int set_signaling_voltage(struct sdhci_host *host,
 	return 0;
 }
 
+#ifdef CONFIG_MMC_CLKGATE
+static void platform_hw_clk_gate(struct sdhci_host *host)
+{
+	int enable;
+
+	enable = host->mmc->clk_gated;
+	programFIFO(host, enable);
+}
+#endif
+
 static struct sdhci_ops sdhci_pxa_ops = {
 	.platform_reset_exit = platform_reset_exit,
 	.set_signaling_voltage = set_signaling_voltage,
 	.get_f_max_clock = NULL,
+#ifdef CONFIG_MMC_CLKGATE
+	.platform_hw_clk_gate = platform_hw_clk_gate,
+#endif
 };
 
 /*****************************************************************************\
@@ -194,8 +223,11 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
 	if (pdata->quirks)
 		host->quirks |= pdata->quirks;
 
-	/* enable mmc bus width testing */
+#ifdef CONFIG_MMC_CLKGATE
+	host->mmc->caps |= MMC_CAP_HW_CLOCK_GATING | MMC_CAP_BUS_WIDTH_TEST;
+#else
 	host->mmc->caps |= MMC_CAP_BUS_WIDTH_TEST;
+#endif
 
 	/* If slot design supports 8 bit data, indicate this to MMC. */
 	if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
-- 
1.7.0.4


