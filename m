From: <r66093@freescale.com>
Subject: [PATCH 2/6] SDHCI: AHB2MAG IRQ bypass hardware workaround
Date: Wed, 14 Dec 2011 10:19:38 +0800
Message-ID: <1323829182-1551-3-git-send-email-r66093@freescale.com>
References: <1323829182-1551-1-git-send-email-r66093@freescale.com>
 <1323829182-1551-2-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:28485 "EHLO
	TX2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032Ab1LNDGC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2011 22:06:02 -0500
Received: from mail159-tx2 (localhost [127.0.0.1])	by
 mail159-tx2-R.bigfish.com (Postfix) with ESMTP id 8926D4C022F	for
 <linux-mmc@vger.kernel.org>; Wed, 14 Dec 2011 03:06:03 +0000 (UTC)
Received: from TX2EHSMHS019.bigfish.com (unknown [10.9.14.247])	by
 mail159-tx2.bigfish.com (Postfix) with ESMTP id 4758D6A006A	for
 <linux-mmc@vger.kernel.org>; Wed, 14 Dec 2011 03:05:49 +0000 (UTC)
In-Reply-To: <1323829182-1551-2-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Gao Guanhua <B22826@freescale.com>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

For Fsl eSDHC controller, the bit DCR[DMA__AHB2MAG_IRQ_BYPASS] cannot be
set automatically, when SoC reset, therefore, we need to set this bit manually.

Signed-off-by: Gao Guanhua <B22826@freescale.com>
Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc.h    |    1 +
 drivers/mmc/host/sdhci-of-esdhc.c |    7 +++++++
 drivers/mmc/host/sdhci-pltfm.c    |    3 +++
 drivers/mmc/host/sdhci.c          |    4 ++++
 drivers/mmc/host/sdhci.h          |    1 +
 include/linux/mmc/sdhci.h         |    2 ++
 6 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index c3b08f1..7cbaffe 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -39,6 +39,7 @@
 /* OF-specific */
 #define ESDHC_DMA_SYSCTL	0x40c
 #define ESDHC_DMA_SNOOP		0x00000040
+#define ESDHC_AHB2MAG_IRQ_BYPASS	0x20
 
 #define ESDHC_HOST_CONTROL_RES	0x05
 
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 7d5ae82..413ded5 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -68,6 +68,12 @@ static int esdhc_of_enable_dma(struct sdhci_host *host)
 	return 0;
 }
 
+static int esdhc_of_enable_irq_bypass(struct sdhci_host *host)
+{
+	setbits32(host->ioaddr + ESDHC_DMA_SYSCTL, ESDHC_AHB2MAG_IRQ_BYPASS);
+	return 0;
+}
+
 static unsigned int esdhc_of_get_max_clock(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -116,6 +122,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.get_max_clock = esdhc_of_get_max_clock,
 	.get_min_clock = esdhc_of_get_min_clock,
 	.get_cd = esdhc_of_get_cd,
+	.enable_irq_bypass = esdhc_of_enable_irq_bypass,
 };
 
 static struct sdhci_pltfm_data sdhci_esdhc_pdata = {
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 2a77435..de182c6 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -74,6 +74,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		if (of_get_property(np, "sdhci,dma-broken", NULL))
 			host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
 
+		if (of_get_property(np, "sdhci,ahb2mag-irq-bypass", NULL))
+			host->quirks2 |= SDHCI_QUIRK2_SET_AHB2MAG_IRQ_BYPASS;
+
 		clk = of_get_property(np, "clock-frequency", &size);
 		if (clk && size == sizeof(*clk) && *clk)
 			pltfm_host->clock = be32_to_cpup(clk);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fbe2f46..ae52ab9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -226,6 +226,10 @@ static void sdhci_init(struct sdhci_host *host, int soft)
 	else
 		sdhci_reset(host, SDHCI_RESET_ALL);
 
+	if (host->quirks2 & SDHCI_QUIRK2_SET_AHB2MAG_IRQ_BYPASS)
+		if (host->ops->enable_irq_bypass)
+			host->ops->enable_irq_bypass(host);
+
 	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
 		SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
 		SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_INDEX |
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 82f4d27..1326557 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -263,6 +263,7 @@ struct sdhci_ops {
 	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
 
 	int		(*get_cd)(struct sdhci_host *host);
+	int		(*enable_irq_bypass)(struct sdhci_host *host);
 	int		(*enable_dma)(struct sdhci_host *host);
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index e4b6935..1dbe22b 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -91,6 +91,8 @@ struct sdhci_host {
 	unsigned int quirks2;	/* More deviations from spec. */
 
 #define SDHCI_QUIRK2_OWN_CARD_DETECTION			(1<<0)
+/* Controller cannot set DCR[DMA__AHB2MAG_IRQ_BYPASS] automatically */
+#define SDHCI_QUIRK2_SET_AHB2MAG_IRQ_BYPASS		(1<<1)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.7.5.4


