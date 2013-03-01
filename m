From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 1/3] mmc: sdhci: add quirks2 in sdhci_pltfm_init
Date: Fri,  1 Mar 2013 17:41:02 +0800
Message-ID: <1362130862-20967-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:39508 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751246Ab3CAJk3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Mar 2013 04:40:29 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    4 +++-
 drivers/mmc/host/sdhci-pltfm.h |    1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 3145a78..e605509 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -149,8 +149,10 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		host->ops = pdata->ops;
 	else
 		host->ops = &sdhci_pltfm_ops;
-	if (pdata)
+	if (pdata) {
 		host->quirks = pdata->quirks;
+		host->quirks2 = pdata->quirks2;
+	}
 	host->irq = platform_get_irq(pdev, 0);
 
 	if (!request_mem_region(iomem->start, resource_size(iomem),
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 153b6c5..2940ee3 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -18,6 +18,7 @@
 struct sdhci_pltfm_data {
 	struct sdhci_ops *ops;
 	unsigned int quirks;
+	unsigned int quirks2;
 };
 
 struct sdhci_pltfm_host {
-- 
1.7.9.5

