From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH RESEND 1/4] mmc: sdhci-pxav3: transfer sdhci_pltfm_data as arguments to sdhci_pltfm_init
Date: Mon, 25 Mar 2013 17:42:56 +0800
Message-ID: <1364204579-13307-2-git-send-email-kliu5@marvell.com>
References: <1364204579-13307-1-git-send-email-kliu5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:45131 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757867Ab3CYJm1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Mar 2013 05:42:27 -0400
In-Reply-To: <1364204579-13307-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chunhe Lan <Chunhe.Lan@freescale.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

sdhci_pltfm_init can set host->ops and host->quirks if sdhci_pltfm_data
is transfered as arguments. Then no need to set them manually in
sdhci_pxav3_probe.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 5663a6e..14437fc 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -174,6 +174,14 @@ static const struct sdhci_ops pxav3_sdhci_ops = {
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

