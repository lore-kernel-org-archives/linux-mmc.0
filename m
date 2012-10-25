From: <r66093@freescale.com>
Subject: [PATCH v6] powerpc/esdhc: disable CMD23 for some Freescale SoCs
Date: Thu, 25 Oct 2012 13:47:19 +0800
Message-ID: <1351144039-30588-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:51352
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752947Ab2JYG2u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Oct 2012 02:28:50 -0400
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
changes for v6:
	-add the callback to this check
changes for v5:
	- change the error to warning information
changes for v4:
	- change to detect the IP version
	- don't use callback function
changes for v3:
	- move the limitation detect function to eSDHC file
	- add the callback funtion to do this limitation detect
changes for v2:
	- discard the property mode and add the processor detection

 drivers/mmc/host/sdhci-of-esdhc.c |   11 +++++++++++
 drivers/mmc/host/sdhci-pltfm.c    |    4 ++++
 drivers/mmc/host/sdhci.c          |    3 +++
 drivers/mmc/host/sdhci.h          |    1 +
 include/linux/mmc/sdhci.h         |    1 +
 5 files changed, 20 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index ae5fcbf..c03f899 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -169,6 +169,16 @@ static void esdhc_of_resume(struct sdhci_host *host)
 }
 #endif
 
+static void esdhc_of_platform_caps(struct sdhci_host *host)
+{
+	u32 vvn;
+
+	vvn = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
+	vvn = (vvn & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
+	if (vvn == VENDOR_V_22)
+		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
+}
+
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl,
 	.read_w = esdhc_readw,
@@ -184,6 +194,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.platform_suspend = esdhc_of_suspend,
 	.platform_resume = esdhc_of_resume,
 #endif
+	.platform_caps = esdhc_of_platform_caps,
 };
 
 static struct sdhci_pltfm_data sdhci_esdhc_pdata = {
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 65551a9..848cf62 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -150,6 +150,10 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		goto err_remap;
 	}
 
+	/* Check the platform capability */
+	if (host->ops && host->ops->platform_caps)
+		host->ops->platform_caps(host);
+
 	platform_set_drvdata(pdev, host);
 
 	return host;
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
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 97653ea..98f6d4d 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -278,6 +278,7 @@ struct sdhci_ops {
 	void	(*hw_reset)(struct sdhci_host *host);
 	void	(*platform_suspend)(struct sdhci_host *host);
 	void	(*platform_resume)(struct sdhci_host *host);
+	void	(*platform_caps)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
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


