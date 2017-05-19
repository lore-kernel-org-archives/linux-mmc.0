From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 6/6] mmc: sdhi: add CMD23 support to R-Car Gen2 & Gen3
Date: Fri, 19 May 2017 15:31:55 +0200
Message-ID: <20170519133155.22945-7-wsa+renesas@sang-engineering.com>
References: <20170519133155.22945-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170519133155.22945-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/renesas_sdhi_sys_dmac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index acc42e0a341129..7eab55adc5b288 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -54,7 +54,8 @@ static struct renesas_sdhi_scc rcar_gen2_scc_taps[] = {
 static const struct renesas_sdhi_of_data of_rcar_gen2_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
 			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
-	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
+			  MMC_CAP_CMD23,
 	.dma_buswidth	= DMA_SLAVE_BUSWIDTH_4_BYTES,
 	.dma_rx_offset	= 0x2000,
 	.scc_offset	= 0x0300,
@@ -73,7 +74,8 @@ static struct renesas_sdhi_scc rcar_gen3_scc_taps[] = {
 static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
 			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
-	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
+			  MMC_CAP_CMD23,
 	.bus_shift	= 2,
 	.scc_offset	= 0x1000,
 	.taps		= rcar_gen3_scc_taps,
-- 
2.11.0
