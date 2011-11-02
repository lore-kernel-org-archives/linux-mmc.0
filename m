From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH 4/6] mmc: sdhci-s3c: Keep a copy of platform data and use it
Date: Thu, 03 Nov 2011 02:06:01 +0530
Message-ID: <1320266163-15292-5-git-send-email-thomas.abraham@linaro.org>
References: <1320266163-15292-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46413 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab1KBUdr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Nov 2011 16:33:47 -0400
In-reply-to: <1320266163-15292-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org

The platform data is copied into driver's private data and the copy is
used for all access to the platform data. This simpifies the addition
of device tree support for the sdhci-s3c driver.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/mmc/host/sdhci-s3c.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 141fbbf..c77ec42 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -424,7 +424,7 @@ static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
 
 static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 {
-	struct s3c_sdhci_platdata *pdata = pdev->dev.platform_data;
+	struct s3c_sdhci_platdata *pdata;
 	struct sdhci_s3c_drv_data *drv_data;
 	struct device *dev = &pdev->dev;
 	struct sdhci_host *host;
@@ -432,7 +432,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret, irq, ptr, clks;
 
-	if (!pdata) {
+	if (!pdev->dev.platform_data) {
 		dev_err(dev, "no device data specified\n");
 		return -ENOENT;
 	}
@@ -455,6 +455,13 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 		return PTR_ERR(host);
 	}
 
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		ret = -ENOMEM;
+		goto err_io_clk;
+	}
+	memcpy(pdata, pdev->dev.platform_data, sizeof(*pdata));
+
 	drv_data = sdhci_s3c_get_driver_data(pdev);
 	sc = sdhci_priv(host);
 
-- 
1.6.6.rc2

