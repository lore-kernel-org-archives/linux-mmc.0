From: <r66093@freescale.com>
Subject: [PATCH 4/6] ESDHC: Power management for ESDHC
Date: Wed, 14 Dec 2011 10:19:40 +0800
Message-ID: <1323829182-1551-5-git-send-email-r66093@freescale.com>
References: <1323829182-1551-1-git-send-email-r66093@freescale.com>
 <1323829182-1551-2-git-send-email-r66093@freescale.com>
 <1323829182-1551-3-git-send-email-r66093@freescale.com>
 <1323829182-1551-4-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:5370 "EHLO
	TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032Ab1LNDHE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2011 22:07:04 -0500
Received: from mail93-tx2 (localhost [127.0.0.1])	by mail93-tx2-R.bigfish.com
 (Postfix) with ESMTP id 786481C0303	for <linux-mmc@vger.kernel.org>; Wed, 14
 Dec 2011 03:07:05 +0000 (UTC)
Received: from TX2EHSMHS035.bigfish.com (unknown [10.9.14.244])	by
 mail93-tx2.bigfish.com (Postfix) with ESMTP id 7B40922007A	for
 <linux-mmc@vger.kernel.org>; Wed, 14 Dec 2011 03:05:52 +0000 (UTC)
In-Reply-To: <1323829182-1551-4-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Jiang Yutang <b14898@freescale.com>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

For FSL ESDHC controllor, when enter the sleep, the controller will power off,
therefore the register will lost its valuse, and driver should save value of
register during suspend and used during resume.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Jiang Yutang <b14898@freescale.com>
---
 drivers/mmc/host/sdhci-pltfm.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index c4ec8bd..e39bb13 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -53,6 +53,10 @@ static bool sdhci_of_wp_inverted(struct device_node *np)
 #endif /* CONFIG_PPC */
 }
 
+#ifdef CONFIG_PM
+static int sdhc_pmsaveproctlreg;
+static u32 esdhc_proctl;
+#endif
 void sdhci_get_of_property(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -79,7 +83,10 @@ void sdhci_get_of_property(struct platform_device *pdev)
 
 		if (of_get_property(np, "sdhci,ahb2mag-irq-bypass", NULL))
 			host->quirks2 |= SDHCI_QUIRK2_SET_AHB2MAG_IRQ_BYPASS;
-
+#ifdef CONFIG_PM
+		if (of_get_property(np, "pmsaveproctlreg", NULL))
+			sdhc_pmsaveproctlreg = 1;
+#endif
 		clk = of_get_property(np, "clock-frequency", &size);
 		if (clk && size == sizeof(*clk) && *clk)
 			pltfm_host->clock = be32_to_cpup(clk);
@@ -207,15 +214,25 @@ int sdhci_pltfm_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct sdhci_host *host = platform_get_drvdata(dev);
 
+	if (sdhc_pmsaveproctlreg == 1)
+		esdhc_proctl = sdhci_readl(host, SDHCI_HOST_CONTROL);
+
 	return sdhci_suspend_host(host, state);
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_suspend);
 
 int sdhci_pltfm_resume(struct platform_device *dev)
 {
+	int ret;
 	struct sdhci_host *host = platform_get_drvdata(dev);
 
-	return sdhci_resume_host(host);
+	 host->ops->enable_dma(host);
+
+	ret = mmc_resume_host(host->mmc);
+	if (sdhc_pmsaveproctlreg == 1)
+		sdhci_writel(host, esdhc_proctl, SDHCI_HOST_CONTROL);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_resume);
 #endif	/* CONFIG_PM */
-- 
1.7.5.4


