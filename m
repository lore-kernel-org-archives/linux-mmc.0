From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH RESEND 2/4] mmc: sdhci-pxav3: remove cd-broken quirk for permanently present card
Date: Mon, 25 Mar 2013 17:42:57 +0800
Message-ID: <1364204579-13307-3-git-send-email-kliu5@marvell.com>
References: <1364204579-13307-1-git-send-email-kliu5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:40104 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755548Ab3CYJmu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Mar 2013 05:42:50 -0400
In-Reply-To: <1364204579-13307-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chunhe Lan <Chunhe.Lan@freescale.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

Flag PXA_FLAG_CARD_PERMANENT is set in sdhci_pxa_platdata flags to indicate
that the card is always wired to host, like on-chip emmc, which is
permanently present and don't need detection.
So only MMC_CAP_NONREMOVABLE should be set for this case. But current code
also set SDHCI_QUIRK_BROKEN_CARD_DETECTION, which doesn't make sense.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 14437fc..56d6a2e 100644
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

