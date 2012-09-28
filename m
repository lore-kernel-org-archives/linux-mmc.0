From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v5 10/13] mmc: sdhci-pxav3: add quirks2
Date: Fri, 28 Sep 2012 15:56:09 +0800
Message-ID: <1348818972-26711-11-git-send-email-keyuan.liu@gmail.com>
References: <1348818972-26711-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:47607 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756777Ab2I1ICD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Sep 2012 04:02:03 -0400
In-Reply-To: <1348818972-26711-1-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

From: Kevin Liu <kliu5@marvell.com>

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c          |    2 ++
 include/linux/platform_data/pxa_sdhci.h |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index ccd1906..60829c9 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -280,6 +280,8 @@ static int __devinit sdhci_pxav3_probe(struct platform_device *pdev)
 
 		if (pdata->quirks)
 			host->quirks |= pdata->quirks;
+		if (pdata->quirks2)
+			host->quirks2 |= pdata->quirks2;
 		if (pdata->host_caps)
 			host->mmc->caps |= pdata->host_caps;
 		if (pdata->host_caps2)
diff --git a/include/linux/platform_data/pxa_sdhci.h b/include/linux/platform_data/pxa_sdhci.h
index 59acd98..fdf38d6 100644
--- a/include/linux/platform_data/pxa_sdhci.h
+++ b/include/linux/platform_data/pxa_sdhci.h
@@ -38,6 +38,7 @@
  * @max_speed: the maximum speed supported
  * @host_caps: Standard MMC host capabilities bit field.
  * @quirks: quirks of platfrom
+ * @quirks2: quirks2 of platfrom
  * @pm_caps: pm_caps of platfrom
  */
 struct sdhci_pxa_platdata {
@@ -51,6 +52,7 @@ struct sdhci_pxa_platdata {
 	unsigned int	host_caps;
 	unsigned int	host_caps2;
 	unsigned int	quirks;
+	unsigned int	quirks2;
 	unsigned int	pm_caps;
 };
 
-- 
1.7.0.4

