From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/2] mmc: dw-mmc: check the host->bus_hz before calling
Date: Mon, 18 Feb 2013 19:12:03 +0900
Message-ID: <5121FE73.5010206@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:18921 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751Ab3BRKMA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Feb 2013 05:12:00 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MIE00DRCUYU7101@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 18 Feb 2013 19:11:58 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MIE00FJQUZYFIE0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 18 Feb 2013 19:11:58 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>

Check whether host->bus_hz is zero or not. before calling drv_data->setup_clock.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 60063cc..c59078c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2203,6 +2203,13 @@ int dw_mci_probe(struct dw_mci *host)
 	else
 		host->bus_hz = clk_get_rate(host->ciu_clk);
 
+	if (!host->bus_hz) {
+		dev_err(host->dev,
+			"Platform data must supply bus speed\n");
+		ret = -ENODEV;
+		goto err_clk_ciu;
+	}
+
 	if (drv_data && drv_data->setup_clock) {
 		ret = drv_data->setup_clock(host);
 		if (ret) {
@@ -2212,13 +2219,6 @@ int dw_mci_probe(struct dw_mci *host)
 		}
 	}
 
-	if (!host->bus_hz) {
-		dev_err(host->dev,
-			"Platform data must supply bus speed\n");
-		ret = -ENODEV;
-		goto err_clk_ciu;
-	}
-
 	host->quirks = host->pdata->quirks;
 
 	spin_lock_init(&host->lock);
-- 
1.7.9.5
