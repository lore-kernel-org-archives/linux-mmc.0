From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 3/3] mmc: sdhci-pxav3: remove cd-broken quirk for permanently present card
Date: Fri,  1 Mar 2013 17:41:44 +0800
Message-ID: <1362130904-9138-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:56647 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751246Ab3CAJlg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Mar 2013 04:41:36 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

For permanently present card, cd-broken quirk should _not_ be selected.
Otherwise polling will be used to detect the card.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 55d0784..da3952d 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -268,11 +268,9 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 		pdata = pxav3_get_mmc_pdata(dev);
 
 	if (pdata) {
-		if (pdata->flags & PXA_FLAG_CARD_PERMANENT) {
-			/* on-chip device */
-			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+		/* on-chip device */
+		if (pdata->flags & PXA_FLAG_CARD_PERMANENT)
 			host->mmc->caps |= MMC_CAP_NONREMOVABLE;
-		}
 
 		/* If slot design supports 8 bit data, indicate this to MMC. */
 		if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
-- 
1.7.9.5

