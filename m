From: dmitry pervushin <dpervushin@gmail.com>
Subject: [PATCH] sdhci - add public definition of quirks
Date: Mon, 22 Feb 2010 23:33:48 +0300
Message-ID: <1266870828.8840.22.camel@uxka.diimka.lan>
Reply-To: dpervushin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f227.google.com ([209.85.217.227]:63142 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276Ab0BVUd7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Feb 2010 15:33:59 -0500
Received: by gxk27 with SMTP id 27so1830281gxk.1
        for <linux-mmc@vger.kernel.org>; Mon, 22 Feb 2010 12:33:57 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Pierre Ossman <pierre@ossman.eu>, Richard =?ISO-8859-1?Q?R=F6jfors?= <richard.rojfors.ext@mocean-labs.com>

Hi Pierre, Richard,

The patch adds ability to architectures that use sdhci-pltfm driver to
provide their own quirks via platform_data parameter of sdhci devices.

Signed-off-by: dmitry pervushin <dpervushin@gmail.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    5 ++
 drivers/mmc/host/sdhci.h       |   52 ------------------------------
 include/linux/mmc/sdhci.h      |   69 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 51 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 297f40a..766eef4 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -51,6 +51,7 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
 	struct resource *iomem;
+	struct sdhci_platform_data *pdata;
 	int ret;
 
 	BUG_ON(pdev == NULL);
@@ -75,9 +76,13 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	pdata = pdev->dev.platform_data;
+
 	host->hw_name = "platform";
 	host->ops = &sdhci_pltfm_ops;
 	host->irq = platform_get_irq(pdev, 0);
+	if (pdata)
+		host->quirks = pdata->quirks;
 
 	if (!request_mem_region(iomem->start, resource_size(iomem),
 		mmc_hostname(host->mmc))) {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 842f46f..ecd4b29 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/io.h>
 
+#include <linux/mmc/sdhci.h>
 /*
  * Controller registers
  */
@@ -186,57 +187,6 @@ struct sdhci_host {
 
 	unsigned int		quirks;		/* Deviations from spec. */
 
-/* Controller doesn't honor resets unless we touch the clock register */
-#define SDHCI_QUIRK_CLOCK_BEFORE_RESET			(1<<0)
-/* Controller has bad caps bits, but really supports DMA */
-#define SDHCI_QUIRK_FORCE_DMA				(1<<1)
-/* Controller doesn't like to be reset when there is no card inserted. */
-#define SDHCI_QUIRK_NO_CARD_NO_RESET			(1<<2)
-/* Controller doesn't like clearing the power reg before a change */
-#define SDHCI_QUIRK_SINGLE_POWER_WRITE			(1<<3)
-/* Controller has flaky internal state so reset it on each ios change */
-#define SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS		(1<<4)
-/* Controller has an unusable DMA engine */
-#define SDHCI_QUIRK_BROKEN_DMA				(1<<5)
-/* Controller has an unusable ADMA engine */
-#define SDHCI_QUIRK_BROKEN_ADMA				(1<<6)
-/* Controller can only DMA from 32-bit aligned addresses */
-#define SDHCI_QUIRK_32BIT_DMA_ADDR			(1<<7)
-/* Controller can only DMA chunk sizes that are a multiple of 32 bits */
-#define SDHCI_QUIRK_32BIT_DMA_SIZE			(1<<8)
-/* Controller can only ADMA chunks that are a multiple of 32 bits */
-#define SDHCI_QUIRK_32BIT_ADMA_SIZE			(1<<9)
-/* Controller needs to be reset after each request to stay stable */
-#define SDHCI_QUIRK_RESET_AFTER_REQUEST			(1<<10)
-/* Controller needs voltage and power writes to happen separately */
-#define SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER		(1<<11)
-/* Controller provides an incorrect timeout value for transfers */
-#define SDHCI_QUIRK_BROKEN_TIMEOUT_VAL			(1<<12)
-/* Controller has an issue with buffer bits for small transfers */
-#define SDHCI_QUIRK_BROKEN_SMALL_PIO			(1<<13)
-/* Controller does not provide transfer-complete interrupt when not busy */
-#define SDHCI_QUIRK_NO_BUSY_IRQ				(1<<14)
-/* Controller has unreliable card detection */
-#define SDHCI_QUIRK_BROKEN_CARD_DETECTION		(1<<15)
-/* Controller reports inverted write-protect state */
-#define SDHCI_QUIRK_INVERTED_WRITE_PROTECT		(1<<16)
-/* Controller has nonstandard clock management */
-#define SDHCI_QUIRK_NONSTANDARD_CLOCK			(1<<17)
-/* Controller does not like fast PIO transfers */
-#define SDHCI_QUIRK_PIO_NEEDS_DELAY			(1<<18)
-/* Controller losing signal/interrupt enable states after reset */
-#define SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET		(1<<19)
-/* Controller has to be forced to use block size of 2048 bytes */
-#define SDHCI_QUIRK_FORCE_BLK_SZ_2048			(1<<20)
-/* Controller cannot do multi-block transfers */
-#define SDHCI_QUIRK_NO_MULTIBLOCK			(1<<21)
-/* Controller can only handle 1-bit data transfers */
-#define SDHCI_QUIRK_FORCE_1_BIT_DATA			(1<<22)
-/* Controller needs 10ms delay between applying power and clock */
-#define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<23)
-/* Controller uses SDCLK instead of TMCLK for data timeouts */
-#define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK		(1<<24)
-
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
new file mode 100644
index 0000000..c3fcaa9
--- /dev/null
+++ b/include/linux/mmc/sdhci.h
@@ -0,0 +1,69 @@
+/*
+ * include/linux/mmc/sdhci.h - public definition of 'quirks' bitfield
+ *
+ * Copyright (C) 2005-2008 Pierre Ossman, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ */
+#ifndef __LINUX_SDHCI_H
+#define __LINUX_SDHCI_H
+
+/* Controller doesn't honor resets unless we touch the clock register */
+#define SDHCI_QUIRK_CLOCK_BEFORE_RESET			(1<<0)
+/* Controller has bad caps bits, but really supports DMA */
+#define SDHCI_QUIRK_FORCE_DMA				(1<<1)
+/* Controller doesn't like to be reset when there is no card inserted. */
+#define SDHCI_QUIRK_NO_CARD_NO_RESET			(1<<2)
+/* Controller doesn't like clearing the power reg before a change */
+#define SDHCI_QUIRK_SINGLE_POWER_WRITE			(1<<3)
+/* Controller has flaky internal state so reset it on each ios change */
+#define SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS		(1<<4)
+/* Controller has an unusable DMA engine */
+#define SDHCI_QUIRK_BROKEN_DMA				(1<<5)
+/* Controller has an unusable ADMA engine */
+#define SDHCI_QUIRK_BROKEN_ADMA				(1<<6)
+/* Controller can only DMA from 32-bit aligned addresses */
+#define SDHCI_QUIRK_32BIT_DMA_ADDR			(1<<7)
+/* Controller can only DMA chunk sizes that are a multiple of 32 bits */
+#define SDHCI_QUIRK_32BIT_DMA_SIZE			(1<<8)
+/* Controller can only ADMA chunks that are a multiple of 32 bits */
+#define SDHCI_QUIRK_32BIT_ADMA_SIZE			(1<<9)
+/* Controller needs to be reset after each request to stay stable */
+#define SDHCI_QUIRK_RESET_AFTER_REQUEST			(1<<10)
+/* Controller needs voltage and power writes to happen separately */
+#define SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER		(1<<11)
+/* Controller provides an incorrect timeout value for transfers */
+#define SDHCI_QUIRK_BROKEN_TIMEOUT_VAL			(1<<12)
+/* Controller has an issue with buffer bits for small transfers */
+#define SDHCI_QUIRK_BROKEN_SMALL_PIO			(1<<13)
+/* Controller does not provide transfer-complete interrupt when not busy */
+#define SDHCI_QUIRK_NO_BUSY_IRQ				(1<<14)
+/* Controller has unreliable card detection */
+#define SDHCI_QUIRK_BROKEN_CARD_DETECTION		(1<<15)
+/* Controller reports inverted write-protect state */
+#define SDHCI_QUIRK_INVERTED_WRITE_PROTECT		(1<<16)
+/* Controller has nonstandard clock management */
+#define SDHCI_QUIRK_NONSTANDARD_CLOCK			(1<<17)
+/* Controller does not like fast PIO transfers */
+#define SDHCI_QUIRK_PIO_NEEDS_DELAY			(1<<18)
+/* Controller losing signal/interrupt enable states after reset */
+#define SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET		(1<<19)
+/* Controller has to be forced to use block size of 2048 bytes */
+#define SDHCI_QUIRK_FORCE_BLK_SZ_2048			(1<<20)
+/* Controller cannot do multi-block transfers */
+#define SDHCI_QUIRK_NO_MULTIBLOCK			(1<<21)
+/* Controller can only handle 1-bit data transfers */
+#define SDHCI_QUIRK_FORCE_1_BIT_DATA			(1<<22)
+/* Controller needs 10ms delay between applying power and clock */
+#define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<23)
+/* Controller uses SDCLK instead of TMCLK for data timeouts */
+#define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK		(1<<24)
+
+struct sdhci_platform_data {
+	unsigned int quirks;
+};
+
+#endif /* __LINUX_SDHCI_H */


