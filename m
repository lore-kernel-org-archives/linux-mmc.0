From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v4 2/7] mmc: dw_mmc: replace the bus_hz checking point
Date: Mon, 03 Mar 2014 11:36:42 +0900
Message-ID: <5313EABA.8020103@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:16029 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbaCCCgT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 2 Mar 2014 21:36:19 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1U002L89WHIWB0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 03 Mar 2014 11:36:17 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>

It's right that check immediately whether host->bus_hz is assigned or not.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changelog V4:
	- Fixed the compile warning.
Changelog V3:
	- Maintained original place for the drv_data->setup_clock
Changelog V2:
	- When drv_data->setup_clock is present, set to bus_hz with it.

 drivers/mmc/host/dw_mmc.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 8193e21..3970fc3 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2427,12 +2427,19 @@ int dw_mci_probe(struct dw_mci *host)
 			ret = clk_set_rate(host->ciu_clk, host->pdata->bus_hz);
 			if (ret)
 				dev_warn(host->dev,
-					 "Unable to set bus rate to %ul\n",
+					 "Unable to set bus rate to %uHz\n",
 					 host->pdata->bus_hz);
 		}
 		host->bus_hz = clk_get_rate(host->ciu_clk);
 	}
 
+	if (!host->bus_hz) {
+		dev_err(host->dev,
+			"Platform data must supply bus speed\n");
+		ret = -ENODEV;
+		goto err_clk_ciu;
+	}
+
 	if (drv_data && drv_data->init) {
 		ret = drv_data->init(host);
 		if (ret) {
@@ -2469,13 +2476,6 @@ int dw_mci_probe(struct dw_mci *host)
 		}
 	}
 
-	if (!host->bus_hz) {
-		dev_err(host->dev,
-			"Platform data must supply bus speed\n");
-		ret = -ENODEV;
-		goto err_regulator;
-	}
-
 	host->quirks = host->pdata->quirks;
 
 	spin_lock_init(&host->lock);
@@ -2619,8 +2619,6 @@ err_workqueue:
 err_dmaunmap:
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
-
-err_regulator:
 	if (host->vmmc)
 		regulator_disable(host->vmmc);
 
-- 
1.7.9.5
