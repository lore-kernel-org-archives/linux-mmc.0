From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv3 8/9] mmc: dw_mmc: The "clock-freq-min-max" property was
 deprecated
Date: Thu, 17 Nov 2016 16:40:40 +0900
Message-ID: <20161117074041.8641-9-jh80.chung@samsung.com>
References: <20161117074041.8641-1-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:58231 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752233AbcKQHlB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2016 02:41:01 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OGR01SAEZZO5X60@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 17 Nov 2016 16:40:43 +0900 (KST)
In-reply-to: <20161117074041.8641-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, adrian.hunter@intel.com, Jaehoon Chung <jh80.chung@samsung.com>

The "clock-freq-min-max" property was deprecated.
There is "max-frequency" property in drivers/mmc/core/host.c
"max-frequency" can be replaced with "clock-freq-min-max".
Minimum clock value might be set to 100K by default.
Then MMC core should try to find the correct value from 400K to 100K.
So it just needs to set Maximum clock value.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 3 ++-
 drivers/mmc/host/dw_mmc.c                                  | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index bfa461a..1279a22 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
@@ -59,8 +59,9 @@ Optional properties:
   is specified and the ciu clock is specified then we'll try to set the ciu
   clock to this at probe time.
 
-* clock-freq-min-max: Minimum and Maximum clock frequency for card output
+* clock-freq-min-max (DEPRECATED): Minimum and Maximum clock frequency for card output
   clock(cclk_out). If it's not specified, max is 200MHZ and min is 400KHz by default.
+	  (Use the "max-frequency" instead of "clock-freq-min-max".)
 
 * num-slots: specifies the number of slots supported by the controller.
   The number of physical slots actually used could be equal or less than the
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 40afb45..3638364 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2608,6 +2608,8 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 		mmc->f_min = DW_MCI_FREQ_MIN;
 		mmc->f_max = DW_MCI_FREQ_MAX;
 	} else {
+		dev_info(host->dev,
+			"'clock-freq-min-max' property was deprecated.\n");
 		mmc->f_min = freq[0];
 		mmc->f_max = freq[1];
 	}
-- 
2.10.1

