From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 2/2] mmc:esdhc: Enable DMA err bit for eSDHC host
Date: Tue, 17 Sep 2013 13:28:30 +0800
Message-ID: <1379395711-28462-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:25764
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751130Ab3IQFdR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Sep 2013 01:33:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, ulf.hansson@linaro.org, Haijun Zhang <Haijun.Zhang@freescale.com>

eSDHC host had bit eSDHC_IRQSTAT[3] to indicate that DMA (SDMA or ADMA)
transfer has failed. So enable this bit detecting and its interrupt.

Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index e328252..86809c0 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -24,6 +24,9 @@
 
 #define VENDOR_V_22	0x12
 #define VENDOR_V_23	0x13
+
+#define ESDHC_INT_DMA_ERROR    0x10000000
+
 static u32 esdhc_readl(struct sdhci_host *host, int reg)
 {
 	u32 ret;
@@ -238,6 +241,21 @@ static void esdhc_of_platform_init(struct sdhci_host *host)
 		host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
 }
 
+static void esdhc_get_pltfm_irq(struct sdhci_host *host, u32 *irq)
+{
+	*irq |= ESDHC_INT_DMA_ERROR;
+}
+
+static void esdhc_pltfm_irq_handler(struct sdhci_host *host, u32 intmask)
+{
+	if (intmask & (ESDHC_INT_DMA_ERROR | SDHCI_INT_ADMA_ERROR)) {
+		host->data->error = -EIO;
+		pr_err("%s: ADMA error\n", mmc_hostname(host->mmc));
+		sdhci_show_adma_error(host);
+		esdhci_of_adma_workaround(host, intmask);
+	}
+}
+
 static int esdhc_pltfm_bus_width(struct sdhci_host *host, int width)
 {
 	u32 ctrl;
@@ -273,6 +291,8 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
 	.enable_dma = esdhc_of_enable_dma,
 	.get_max_clock = esdhc_of_get_max_clock,
 	.get_min_clock = esdhc_of_get_min_clock,
+	.get_platform_irq = esdhc_get_pltfm_irq,
+	.handle_platform_irq = esdhc_pltfm_irq_handler,
 	.platform_init = esdhc_of_platform_init,
 #ifdef CONFIG_PM
 	.platform_suspend = esdhc_of_suspend,
-- 
1.8.0


