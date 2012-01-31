From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/2] mmc: sdhci-s3c: support the broken voltage.
Date: Tue, 31 Jan 2012 15:55:55 +0900
Message-ID: <4F27907B.10103@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:21396 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab2AaG4U (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2012 01:56:20 -0500
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LYN00BKTHSRNT90@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 31 Jan 2012 15:56:03 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LYN008E8HXELS20@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 31 Jan 2012 15:56:03 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, m.szyprowski@samsung.com

Samsung-SoC need to add the MMC_CAP2_BROKEN_VOLTAGE.


Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index d065e37..e7e2b6b 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -521,9 +521,12 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	if (pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
 		host->mmc->caps = MMC_CAP_NONREMOVABLE;
 
+	/* It supports additional host capabilities if needed */
 	if (pdata->host_caps)
 		host->mmc->caps |= pdata->host_caps;
 
+	host->mmc->caps2 = MMC_CAP2_BROKEN_VOLTAGE;
+
 	if (pdata->pm_caps)
 		host->mmc->pm_caps |= pdata->pm_caps;
 
@@ -543,10 +546,6 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 		sdhci_s3c_ops.get_max_clock = sdhci_cmu_get_max_clock;
 	}
 
-	/* It supports additional host capabilities if needed */
-	if (pdata->host_caps)
-		host->mmc->caps |= pdata->host_caps;
-
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(dev, "sdhci_add_host() failed\n");
