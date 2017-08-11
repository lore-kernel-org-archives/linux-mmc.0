From: Li Wei <liwei213@huawei.com>
Subject: [PATCH v10 1/2] mmc: dw_mmc: move controller reset before driver init
Date: Fri, 11 Aug 2017 16:06:23 +0800
Message-ID: <20170811080624.42173-1-liwei213@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:3064 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbdHKIGc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Aug 2017 04:06:32 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, jh80.chung@samsung.com, shawn.lin@rock-chips.com, wsa+renesas@sang-engineering.com, hkallweit1@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: guodong.xu@linaro.org

This commit modifies dw_mci_probe(), it moves reset assertion before
drv_data->init(host)

Some driver needs to access controller registers in its .init() ops. So,
in order to make such access safe, we should do controller reset before
.init() being called.

Signed-off-by: Wei Li <liwei213@huawei.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Signed-off-by: Chen Jun <chenjun14@huawei.com>
---
 drivers/mmc/host/dw_mmc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a9dfb26972f2..f2fa928e1a12 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3067,6 +3067,12 @@ int dw_mci_probe(struct dw_mci *host)
 		goto err_clk_ciu;
 	}
 
+	if (!IS_ERR(host->pdata->rstc)) {
+		reset_control_assert(host->pdata->rstc);
+		usleep_range(10, 50);
+		reset_control_deassert(host->pdata->rstc);
+	}
+
 	if (drv_data && drv_data->init) {
 		ret = drv_data->init(host);
 		if (ret) {
@@ -3076,12 +3082,6 @@ int dw_mci_probe(struct dw_mci *host)
 		}
 	}
 
-	if (!IS_ERR(host->pdata->rstc)) {
-		reset_control_assert(host->pdata->rstc);
-		usleep_range(10, 50);
-		reset_control_deassert(host->pdata->rstc);
-	}
-
 	setup_timer(&host->cmd11_timer,
 		    dw_mci_cmd11_timer, (unsigned long)host);
 
-- 
2.11.0

