From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH 4/4] mmc: sdhci-pltfm: remove host specific dt property parse code
Date: Tue, 12 Mar 2013 12:38:29 +0800
Message-ID: <CADz5_gLVONXJa6mKeqrdFgNKwv30jqr98tHUaFKtCDksZXzmhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:53955 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab3CLEi3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Mar 2013 00:38:29 -0400
Received: by mail-oa0-f49.google.com with SMTP id j6so5399597oag.36
        for <linux-mmc@vger.kernel.org>; Mon, 11 Mar 2013 21:38:29 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chunhe Lan <Chunhe.Lan@freescale.com>, Stephen Warren <swarren@wwwdotorg.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <kliu5@marvell.com>

Move Freescale eSDHC specific dt property parse code from
sdhci_get_of_property to of_get_property in its driver.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c |   19 +++++++++++++++++++
 drivers/mmc/host/sdhci-pltfm.c    |    8 --------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c
b/drivers/mmc/host/sdhci-of-esdhc.c
index f32526d..7df98b0 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -230,6 +230,24 @@ static void esdhc_of_platform_init(struct sdhci_host *host)
 		host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;  }

+static void esdhc_of_get_property(struct sdhci_host *host) {
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
+		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL; }
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

 static struct sdhci_pltfm_data sdhci_esdhc_pdata = { diff --git
a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 6bbbff7..c17a03c 100644
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
--
1.7.9.5
