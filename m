From: Roy Zang <tie-fei.zang@freescale.com>
Subject: [PATCH 3/3] mmc: Add ESDHC weird register workaround
Date: Wed, 28 Jul 2010 14:04:42 +0800
Message-ID: <1280297082-25793-1-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:34115
	"EHLO VA3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753240Ab0G1GSz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Jul 2010 02:18:55 -0400
Received: from mail160-va3 (localhost.localdomain [127.0.0.1])	by
 mail160-va3-R.bigfish.com (Postfix) with ESMTP id 33EA72F8549	for
 <linux-mmc@vger.kernel.org>; Wed, 28 Jul 2010 06:18:54 +0000 (UTC)
Received: from VA3EHSMHS023.bigfish.com (unknown [10.7.14.238])	by
 mail160-va3.bigfish.com (Postfix) with ESMTP id C01E44A004D	for
 <linux-mmc@vger.kernel.org>; Wed, 28 Jul 2010 06:18:53 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
 [10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
 o6S6IqDP015474	for <linux-mmc@vger.kernel.org>; Tue, 27 Jul 2010 23:18:52
 -0700 (MST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

P4080 ESDHC controller induces weird register setting.
This patch adds the workaround to correct the weird register setting.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 drivers/mmc/host/sdhci-of-core.c |    5 +++++
 drivers/mmc/host/sdhci.c         |   13 +++++++++++++
 drivers/mmc/host/sdhci.h         |    2 ++
 3 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of-core.c
index 0c30242..1b6945a 100644
--- a/drivers/mmc/host/sdhci-of-core.c
+++ b/drivers/mmc/host/sdhci-of-core.c
@@ -164,6 +164,11 @@ static int __devinit sdhci_of_probe(struct of_device *ofdev,
 	if (sdhci_of_wp_inverted(np))
 		host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
 
+	if (of_device_is_compatible(np, "fsl,p4080-esdhc")) {
+		host->quirks |= SDHCI_QUIRK_QORIQ_REG_WEIRD;
+		host->quirks &= ~SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
+	}
+
 	clk = of_get_property(np, "clock-frequency", &size);
 	if (clk && size == sizeof(*clk) && *clk)
 		of_host->clock = *clk;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1424d08..b5b3627 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -788,6 +788,15 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)
 		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 	}
 
+	/* The default value of DMAS bits of Protocol Control Register is not
+	 * correct. clear these two bits to use simple DMA */
+#define  ESDHCI_CTRL_DMAS_MASK		0xFFFFFCFF
+	if (host->quirks & SDHCI_QUIRK_QORIQ_REG_WEIRD) {
+		ctrl = sdhci_readl(host, SDHCI_HOST_CONTROL);
+		ctrl = ctrl & ESDHCI_CTRL_DMAS_MASK;
+		sdhci_writel(host, ctrl, SDHCI_HOST_CONTROL);
+	}
+
 	if (!(host->flags & SDHCI_REQ_USE_DMA)) {
 		int flags;
 
@@ -1699,6 +1708,10 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
 
+	 /* Workaround for P4080 host controller capabilities */
+	if (host->quirks & SDHCI_QUIRK_QORIQ_REG_WEIRD)
+		caps &= ~(SDHCI_CAN_VDD_180 | SDHCI_CAN_VDD_330);
+
 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
 	else if (!(caps & SDHCI_CAN_DO_SDMA))
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index aa112aa..33d5613 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -243,6 +243,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
 /* Controller uses Auto CMD12 command to stop the transfer */
 #define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<27)
+/* Controller has weird bit setting for some registers due to errata */
+#define SDHCI_QUIRK_QORIQ_REG_WEIRD			(1<<28)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.5.6.5


