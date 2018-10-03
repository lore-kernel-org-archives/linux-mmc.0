From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] mmc: renesas_sdhi: rename DTRAN_MODE_BUS_WID_TH to DTRAN_MODE_BUS_WIDTH
Date: Wed,  3 Oct 2018 20:39:40 +0900
Message-ID: <1538566780-30794-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Socionext UniPhier SoCs use the almost the same internal DMAC.
My datasheet says 'BUS_WIDTH' instead of 'BUS_WID_TH'.  I suspect
this is a typo.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index ca0b439..8d04eea 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -36,7 +36,7 @@
 /* DM_CM_DTRAN_MODE */
 #define DTRAN_MODE_CH_NUM_CH0	0	/* "downstream" = for write commands */
 #define DTRAN_MODE_CH_NUM_CH1	BIT(16)	/* "uptream" = for read commands */
-#define DTRAN_MODE_BUS_WID_TH	(BIT(5) | BIT(4))
+#define DTRAN_MODE_BUS_WIDTH	(BIT(5) | BIT(4))
 #define DTRAN_MODE_ADDR_MODE	BIT(0)	/* 1 = Increment address */
 
 /* DM_CM_DTRAN_CTRL */
@@ -174,7 +174,7 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_host *host,
 				     struct mmc_data *data)
 {
 	struct scatterlist *sg = host->sg_ptr;
-	u32 dtran_mode = DTRAN_MODE_BUS_WID_TH | DTRAN_MODE_ADDR_MODE;
+	u32 dtran_mode = DTRAN_MODE_BUS_WIDTH | DTRAN_MODE_ADDR_MODE;
 
 	if (!dma_map_sg(&host->pdev->dev, sg, host->sg_len,
 			mmc_get_dma_dir(data)))
-- 
2.7.4
