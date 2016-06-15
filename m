From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC 3/4] mmc: renesas_sdhi: rename DMA source file as renesas_sdhi_dma.c
Date: Wed, 15 Jun 2016 13:01:56 +0900
Message-ID: <1465963317-28672-4-git-send-email-horms+renesas@verge.net.au>
References: <1465963317-28672-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1465963317-28672-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Rename the source file for DMA for Renesas SDHI as a follow-up to attaching
DMA code to the renesas_sdhi driver rather than the tmio_core driver.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/mmc/host/Makefile                               | 2 +-
 drivers/mmc/host/{tmio_mmc_dma.c => renesas_sdhi_dma.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/mmc/host/{tmio_mmc_dma.c => renesas_sdhi_dma.c} (100%)

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 4f7903fbef26..0ea7fb6f3d5e 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -38,7 +38,7 @@ obj-$(CONFIG_MMC_TMIO)		+= tmio_mmc.o
 obj-$(CONFIG_MMC_TMIO_CORE)	+= tmio_mmc_core.o
 tmio_mmc_core-y			:= tmio_mmc_pio.o
 obj-$(CONFIG_MMC_SDHI)		+= renesas_sdhi.o
-renesas_sdhi-$(subst m,y,$(CONFIG_MMC_SDHI_DMA))	+= tmio_mmc_dma.o
+renesas_sdhi-$(subst m,y,$(CONFIG_MMC_SDHI_DMA))	+= renesas_sdhi_dma.o
 obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
 obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/renesas_sdhi_dma.c
similarity index 100%
rename from drivers/mmc/host/tmio_mmc_dma.c
rename to drivers/mmc/host/renesas_sdhi_dma.c
-- 
2.1.4
