From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 2/2] mmc: sdhci-pltfm: add function in sdhci_ops to parse dt property
Date: Fri,  8 Mar 2013 23:07:43 +0800
Message-ID: <1362755263-6832-2-git-send-email-kliu5@marvell.com>
References: <1362755263-6832-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:40364 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753299Ab3CHPII (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Mar 2013 10:08:08 -0500
In-Reply-To: <1362755263-6832-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chunhe Lan <Chunhe.Lan@freescale.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

For sdhci based drivers, it's better to parse their host specific
device tree properties in their host's driver (sdhci-xxx.c) rather
than in the shared sdhci platform driver (sdhci-pltfm.c).
Otherwise function sdhci_get_of_property need to parse every
host's private dt property and will be bigger and bigger.

This patch add a function of_get_property in sdhci_ops to parse
host specific device tree property.

This patch also move Freescale eSDHC specific dt property parse code
from sdhci_get_of_property to of_get_property in its driver.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c |   19 +++++++++++++++++++
 drivers/mmc/host/sdhci-pltfm.c    |   11 +++--------
 drivers/mmc/host/sdhci.h          |    1 +
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index f32526d..7df98b0 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -230,6 +230,24 @@ static void esdhc_of_platform_init(struct sdhci_host *host)
 		host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
 }
 
+static void esdhc_of_get_property(struct sdhci_host *host)
+{
+	struct device_node *np;
+
+	if (!host->mmc->parent || !host->mmc->parent->of_node)
+		return;
+
+	np = host->mmc->parent->of_node;
+
+	if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
+		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
+
+	if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
+			of_device_is_compatible(np, "fsl,p1010-esdhc") ||
+			of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
+		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+}
+
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl,
 	.read_w = esdhc_readw,
@@ -247,6 +265,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.platform_resume = esdhc_of_resume,
 #endif
 	.adma_workaround = esdhci_of_adma_workaround,
+	.get_of_property = esdhc_of_get_property,
 };
 
 static struct sdhci_pltfm_data sdhci_esdhc_pdata = {
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 0c5eb6a..c17a03c 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -91,14 +91,6 @@ void sdhci_get_of_property(struct platform_device *pdev)
 	if (of_get_property(np, "no-1-8-v", NULL))
 		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 
-	if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
-		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
-
-	if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
-			of_device_is_compatible(np, "fsl,p1010-esdhc") ||
-			of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
-		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
-
 	clk = of_get_property(np, "clock-frequency", &size);
 	if (clk && size == sizeof(*clk) && *clk)
 		pltfm_host->clock = be32_to_cpup(clk);
@@ -108,6 +100,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 
 	if (of_find_property(np, "enable-sdio-wakeup", NULL))
 		host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
+
+	if (host->ops->get_of_property)
+		host->ops->get_of_property(host);
 }
 #else
 void sdhci_get_of_property(struct platform_device *pdev) {}
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 379e09d..0e5a0a1 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -294,6 +294,7 @@ struct sdhci_ops {
 	void	(*platform_resume)(struct sdhci_host *host);
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void	(*platform_init)(struct sdhci_host *host);
+	void	(*get_of_property)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.9.5

