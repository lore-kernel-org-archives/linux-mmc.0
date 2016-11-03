From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 09/13] mmc: dw_mmc: remove the "clock-freq-min-max" property
Date: Thu, 03 Nov 2016 15:21:31 +0900
Message-ID: <20161103062135.10697-10-jh80.chung@samsung.com>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:36274 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754290AbcKCGV5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Nov 2016 02:21:57 -0400
In-reply-to: <20161103062135.10697-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, ulf.hansson@linaro.org, robh+dt@kernel.org, krzk@kernel.org, heiko@sntech.de, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

Remove the "clock-freq-min-max" property.
There is "max-frequency" property in drivers/mmc/core/host.c
It can be used for getting maximum frequency.

And minimum clock value is assigned to 100K by default.
Because MMC core should check the initial clock value from
400K to 100K until finding correct value.
It's why Minimum value puts 100K by default.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt |  3 ---
 drivers/mmc/host/dw_mmc.c                                  | 13 ++++---------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index 4e00e85..21c8251 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
@@ -56,9 +56,6 @@ Optional properties:
   is specified and the ciu clock is specified then we'll try to set the ciu
   clock to this at probe time.
 
-* clock-freq-min-max: Minimum and Maximum clock frequency for card output
-  clock(cclk_out). If it's not specified, max is 200MHZ and min is 400KHz by default.
-
 * num-slots: specifies the number of slots supported by the controller.
   The number of physical slots actually used could be equal or less than the
   value specified by num-slots. If this property is not specified, the value
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index bd8c5ea..a0c5a85 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2589,7 +2589,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	struct dw_mci_slot *slot;
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int ctrl_id, ret;
-	u32 freq[2];
 
 	mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), host->dev);
 	if (!mmc)
@@ -2603,14 +2602,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	host->slot[id] = slot;
 
 	mmc->ops = &dw_mci_ops;
-	if (of_property_read_u32_array(host->dev->of_node,
-				       "clock-freq-min-max", freq, 2)) {
-		mmc->f_min = DW_MCI_FREQ_MIN;
-		mmc->f_max = DW_MCI_FREQ_MAX;
-	} else {
-		mmc->f_min = freq[0];
-		mmc->f_max = freq[1];
-	}
 
 	/*if there are external regulators, get them*/
 	ret = mmc_regulator_get_supply(mmc);
@@ -2649,6 +2640,10 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (ret)
 		goto err_host_allocated;
 
+	mmc->f_min = DW_MCI_FREQ_MIN;
+	if (!mmc->f_max)
+		mmc->f_max = DW_MCI_FREQ_MAX;
+
 	/* Useful defaults if platform data is unset. */
 	if (host->use_dma == TRANS_MODE_IDMAC) {
 		mmc->max_segs = host->ring_size;
-- 
2.10.1

