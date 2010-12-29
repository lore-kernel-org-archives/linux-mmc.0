From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: sh_mmcif: make DMA support by the driver unconditional
Date: Wed, 29 Dec 2010 08:59:25 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1012290852530.14233@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Simplify the driver by removing the possibility to build it without the DMA
support and remove the respective Kconfig parameter.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/Kconfig    |    6 ------
 drivers/mmc/host/sh_mmcif.c |   20 --------------------
 2 files changed, 0 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 859e352..d618e86 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -466,12 +466,6 @@ config MMC_SH_MMCIF
 
 	  This driver supports MMCIF in sh7724/sh7757/sh7372.
 
-config SH_MMCIF_DMA
-	bool "Use DMA for MMCIF"
-	depends on MMC_SH_MMCIF
-	help
-	  Use SH dma-engine driver for data transfer
-
 config MMC_JZ4740
 	tristate "JZ4740 SD/Multimedia Card Interface support"
 	depends on MACH_JZ4740
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index d09a2b3..12884c2 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -184,7 +184,6 @@ static inline void sh_mmcif_bitclr(struct sh_mmcif_host *host,
 	writel(~val & readl(host->addr + reg), host->addr + reg);
 }
 
-#ifdef CONFIG_SH_MMCIF_DMA
 static void mmcif_dma_complete(void *arg)
 {
 	struct sh_mmcif_host *host = arg;
@@ -367,25 +366,6 @@ static void sh_mmcif_release_dma(struct sh_mmcif_host *host)
 
 	host->dma_sglen = 0;
 }
-#else
-static void sh_mmcif_start_dma_tx(struct sh_mmcif_host *host)
-{
-}
-
-static void sh_mmcif_start_dma_rx(struct sh_mmcif_host *host)
-{
-}
-
-static void sh_mmcif_request_dma(struct sh_mmcif_host *host,
-				 struct sh_mmcif_plat_data *pdata)
-{
-	/* host->chan_tx, host->chan_tx and host->dma_sglen are all zero */
-}
-
-static void sh_mmcif_release_dma(struct sh_mmcif_host *host)
-{
-}
-#endif
 
 static void sh_mmcif_clock_control(struct sh_mmcif_host *host, unsigned int clk)
 {
-- 
1.7.2.3

