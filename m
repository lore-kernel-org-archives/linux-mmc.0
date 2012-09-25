From: <r66093@freescale.com>
Subject: [PATCH v4] powerpc/esdhc: disable CMD23 for some Freescale SoCs
Date: Tue, 25 Sep 2012 17:00:32 +0800
Message-ID: <1348563632-23659-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:54306
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751790Ab2IYJgX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 05:36:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Shaohui Xie <Shaohui.Xie@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Chris Ball <cjb@laptop.org>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

CMD23 causes lots of errors in kernel on some freescale SoCs
(P1020, P1021, P1022, P1024, P1025 and P4080) when MMC card used,
which is because these controllers does not support CMD23,
even on the SoCs which declares CMD23 is supported.
Therefore, we'll not use CMD23.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
CC: Anton Vorontsov <cbouatmailru@gmail.com>
CC: Chris Ball <cjb@laptop.org>
---
changes for v4:
	- change to detect the IP version
	- don't use callback function
changes for v3:
	- move the limitation detect function to eSDHC file
	- add the callback funtion to do this limitation detect
changes for v2:
	- discard the property mode and add the processor detection

 drivers/mmc/host/sdhci-of-esdhc.c |   33 +++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pltfm.c    |    4 +++-
 drivers/mmc/host/sdhci-pltfm.h    |    1 +
 drivers/mmc/host/sdhci.c          |    3 +++
 include/linux/mmc/sdhci.h         |    1 +
 5 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index ae5fcbf..231672b 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -169,6 +169,38 @@ static void esdhc_of_resume(struct sdhci_host *host)
 }
 #endif
 
+static void esdhc_of_detect_limitation(struct platform_device *pdev,
+	struct sdhci_pltfm_data *pdata)
+{
+	void __iomem *ioaddr;
+	struct resource *iomem;
+	u32 vvn;
+
+	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!iomem) {
+		dev_err(&pdev->dev, "failed to get resource\n");
+		goto err;
+	}
+	if (resource_size(iomem) < 0x100)
+		dev_err(&pdev->dev, "Invalid iomem size!\n");
+
+	ioaddr = ioremap(iomem->start, resource_size(iomem));
+	if (!ioaddr) {
+		dev_err(&pdev->dev, "failed to remap registers\n");
+		goto err;
+	}
+
+	/* P102x and P4080 has IP version VVN2.2, CMD23 is not supported */
+	vvn = in_be32(ioaddr + SDHCI_SLOT_INT_STATUS);
+	vvn = (vvn & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
+	if (vvn == VENDOR_V_22)
+		pdata->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
+
+	iounmap(ioaddr);
+err:
+	return;
+}
+
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl,
 	.read_w = esdhc_readw,
@@ -199,6 +231,7 @@ static struct sdhci_pltfm_data sdhci_esdhc_pdata = {
 
 static int __devinit sdhci_esdhc_probe(struct platform_device *pdev)
 {
+	esdhc_of_detect_limitation(pdev, &sdhci_esdhc_pdata);
 	return sdhci_pltfm_register(pdev, &sdhci_esdhc_pdata);
 }
 
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 65551a9..4dd5770 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -132,8 +132,10 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		host->ops = pdata->ops;
 	else
 		host->ops = &sdhci_pltfm_ops;
-	if (pdata)
+	if (pdata) {
 		host->quirks = pdata->quirks;
+		host->quirks2 = pdata->quirks2;
+	}
 	host->irq = platform_get_irq(pdev, 0);
 
 	if (!request_mem_region(iomem->start, resource_size(iomem),
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 37e0e18..283d54a 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -18,6 +18,7 @@
 struct sdhci_pltfm_data {
 	struct sdhci_ops *ops;
 	unsigned int quirks;
+	unsigned int quirks2;
 };
 
 struct sdhci_pltfm_host {
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0e15c79..b0b7cad 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2837,6 +2837,9 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 
+	if (host->quirks2 & SDHCI_QUIRK2_HOST_NO_CMD23)
+		mmc->caps &= ~MMC_CAP_CMD23;
+
 	if (caps[0] & SDHCI_CAN_DO_HISPD)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index fa8529a..1edcb4d 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -91,6 +91,7 @@ struct sdhci_host {
 	unsigned int quirks2;	/* More deviations from spec. */
 
 #define SDHCI_QUIRK2_HOST_OFF_CARD_ON			(1<<0)
+#define SDHCI_QUIRK2_HOST_NO_CMD23			(1<<1)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.7.9.5


