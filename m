From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v2 4/4] mmc: dw_mmc-rockchip: disable biu clk and genpd if possible
Date: Fri, 30 Sep 2016 16:48:37 +0800
Message-ID: <1475225317-2815-5-git-send-email-shawn.lin@rock-chips.com>
References: <1475225317-2815-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:50897 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbcI3IrE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Sep 2016 04:47:04 -0400
In-Reply-To: <1475225317-2815-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>

We could disable biu clk and power-off genpd if gpio
card detect available.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-rockchip.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 3ad041c..e7b3b6d 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -13,6 +13,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/dw_mmc.h>
 #include <linux/of_address.h>
+#include <linux/mmc/slot-gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
@@ -366,14 +367,29 @@ static int dw_mci_rockchip_remove(struct platform_device *pdev)
 static int dw_mci_rockchip_runtime_suspend(struct device *dev)
 {
 	struct dw_mci *host = dev_get_drvdata(dev);
+	int ret;
 
-	return dw_mci_runtime_suspend(host);
+	ret = dw_mci_runtime_suspend(host);
+	if (ret)
+		return ret;
+
+	if (mmc_can_gpio_cd(host->slot[0]->mmc)) {
+		clk_disable_unprepare(host->biu_clk);
+		pm_runtime_put(dev);
+	}
+
+	return 0;
 }
 
 static int dw_mci_rockchip_runtime_resume(struct device *dev)
 {
 	struct dw_mci *host = dev_get_drvdata(dev);
 
+	if (mmc_can_gpio_cd(host->slot[0]->mmc)) {
+		pm_runtime_get_sync(dev);
+		clk_prepare_enable(host->biu_clk);
+	}
+
 	return dw_mci_runtime_resume(host);
 }
 #endif /* CONFIG_PM */
-- 
2.3.7


