From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v3 2/2]  mmc: sdhci-s3c: add platform data for the second
 capability
Date: Mon, 06 Feb 2012 16:52:58 +0900
Message-ID: <4F2F86DA.6030106@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:52642 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050Ab2BFHxF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Feb 2012 02:53:05 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, 'kgene kim' <kgene.kim@samsung.com>, Girish K S <girish.shivananjappa@linaro.org>

This patch is added host_caps2 in sdhci-s3c.c
It's necessary that use the second capabilities.
And removed the duplicated host_caps.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Changelog v3:
	- based-on latest mmc-next tree
Changelog v2:
	- remove the duplicated host_caps.

 drivers/mmc/host/sdhci-s3c.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index d065e37..46b9782 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -521,9 +521,6 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	if (pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
 		host->mmc->caps = MMC_CAP_NONREMOVABLE;
 
-	if (pdata->host_caps)
-		host->mmc->caps |= pdata->host_caps;
-
 	if (pdata->pm_caps)
 		host->mmc->pm_caps |= pdata->pm_caps;
 
@@ -547,6 +544,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	if (pdata->host_caps)
 		host->mmc->caps |= pdata->host_caps;
 
+	if (pdata->host_caps2)
+		host->mmc->caps2 |= pdata->host_caps2;
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(dev, "sdhci_add_host() failed\n");
-- 
1.7.4.1
