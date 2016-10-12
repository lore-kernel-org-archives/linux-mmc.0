From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 4/9] mmc: dw_mmc: disable biu clk if possible
Date: Wed, 12 Oct 2016 10:50:38 +0800
Message-ID: <1476240643-5701-5-git-send-email-shawn.lin@rock-chips.com>
References: <1476240643-5701-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.136]:50366 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbcJLCqj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Oct 2016 22:46:39 -0400
In-Reply-To: <1476240643-5701-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>

We could disable biu clk if gpio card detect available,
or it is a non-removable device.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc-rockchip.c |  1 +
 drivers/mmc/host/dw_mmc.c          | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 0a05ad3..9a46e46 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -13,6 +13,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/dw_mmc.h>
 #include <linux/of_address.h>
+#include <linux/mmc/slot-gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 67fa088..297b6c2 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3336,6 +3336,11 @@ int dw_mci_runtime_suspend(struct device *dev)
 
 	clk_disable_unprepare(host->ciu_clk);
 
+	if (host->cur_slot &&
+	    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
+	     !mmc_card_is_removable(host->cur_slot->mmc)))
+		clk_disable_unprepare(host->biu_clk);
+
 	return err;
 }
 EXPORT_SYMBOL(dw_mci_runtime_suspend);
@@ -3345,6 +3350,14 @@ int dw_mci_runtime_resume(struct device *dev)
 	int ret = 0;
 	struct dw_mci *host = dev_get_drvdata(dev);
 
+	if (host->cur_slot &&
+	    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
+	     !mmc_card_is_removable(host->cur_slot->mmc))) {
+		ret = clk_prepare_enable(host->biu_clk);
+		if (ret)
+			return ret;
+	}
+
 	ret = clk_prepare_enable(host->ciu_clk);
 	if (ret)
 		return ret;
-- 
2.3.7


