From: Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH 2/2] mmc: dw_mmc: add resets support to dw_mci_parse_dt()
Date: Thu,  3 Mar 2016 09:33:38 +0800
Message-ID: <1456968818-22140-2-git-send-email-guodong.xu@linaro.org>
References: <1456968818-22140-1-git-send-email-guodong.xu@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456968818-22140-1-git-send-email-guodong.xu@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, jh80.chung@samsung.com, ulf.hansson@linaro.org, shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Guodong Xu <guodong.xu@linaro.org>, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Zhangfei Gao <zhangfei.gao@linaro.org>
List-Id: linux-mmc@vger.kernel.org

With this, user can add a 'resets' property into dw_mmc dts
node, and when driver probe and parse_dt, it will call
reset APIs to reset dw_mmc host controller.

Please also refer to Documentation/devicetree/bindings/reset/reset.txt

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/mmc/host/dw_mmc.c  | 7 +++++++
 include/linux/mmc/dw_mmc.h | 6 ++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 242f9a0..d3a7376 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2878,6 +2878,13 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
+	/* find reset controller when exist */
+	pdata->rstc = devm_reset_control_get_optional(dev, NULL);
+	if (IS_ERR(pdata->rstc))
+		pdata->rstc = NULL;
+	else
+		reset_control_deassert(pdata->rstc);
+
 	/* find out number of slots supported */
 	of_property_read_u32(np, "num-slots", &pdata->num_slots);
 
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 7b41c6d..b95cd84 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -14,9 +14,10 @@
 #ifndef LINUX_MMC_DW_MMC_H
 #define LINUX_MMC_DW_MMC_H
 
-#include <linux/scatterlist.h>
-#include <linux/mmc/core.h>
 #include <linux/dmaengine.h>
+#include <linux/mmc/core.h>
+#include <linux/reset.h>
+#include <linux/scatterlist.h>
 
 #define MAX_MCI_SLOTS	2
 
@@ -260,6 +261,7 @@ struct dw_mci_board {
 	/* delay in mS before detecting cards after interrupt */
 	u32 detect_delay_ms;
 
+	struct reset_control *rstc;
 	struct dw_mci_dma_ops *dma_ops;
 	struct dma_pdata *data;
 };
-- 
1.9.1
