From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 3/4] mmc: sdhci-esdhc-imx: pdev->id_entry should be immutable
Date: Thu, 17 Oct 2013 15:19:46 +0800
Message-ID: <1381994387-9656-4-git-send-email-shawn.guo@linaro.org>
References: <1381994387-9656-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0187.outbound.messaging.microsoft.com ([213.199.154.187]:27237
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751984Ab3JQHTd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Oct 2013 03:19:33 -0400
In-Reply-To: <1381994387-9656-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Dong Aisheng <b29396@freescale.com>, Chris Ball <cjb@laptop.org>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>

As a good practice, device driver should not modify pdev->id_entry but
keep it immutable.  Let's assign of_device_id.data with imx_esdhc_type
constants directly, so that we do not have to manipulate pdev->id_entry
in .probe().

As the result, sdhci-esdhc-imx53 and sdhci-usdhc-imx6q can be removed
from platform_device_id table now, since they will only probe from
device tree.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 2421ac7..83023fa 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -134,23 +134,17 @@ static struct platform_device_id imx_esdhc_devtype[] = {
 		.name = "sdhci-esdhc-imx51",
 		.driver_data = IMX51_ESDHC,
 	}, {
-		.name = "sdhci-esdhc-imx53",
-		.driver_data = IMX53_ESDHC,
-	}, {
-		.name = "sdhci-usdhc-imx6q",
-		.driver_data = IMX6Q_USDHC,
-	}, {
 		/* sentinel */
 	}
 };
 MODULE_DEVICE_TABLE(platform, imx_esdhc_devtype);
 
 static const struct of_device_id imx_esdhc_dt_ids[] = {
-	{ .compatible = "fsl,imx25-esdhc", .data = &imx_esdhc_devtype[IMX25_ESDHC], },
-	{ .compatible = "fsl,imx35-esdhc", .data = &imx_esdhc_devtype[IMX35_ESDHC], },
-	{ .compatible = "fsl,imx51-esdhc", .data = &imx_esdhc_devtype[IMX51_ESDHC], },
-	{ .compatible = "fsl,imx53-esdhc", .data = &imx_esdhc_devtype[IMX53_ESDHC], },
-	{ .compatible = "fsl,imx6q-usdhc", .data = &imx_esdhc_devtype[IMX6Q_USDHC], },
+	{ .compatible = "fsl,imx25-esdhc", .data = (void *) IMX25_ESDHC, },
+	{ .compatible = "fsl,imx35-esdhc", .data = (void *) IMX35_ESDHC, },
+	{ .compatible = "fsl,imx51-esdhc", .data = (void *) IMX51_ESDHC, },
+	{ .compatible = "fsl,imx53-esdhc", .data = (void *) IMX53_ESDHC, },
+	{ .compatible = "fsl,imx6q-usdhc", .data = (void *) IMX6Q_USDHC, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
@@ -867,9 +861,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		goto free_sdhci;
 	}
 
-	if (of_id)
-		pdev->id_entry = of_id->data;
-	imx_data->devtype = pdev->id_entry->driver_data;
+	imx_data->devtype = of_id ? (enum imx_esdhc_type) of_id->data :
+				    pdev->id_entry->driver_data;
 	pltfm_host->priv = imx_data;
 
 	if (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_data))
-- 
1.7.9.5


