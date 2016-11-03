From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 03/13] mmc: dw_mmc: change the DW_MCI_FREQ_MIN from 400K to 100K
Date: Thu, 03 Nov 2016 15:21:25 +0900
Message-ID: <20161103062135.10697-4-jh80.chung@samsung.com>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20161103062135.10697-1-jh80.chung@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, ulf.hansson@linaro.org, robh+dt@kernel.org, krzk@kernel.org, heiko@sntech.de, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

If there is no property "clock-freq-min-max", mmc->f_min should be set
to 400K by default. But Some SoC can be used 100K.
When 100K is used, MMC core will try to check from 400K to 100K.

Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1e71fd4..6ccb817 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -54,7 +54,7 @@
 #define DW_MCI_DMA_THRESHOLD	16
 
 #define DW_MCI_FREQ_MAX	200000000	/* unit: HZ */
-#define DW_MCI_FREQ_MIN	400000		/* unit: HZ */
+#define DW_MCI_FREQ_MIN	100000		/* unit: HZ */
 
 #define IDMAC_INT_CLR		(SDMMC_IDMAC_INT_AI | SDMMC_IDMAC_INT_NI | \
 				 SDMMC_IDMAC_INT_CES | SDMMC_IDMAC_INT_DU | \
-- 
2.10.1
