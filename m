From: <r66093@freescale.com>
Subject: [PATCH v3] powerpc/esdhc: disable CMD23 for some Freescale SoCs
Date: Fri, 21 Sep 2012 18:25:35 +0800
Message-ID: <1348223135-6435-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:8073
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757240Ab2IULAl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Sep 2012 07:00:41 -0400
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
changes for v3:
	- move the limitation detect function to eSDHC file
	- add the callback funtion to do this limitation detect
changes for v2:
	- discard the property mode and add the processor detection

 drivers/mmc/host/sdhci-of-esdhc.c |   30 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pltfm.c    |    3 +++
 drivers/mmc/host/sdhci.c          |    3 +++
 drivers/mmc/host/sdhci.h          |    1 +
 include/linux/mmc/sdhci.h         |    1 +
 5 files changed, 38 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index f8eb1fb..2f40a7f 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -143,6 +143,35 @@ static void esdhc_of_resume(struct sdhci_host *host)
 }
 #endif
 
+static const u32 non_cmd23_processor_table[] = {
+	/* P1020 Dual/Single core */
+	0x80EC00, 0x80E400, 0x80ED00, 0x80E500,
+	/* P1021 Dual/Single core */
+	0x80EC01, 0x80E401, 0x80ED01, 0x80E501,
+	/* P1022 Dual/Single core */
+	0x80EE00, 0x80E600, 0x80EF00, 0x80E700,
+	/* P1024 Dual/Single core */
+	0x80EC02, 0x80E402, 0x80ED02, 0x80E502,
+	/* P1025 Dual/Single core */
+	0x80EC03, 0x80E403, 0x80ED03, 0x80E503,
+	/* P4080 and P4040 */
+	0x820000, 0x820800, 0x820100, 0x820900
+};
+
+void esdhc_of_detect_limitation(struct sdhci_host *host)
+{
+	u32 svr = mfspr(SPRN_SVR) >> 8;
+	u32 table_size = ARRAY_SIZE(non_cmd23_processor_table);
+	int i;
+
+	for (i = 0; i < table_size; i++) {
+		if (non_cmd23_processor_table[i] == svr) {
+			host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
+			break;
+		}
+	}
+}
+
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = sdhci_be32bs_readl,
 	.read_w = esdhc_readw,
@@ -158,6 +187,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.platform_suspend = esdhc_of_suspend,
 	.platform_resume = esdhc_of_resume,
 #endif
+	.platform_limitation = esdhc_of_detect_limitation,
 };
 
 static struct sdhci_pltfm_data sdhci_esdhc_pdata = {
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index d9a4ef4..864bedd 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -185,6 +185,9 @@ int sdhci_pltfm_register(struct platform_device *pdev,
 
 	sdhci_get_of_property(pdev);
 
+	if (host->ops->platform_limitation)
+		host->ops->platform_limitation(host);
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		sdhci_pltfm_free(pdev);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9a11dc3..6208a8b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2795,6 +2795,9 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 
+	if (host->quirks2 & SDHCI_QUIRK2_HOST_NO_CMD23)
+		mmc->caps &= ~MMC_CAP_CMD23;
+
 	if (caps[0] & SDHCI_CAN_DO_HISPD)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 97653ea..4296bef 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -278,6 +278,7 @@ struct sdhci_ops {
 	void	(*hw_reset)(struct sdhci_host *host);
 	void	(*platform_suspend)(struct sdhci_host *host);
 	void	(*platform_resume)(struct sdhci_host *host);
+	void	(*platform_limitation)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index ac83b10..97c73f5 100644
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


