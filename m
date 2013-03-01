From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 2/3] mmc: sdhci-pxav3: transfer platform data to sdhci_pltfm_init
Date: Fri,  1 Mar 2013 17:41:28 +0800
Message-ID: <1362130888-675-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:59233 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751246Ab3CAJkz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Mar 2013 04:40:55 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

Let sdhci_pltfm_init set host->ops and host->quirks.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index a0cdbc5..55d0784 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -174,6 +174,14 @@ static struct sdhci_ops pxav3_sdhci_ops = {
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 };
 
+static struct sdhci_pltfm_data sdhci_pxav3_pdata = {
+	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
+		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
+		| SDHCI_QUIRK_32BIT_ADMA_SIZE
+		| SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.ops = &pxav3_sdhci_ops,
+};
+
 #ifdef CONFIG_OF
 static const struct of_device_id sdhci_pxav3_of_match[] = {
 	{
@@ -235,7 +243,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	if (!pxa)
 		return -ENOMEM;
 
-	host = sdhci_pltfm_init(pdev, NULL);
+	host = sdhci_pltfm_init(pdev, &sdhci_pxav3_pdata);
 	if (IS_ERR(host)) {
 		kfree(pxa);
 		return PTR_ERR(host);
@@ -252,11 +260,6 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	pltfm_host->clk = clk;
 	clk_prepare_enable(clk);
 
-	host->quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
-		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
-		| SDHCI_QUIRK_32BIT_ADMA_SIZE
-		| SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
-
 	/* enable 1/8V DDR capable */
 	host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
@@ -296,8 +299,6 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 		}
 	}
 
-	host->ops = &pxav3_sdhci_ops;
-
 	sdhci_get_of_property(pdev);
 
 	pm_runtime_set_active(&pdev->dev);
-- 
1.7.9.5

