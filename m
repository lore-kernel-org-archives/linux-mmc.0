From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 3/7] mmc: dw_mmc: replace the bus_hz checking point
Date: Tue, 21 Jan 2014 19:16:56 +0900
Message-ID: <52DE4918.9080701@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:12979 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031AbaAUKQd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jan 2014 05:16:33 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZQ00LTNXVKTK60@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 21 Jan 2014 19:16:32 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>

It's right that check immediately whether host->bus_hz is assigned or not.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c915293..3970fc3 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2115,7 +2115,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int ctrl_id, ret;
 	u32 freq[2];
-	u8 bus_width;
 
 	mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), host->dev);
 	if (!mmc)
@@ -2428,12 +2427,19 @@ int dw_mci_probe(struct dw_mci *host)
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
@@ -2470,13 +2476,6 @@ int dw_mci_probe(struct dw_mci *host)
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
@@ -2620,8 +2619,6 @@ err_workqueue:
 err_dmaunmap:
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
-
-err_regulator:
 	if (host->vmmc)
 		regulator_disable(host->vmmc);
 
-- 
1.7.9.5
