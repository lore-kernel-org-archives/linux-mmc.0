From: Chunhe Lan <Chunhe.Lan@freescale.com>
Subject: [PATCH] mmc: sdhci-pltfm: Add SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33 quirk support
Date: Wed, 27 Mar 2013 12:08:34 +0800
Message-ID: <1364357314-19480-1-git-send-email-Chunhe.Lan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0186.outbound.messaging.microsoft.com ([213.199.154.186]:17978
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750809Ab3C0EFT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Mar 2013 00:05:19 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Chunhe Lan <Chunhe.Lan@freescale.com>

On the t4240 platform, sdhci controller can only support 1.8V
voltage, but the peripheral hardware circuit has capability to
support 3.3V voltage.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci-pltfm.c |    3 +++
 drivers/mmc/host/sdhci.c       |    3 +++
 include/linux/mmc/sdhci.h      |    4 ++++
 3 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 9db7b12..9e9728f 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -98,6 +98,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
 			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+		if (of_device_is_compatible(np, "fsl,t4240-esdhc"))
+			host->quirks2 |= SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33;
+
 		clk = of_get_property(np, "clock-frequency", &size);
 		if (clk && size == sizeof(*clk) && *clk)
 			pltfm_host->clock = be32_to_cpup(clk);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b25d94e..acd7a2f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2730,6 +2730,9 @@ int sdhci_add_host(struct sdhci_host *host)
 			host->caps1 :
 			sdhci_readl(host, SDHCI_CAPABILITIES_1);
 
+	if (host->quirks2 & SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33)
+		caps[0] = caps[0] | SDHCI_CAN_VDD_330;
+
 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
 	else if (!(caps[0] & SDHCI_CAN_DO_SDMA))
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index b838ffc..a53bbaf 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -95,6 +95,10 @@ struct sdhci_host {
 /* The system physically doesn't support 1.8v, even if the host does */
 #define SDHCI_QUIRK2_NO_1_8_V				(1<<2)
 #define SDHCI_QUIRK2_PRESET_VALUE_BROKEN		(1<<3)
+/* Controller can only supports 1.8V, but the peripheral hardware
+ * circuit has capability to support 3.3V
+ */
+#define SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33		(1<<4)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.7.6.5


