From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v10 12/12] mmc: sdhci-pxav3: add regulator notifier for vqmmc
Date: Mon, 17 Dec 2012 19:22:08 +0800
Message-ID: <1355743328-17758-13-git-send-email-kliu5@marvell.com>
References: <1355743328-17758-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:58053 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752321Ab2LQLXI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Dec 2012 06:23:08 -0500
In-Reply-To: <1355743328-17758-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, arindam.nath@amd.com, peppe.cavallaro@st.com, ulf.hansson@linaro.org, andriy.shevchenko@linux.intel.com, prakity@nvidia.com
Cc: zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com, Kevin Liu <kliu5@marvell.com>

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c          |    2 ++
 include/linux/platform_data/pxa_sdhci.h |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index a308598..d2fb16e 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -258,6 +258,8 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 				goto err_cd_req;
 			}
 		}
+		if (pdata->nb_vqmmc)
+			host->nb_vqmmc = pdata->nb_vqmmc;
 	}
 
 	host->ops = &pxav3_sdhci_ops;
diff --git a/include/linux/platform_data/pxa_sdhci.h b/include/linux/platform_data/pxa_sdhci.h
index 27d3156..86e027b 100644
--- a/include/linux/platform_data/pxa_sdhci.h
+++ b/include/linux/platform_data/pxa_sdhci.h
@@ -40,6 +40,7 @@
  * @quirks: quirks of platfrom
  * @quirks2: quirks2 of platfrom
  * @pm_caps: pm_caps of platfrom
+ * @nb_vqmmc: regulator notifier for vqmmc
  */
 struct sdhci_pxa_platdata {
 	unsigned int	flags;
@@ -54,6 +55,7 @@ struct sdhci_pxa_platdata {
 	unsigned int	quirks;
 	unsigned int	quirks2;
 	unsigned int	pm_caps;
+	struct notifier_block	*nb_vqmmc;
 };
 
 struct sdhci_pxa {
-- 
1.7.0.4

