From: <r66093@freescale.com>
Subject: [PATCH 3/5 v3] ESDHC: Power management for ESDHC
Date: Tue, 27 Dec 2011 12:06:32 +0800
Message-ID: <1324958792-16742-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:39644 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab1L0EzK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Dec 2011 23:55:10 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Jiang Yutang <b14898@freescale.com>, Chris Ball <cjb@laptop.org>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

For FSL ESDHC controllor, when enter the sleep, the controller will power off,
therefore the register will lost its valuse, and driver should save value of
register during suspend and used during resume.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Jiang Yutang <b14898@freescale.com>
CC: Chris Ball <cjb@laptop.org>
---
changes for v2:
	- change the property to compatible for quirks
changes for v3:
	- fix one compile error

 drivers/mmc/host/sdhci-pltfm.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 1c254b1..6791a2a 100644
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
@@ -79,6 +83,11 @@ void sdhci_get_of_property(struct platform_device *pdev)
 			|| of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
 			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+#ifdef CONFIG_PM
+		if (of_device_is_compatible(np, "fsl,p1022-esdhc"))
+			sdhc_pmsaveproctlreg = 1;
+#endif
+
 		clk = of_get_property(np, "clock-frequency", &size);
 		if (clk && size == sizeof(*clk) && *clk)
 			pltfm_host->clock = be32_to_cpup(clk);
@@ -206,15 +215,25 @@ int sdhci_pltfm_suspend(struct platform_device *dev, pm_message_t state)
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


