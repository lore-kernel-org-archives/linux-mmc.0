From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: add support for hardware clock gating
Date: Fri, 21 Jan 2011 11:36:01 -0800
Message-ID: <219B8EAC-935D-4AFD-8AF0-353D4CE6EEB6@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:42100 "HELO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754859Ab1AUTgF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Jan 2011 14:36:05 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>

enable controller caps to support h/w clock gating

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci-pxa.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 2a6b156..b31d3d5 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -138,10 +138,23 @@ static void platform_reset_exit(struct sdhci_host *host, u8 mask)
 	}
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
 	.get_f_max_clock = NULL,
 	.set_signaling_voltage = set_signaling_voltage,
 	.platform_reset_exit = platform_reset_exit,
+#ifdef CONFIG_MMC_CLKGATE
+	.platform_hw_clk_gate = platform_hw_clk_gate,
+#endif
 };
 
 /*****************************************************************************\
@@ -209,8 +222,11 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
 	host->irq = irq;
 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
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


