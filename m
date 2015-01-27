From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH v1 1/2] mmc: host: arasan: Add addition of-arasan quirks and IOMMU support for arasan SDHCI driver.
Date: Tue, 27 Jan 2015 22:50:59 +0530
Message-ID: <1422379260-10139-2-git-send-email-stripathi@apm.com>
References: <1422379260-10139-1-git-send-email-stripathi@apm.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from denmail01-v4020.amcc.com ([192.195.68.30]:48567 "EHLO
	denmail01.apm.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757478AbbA0RWN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jan 2015 12:22:13 -0500
In-Reply-To: <1422379260-10139-1-git-send-email-stripathi@apm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, anton@enomsg.org, arnd@arndb.de
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddutile@redhat.com, jcm@redhat.com, mlangsdo@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>

Due to the fact that the existing of-arasan driver works with
32-bit platforms. This patch tweaks existing of-arasan driver
to work with 64-bit platform using IOMMU translation.

In addition it adds support for more quirks and quirks2 obtained
from device tree inside the generic sdhci-platform(sdhci-pltfm.c)
driver.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
 drivers/mmc/host/Makefile           |  2 ++
 drivers/mmc/host/sdhci-ahbc-xgene.c | 58 +++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-ahbc-xgene.h | 49 +++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-of-arasan.c  | 11 +++++++
 drivers/mmc/host/sdhci-pltfm.c      | 12 ++++++++
 5 files changed, 132 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-ahbc-xgene.c
 create mode 100644 drivers/mmc/host/sdhci-ahbc-xgene.h

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index b09ecfb..82de8f0 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -75,3 +75,5 @@ obj-$(CONFIG_MMC_SDHCI_ST)		+= sdhci-st.o
 ifeq ($(CONFIG_CB710_DEBUG),y)
 	CFLAGS-cb710-mmc	+= -DDEBUG
 endif
+
+obj-$(CONFIG_XGENE_AHBC_IOMMU)		+= sdhci-ahbc-xgene.o
diff --git a/drivers/mmc/host/sdhci-ahbc-xgene.c b/drivers/mmc/host/sdhci-ahbc-xgene.c
new file mode 100644
index 0000000..e23b69d98
--- /dev/null
+++ b/drivers/mmc/host/sdhci-ahbc-xgene.c
@@ -0,0 +1,58 @@
+/* sdhci-ahbc-xgene.c
+ *
+ * Copyright (c) 2014 Applied Micro Circuits Corporation.
+ * Author: Suman Tripathi <stripathi@apm.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/amba/bus.h>
+#include <linux/device.h>
+
+#include <asm/dma-iommu.h>
+
+#include "sdhci-ahbc-xgene.h"
+
+int xgene_ahbc_iommu_attach_device(struct device *dev)
+{
+	struct dma_iommu_mapping *mapping;
+	int ret;
+
+	/*
+	 * AHBC iommu don't have specific
+	 * IOMMU area. Create a mapping for
+	 * dummy area 4GB.
+	 */
+	mapping = arm64_iommu_create_mapping(&amba_bustype,
+					     XGENE_AHBC_IOMMU_DMA_START,
+					     XGENE_AHBC_IOMMU_DMA_SIZE);
+
+	if (IS_ERR(mapping))
+		return PTR_ERR(mapping);
+
+	mapping->identical_map = true;
+
+	ret = arm64_iommu_attach_device(dev, mapping);
+	if (ret < 0) {
+		dev_err(dev, "failed iommu attach\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+void xgene_ahbc_iommu_detach_device(struct device *dev)
+{
+	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+
+	if (!mapping || !mapping->domain)
+		return;
+
+	arm64_iommu_detach_device(dev);
+	arm64_iommu_release_mapping(mapping);
+
+}
+
diff --git a/drivers/mmc/host/sdhci-ahbc-xgene.h b/drivers/mmc/host/sdhci-ahbc-xgene.h
new file mode 100644
index 0000000..97a2b6b
--- /dev/null
+++ b/drivers/mmc/host/sdhci-ahbc-xgene.h
@@ -0,0 +1,49 @@
+/* xgene_sdhci_ahbc.h
+ *
+ * Copyright (c) 2014 Applied Micro Circuits Corporation.
+ * Author: Suman Tripathi <stripathi@apm.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef _XGENE_SDHCI_AHBC_H_
+#define _XGENE_SDHCI_AHBC_H_
+#include <linux/err.h>
+
+#ifdef CONFIG_XGENE_AHBC_IOMMU
+
+#define XGENE_AHBC_IOMMU_DMA_START	0x00000000
+#define XGENE_AHBC_IOMMU_DMA_SIZE	0x100000000
+
+int xgene_ahbc_iommu_attach_device(struct device *dev);
+void xgene_ahbc_iommu_detach_device(struct device *dev);
+static inline bool is_xgene_ahbc_iommu_supported(struct device *dev)
+{
+#ifdef CONFIG_ARM64_DMA_USE_IOMMU
+	return dev->archdata.mapping ? true : false;
+#else
+	return false;
+#endif
+}
+
+#else
+
+static inline int xgene_ahbc_iommu_attach_device(struct device *dev)
+{
+	return -ENOSYS;
+}
+
+static inline void xgene_ahbc_iommu_detach_device(struct device *dev)
+{
+	return;
+}
+
+static inline bool is_xgene_ahbc_iommu_supported(struct device *dev)
+{
+	return false;
+}
+#endif
+#endif
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 981d66e..78de09c 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -22,6 +22,8 @@
 #include <linux/module.h>
 #include "sdhci-pltfm.h"

+#include "sdhci-ahbc-xgene.h"
+
 #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c

 #define CLK_CTRL_TIMEOUT_SHIFT		16
@@ -174,6 +176,13 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	pltfm_host->priv = sdhci_arasan;
 	pltfm_host->clk = clk_xin;

+	ret = xgene_ahbc_iommu_attach_device(&pdev->dev);
+	if (ret < 0 && IS_ENABLED(CONFIG_XGENE_AHBC_IOMMU)) {
+		dev_err(&pdev->dev,
+			"unable to attach device to iommu %x\n", ret);
+		goto clk_disable_all;
+	}
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(&pdev->dev, "platform register failed (%u)\n", ret);
@@ -201,6 +210,8 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(sdhci_arasan->clk_ahb);

+	xgene_ahbc_iommu_detach_device(&pdev->dev);
+
 	return sdhci_pltfm_unregister(pdev);
 }

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index c5b01d6..2cf25bd 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -90,6 +90,18 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		if (of_get_property(np, "broken-cd", NULL))
 			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;

+		if (of_get_property(np, "delay-after-power", NULL))
+			host->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
+
+		if (of_get_property(np, "no-hispd", NULL))
+			host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
+
+		if (of_get_property(np, "broken-adma", NULL))
+			host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
+
+		if (of_get_property(np, "no-cmd23", NULL))
+			host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
+
 		if (of_get_property(np, "no-1-8-v", NULL))
 			host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;

--
1.8.2.1

