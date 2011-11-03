From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv2 2/2]  mmc: sdhci-s3c: add platform data for the second
 capability
Date: Thu, 03 Nov 2011 11:35:59 +0900
Message-ID: <4EB1FE0F.5020608@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, 'kgene kim' <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

This patch is added host_caps2 in sdhci-s3c.c
It's necessary that use the second capabilities.
And removed the duplicated host_caps.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Changelog v2:
   - remove the duplicated host_caps.

 drivers/mmc/host/sdhci-s3c.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 3d00e72..6b8f8f6 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -521,9 +521,6 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	if (pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
 		host->mmc->caps = MMC_CAP_NONREMOVABLE;
 
-	if (pdata->host_caps)
-		host->mmc->caps |= pdata->host_caps;
-
 	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
 			 SDHCI_QUIRK_32BIT_DMA_SIZE);
 
@@ -544,6 +541,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	if (pdata->host_caps)
 		host->mmc->caps |= pdata->host_caps;
 
+	if (pdata->host_caps2)
+		host->mmc->caps2 |= pdata->host_caps2;
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(dev, "sdhci_add_host() failed\n");
