From: Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH v5 2/2] mmc: dw_mmc: add reset support to dwmmc host controller
Date: Fri, 12 Aug 2016 16:51:26 +0800
Message-ID: <1470991886-22412-3-git-send-email-guodong.xu@linaro.org>
References: <1470991886-22412-1-git-send-email-guodong.xu@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470991886-22412-1-git-send-email-guodong.xu@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, shawn.lin@rock-chips.com, jh80.chung@samsung.com, robh+dt@kernel.org, mark.rutland@arm.com, ulf.hansson@linaro.org, guodong.xu@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Zhangfei Gao <zhangfei.gao@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Dwmmc host controller may in unknown state when entering kernel boot. One
example is when booting from eMMC, bootloader need initialize MMC host
controller into some state so it can read. In order to make sure MMC host
controller in a clean initial state, this reset support is added.

With this patch, a 'resets' property can be added into dw_mmc device
tree node. The hardware logic is: dwmmc host controller IP receives a reset
signal from a 'reset provider' (eg. power management unit). The 'resets'
property points to this reset signal. So, during dwmmc driver probe,
it can use this signal to reset itself.

Refer to [1] for more information.

[1] Documentation/devicetree/bindings/reset/reset.txt

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/mmc/host/dw_mmc.c  | 23 ++++++++++++++++++++++-
 include/linux/mmc/dw_mmc.h |  2 ++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1b719a6..4dff0ee 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2872,6 +2872,13 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
+	/* find reset controller when exist */
+	pdata->rstc = devm_reset_control_get_optional(dev, NULL);
+	if (IS_ERR(pdata->rstc)) {
+		if (PTR_ERR(pdata->rstc) == -EPROBE_DEFER)
+			return ERR_PTR(-EPROBE_DEFER);
+	}
+
 	/* find out number of slots supported */
 	of_property_read_u32(np, "num-slots", &pdata->num_slots);
 
@@ -2943,7 +2950,9 @@ int dw_mci_probe(struct dw_mci *host)
 
 	if (!host->pdata) {
 		host->pdata = dw_mci_parse_dt(host);
-		if (IS_ERR(host->pdata)) {
+		if (PTR_ERR(host->pdata) == -EPROBE_DEFER) {
+			return -EPROBE_DEFER;
+		} else if (IS_ERR(host->pdata)) {
 			dev_err(host->dev, "platform data not available\n");
 			return -EINVAL;
 		}
@@ -2997,6 +3006,12 @@ int dw_mci_probe(struct dw_mci *host)
 		}
 	}
 
+	if (!IS_ERR(host->pdata->rstc)) {
+		reset_control_assert(host->pdata->rstc);
+		usleep_range(10, 50);
+		reset_control_deassert(host->pdata->rstc);
+	}
+
 	setup_timer(&host->cmd11_timer,
 		    dw_mci_cmd11_timer, (unsigned long)host);
 
@@ -3146,6 +3161,9 @@ err_dmaunmap:
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
+	if (!IS_ERR(host->pdata->rstc))
+		reset_control_assert(host->pdata->rstc);
+
 err_clk_ciu:
 	clk_disable_unprepare(host->ciu_clk);
 
@@ -3176,6 +3194,9 @@ void dw_mci_remove(struct dw_mci *host)
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
+	if (!IS_ERR(host->pdata->rstc))
+		reset_control_assert(host->pdata->rstc);
+
 	clk_disable_unprepare(host->ciu_clk);
 	clk_disable_unprepare(host->biu_clk);
 }
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 83b0edfc..f5af2bd 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -17,6 +17,7 @@
 #include <linux/scatterlist.h>
 #include <linux/mmc/core.h>
 #include <linux/dmaengine.h>
+#include <linux/reset.h>
 
 #define MAX_MCI_SLOTS	2
 
@@ -259,6 +260,7 @@ struct dw_mci_board {
 	/* delay in mS before detecting cards after interrupt */
 	u32 detect_delay_ms;
 
+	struct reset_control *rstc;
 	struct dw_mci_dma_ops *dma_ops;
 	struct dma_pdata *data;
 };
-- 
1.9.1
