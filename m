From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/6] mmc: dw_mmc: deprecated the "num-slots" property
Date: Mon, 05 Jun 2017 13:41:30 +0900
Message-ID: <20170605044135.18304-2-jh80.chung@samsung.com>
References: <20170605044135.18304-1-jh80.chung@samsung.com>
        <CGME20170605044137epcas1p408ff8655bcf8084e758f358ff0ed632e@epcas1p4.samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:62593 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbdFEEll (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jun 2017 00:41:41 -0400
In-reply-to: <20170605044135.18304-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

dwmmc controller is supporting only one slot per a IP.
Even though DWMMC IP is provided the multiple slot, but there is no
usage in real world.
In mmc subsystem, not allow the multiple slot concept.
Then "num-slots" property is deprecated.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4a0841c..a66edd0 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2973,7 +2973,8 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	}
 
 	/* find out number of slots supported */
-	device_property_read_u32(dev, "num-slots", &pdata->num_slots);
+	if (device_property_read_u32(dev, "num-slots", &pdata->num_slots))
+		dev_info(dev, "'num-slots' was deprecated.\n");
 
 	if (device_property_read_u32(dev, "fifo-depth", &pdata->fifo_depth))
 		dev_info(dev,
@@ -3203,18 +3204,12 @@ int dw_mci_probe(struct dw_mci *host)
 	if (ret)
 		goto err_dmaunmap;
 
-	if (host->pdata->num_slots)
-		host->num_slots = host->pdata->num_slots;
-	else
-		host->num_slots = 1;
-
-	if (host->num_slots < 1 ||
-	    host->num_slots > SDMMC_GET_SLOT_NUM(mci_readl(host, HCON))) {
-		dev_err(host->dev,
-			"Platform data must supply correct num_slots.\n");
-		ret = -ENODEV;
-		goto err_clk_ciu;
-	}
+	/*
+	 * Even though dwmmc IP is provided the multiple slots,
+	 * there is no use case in mmc subsystem.
+	 * dwmmc host controller needs to initialize the one slot per an IP.
+	 */
+	host->num_slots = 1;
 
 	/*
 	 * Enable interrupts for command done, data over, data empty,
-- 
2.10.2

