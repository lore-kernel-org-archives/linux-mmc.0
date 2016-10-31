From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/2] mmc: dw_mmc: add the "reset" as name of reset controller
Date: Mon, 31 Oct 2016 11:49:42 +0900
Message-ID: <20161031024942.4415-3-jh80.chung@samsung.com>
References: <20161031024942.4415-1-jh80.chung@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20161031024942.4415-1-jh80.chung@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, john.stultz@linaro.org, guodong.xu@linaro.org, leo.yan@linaro.org, vincent.guittot@linaro.org, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Add the "reset" as name of reset controller.
This is for preventing the wrong operation. Even if some SoC has reset
controller, doesn't define "resets" in device-tree.
Then it might be waiting for reset controller and it should be stuck.

Fixes: d6786fefe816 ("mmc: dw_mmc: add reset support to dwmmc host controller")

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1c9ee36..a16c537 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2940,7 +2940,7 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 		return ERR_PTR(-ENOMEM);
 
 	/* find reset controller when exist */
-	pdata->rstc = devm_reset_control_get_optional(dev, NULL);
+	pdata->rstc = devm_reset_control_get_optional(dev, "reset");
 	if (IS_ERR(pdata->rstc)) {
 		if (PTR_ERR(pdata->rstc) == -EPROBE_DEFER)
 			return ERR_PTR(-EPROBE_DEFER);
-- 
2.10.1
