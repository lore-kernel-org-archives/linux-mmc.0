From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] mmc: sdhci-sirf: enable dmabounce since SiRFprimaII MMC DMA only access up to 256MB
Date: Mon, 28 Oct 2013 05:23:50 +0800
Message-ID: <1382909030-7499-1-git-send-email-Baohua.Song@csr.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:34236 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab3J0VYb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Oct 2013 17:24:31 -0400
Received: by mail-wg0-f53.google.com with SMTP id y10so5851469wgg.20
        for <linux-mmc@vger.kernel.org>; Sun, 27 Oct 2013 14:24:30 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, Bin Shi <Bin.Shi@csr.com>, Binghua Duan <Binghua.Duan@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Bin Shi <Bin.Shi@csr.com>

on SiRFprimaII, sdhci is after pci-iobg bus, the bus bridge has a hardware
limitation. DMA operations after this bridge can not access memory address
higher than 256MB.

this patch enables dmabounce for SiRFprimaII to fix DMA of primaII. for other
SiRF SoCs, there is no this problem.

Signed-off-by: Bin Shi <Bin.Shi@csr.com>
Signed-off-by: Binghua Duan <Binghua.Duan@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/Kconfig  |  1 +
 drivers/mmc/host/sdhci-sirf.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 6988b11..8ecb071 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -26,6 +26,7 @@ config ARCH_PRIMA2
 	bool "CSR SiRFSoC PRIMA2 ARM Cortex A9 Platform"
 	default y
 	select CPU_V7
+	select DMABOUNCE
 	select SIRF_IRQ
 	select ZONE_DMA
 	help
diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 696122c..11e270f 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/mmc/slot-gpio.h>
+#include <linux/dma-mapping.h>
 #include "sdhci-pltfm.h"
 
 struct sdhci_sirf_priv {
@@ -40,6 +41,16 @@ static struct sdhci_pltfm_data sdhci_sirf_pdata = {
 		SDHCI_QUIRK_DELAY_AFTER_POWER,
 };
 
+/*
+ * The following functions are needed for DMA bouncing because SiRFprimaII SD
+ * controller can address up to 256MByte
+ */
+static int sdhci_sirf_needs_bounce(struct device *dev, dma_addr_t dma_addr,
+	size_t size)
+{
+	return (dma_addr + size) >= SZ_256M;
+}
+
 static int sdhci_sirf_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
@@ -92,6 +103,13 @@ static int sdhci_sirf_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (of_machine_is_compatible("sirf,prima2")) {
+		if (pdev->dev.dma_mask)
+			*(pdev->dev.dma_mask) = SZ_256M - 1;
+		pdev->dev.coherent_dma_mask = SZ_256M - 1;
+		dmabounce_register_dev(&pdev->dev, 1024, 2048, sdhci_sirf_needs_bounce);
+	}
+
 	return 0;
 
 err_request_cd:
-- 
1.8.2.3

