From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC v2 2/5] mmc: sh_mobile_sdhi: rename DMA source file as renesas_sdhi_sysc_dmac.c
Date: Thu, 30 Jun 2016 00:05:37 +0200
Message-ID: <1467237940-24388-3-git-send-email-horms+renesas@verge.net.au>
References: <1467237940-24388-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1467237940-24388-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Rename the source file for DMA for SDHI as a follow-up to attaching
DMA code to the SDHI driver rather than the tmio_core driver and
prepartation for allowing more than one DMA provider.

The name Renesas is chosen as the the SDHI driver is applicable to a wider
range of SoCs than SH-Mobile, Renesas seems to be a more appropriate name.
However, the SDHI driver source itself, is left as sh_mobile_sdhi to
avoid unnecessary churn.

The name sysc_dmac was chosen to reflect the type of DMA used.

Internal symbols have also been renamed to reflect the filename change.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v2
* Use renesas_sdhi_sysc_dmac rather than renesas_sdhi_dmac as file name
* Rename symbols to reflect filename change
* Drop bogus use of __initdata
---
 drivers/mmc/host/Makefile                          |  2 +-
 .../{tmio_mmc_dma.c => renesas_sdhi_sysc_dmac.c}   | 57 +++++++++++-----------
 drivers/mmc/host/sh_mobile_sdhi.c                  |  6 +--
 3 files changed, 33 insertions(+), 32 deletions(-)
 rename drivers/mmc/host/{tmio_mmc_dma.c => renesas_sdhi_sysc_dmac.c} (83%)

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 4ed6f250213a..da5377e3ee4e 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -39,7 +39,7 @@ obj-$(CONFIG_MMC_TMIO_CORE)	+= tmio_mmc_core.o
 tmio_mmc_core-y			:= tmio_mmc_pio.o
 obj-$(CONFIG_MMC_SDHI)		+= sh_mobile_sdhi.o
 ifeq ($(subst m,y,$(CONFIG_MMC_SDHI_SYSC_DMA)),y)
-obj-$(CONFIG_MMC_SDHI)		+= tmio_mmc_dma.o
+obj-$(CONFIG_MMC_SDHI)		+= renesas_sdhi_sysc_dmac.o
 endif
 obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/renesas_sdhi_sysc_dmac.c
similarity index 83%
rename from drivers/mmc/host/tmio_mmc_dma.c
rename to drivers/mmc/host/renesas_sdhi_sysc_dmac.c
index 381bc40e506b..a73055924c52 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/renesas_sdhi_sysc_dmac.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/mmc/tmio_mmc_dma.c
+ * linux/drivers/mmc/renesas_sdhi_sysc_dmac_dma.c
  *
  * Copyright (C) 2010-2011 Guennadi Liakhovetski
  *
@@ -22,7 +22,8 @@
 
 #define TMIO_MMC_MIN_DMA_LEN 8
 
-static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
+static void sdhi_sysc_dmac_enable_dma(struct tmio_mmc_host *host,
+				      bool enable)
 {
 	if (!host->chan_tx || !host->chan_rx)
 		return;
@@ -31,19 +32,19 @@ static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
 		host->dma->enable(host, enable);
 }
 
-static void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
+static void sdhi_sysc_dmac_abort_dma(struct tmio_mmc_host *host)
 {
-	tmio_mmc_enable_dma(host, false);
+	sdhi_sysc_dmac_enable_dma(host, false);
 
 	if (host->chan_rx)
 		dmaengine_terminate_all(host->chan_rx);
 	if (host->chan_tx)
 		dmaengine_terminate_all(host->chan_tx);
 
-	tmio_mmc_enable_dma(host, true);
+	sdhi_sysc_dmac_enable_dma(host, true);
 }
 
-static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
+static void sdhi_sysc_dmac_start_dma_rx(struct tmio_mmc_host *host)
 {
 	struct scatterlist *sg = host->sg_ptr, *sg_tmp;
 	struct dma_async_tx_descriptor *desc = NULL;
@@ -97,7 +98,7 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 pio:
 	if (!desc) {
 		/* DMA failed, fall back to PIO */
-		tmio_mmc_enable_dma(host, false);
+		sdhi_sysc_dmac_enable_dma(host, false);
 		if (ret >= 0)
 			ret = -EIO;
 		host->chan_rx = NULL;
@@ -113,7 +114,7 @@ pio:
 	}
 }
 
-static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
+static void sdhi_sysc_dmac_start_dma_tx(struct tmio_mmc_host *host)
 {
 	struct scatterlist *sg = host->sg_ptr, *sg_tmp;
 	struct dma_async_tx_descriptor *desc = NULL;
@@ -171,7 +172,7 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 pio:
 	if (!desc) {
 		/* DMA failed, fall back to PIO */
-		tmio_mmc_enable_dma(host, false);
+		sdhi_sysc_dmac_enable_dma(host, false);
 		if (ret >= 0)
 			ret = -EIO;
 		host->chan_tx = NULL;
@@ -187,19 +188,19 @@ pio:
 	}
 }
 
-static void tmio_mmc_start_dma(struct tmio_mmc_host *host,
+static void sdhi_sysc_dmac_start_dma(struct tmio_mmc_host *host,
 			       struct mmc_data *data)
 {
 	if (data->flags & MMC_DATA_READ) {
 		if (host->chan_rx)
-			tmio_mmc_start_dma_rx(host);
+			sdhi_sysc_dmac_start_dma_rx(host);
 	} else {
 		if (host->chan_tx)
-			tmio_mmc_start_dma_tx(host);
+			sdhi_sysc_dmac_start_dma_tx(host);
 	}
 }
 
-static void tmio_mmc_issue_tasklet_fn(unsigned long priv)
+static void sdhi_sysc_dmac_issue_tasklet_fn(unsigned long priv)
 {
 	struct tmio_mmc_host *host = (struct tmio_mmc_host *)priv;
 	struct dma_chan *chan = NULL;
@@ -221,7 +222,7 @@ static void tmio_mmc_issue_tasklet_fn(unsigned long priv)
 		dma_async_issue_pending(chan);
 }
 
-static void tmio_mmc_tasklet_fn(unsigned long arg)
+static void sdhi_sysc_dmac_tasklet_fn(unsigned long arg)
 {
 	struct tmio_mmc_host *host = (struct tmio_mmc_host *)arg;
 
@@ -244,8 +245,8 @@ out:
 	spin_unlock_irq(&host->lock);
 }
 
-static void tmio_mmc_request_dma(struct tmio_mmc_host *host,
-				 struct tmio_mmc_data *pdata)
+static void sdhi_sysc_dmac_request_dma(struct tmio_mmc_host *host,
+				       struct tmio_mmc_data *pdata)
 {
 	/* We can only either use DMA for both Tx and Rx or not use it at all */
 	if (!host->dma || (!host->pdev->dev.of_node &&
@@ -307,11 +308,11 @@ static void tmio_mmc_request_dma(struct tmio_mmc_host *host,
 		if (!host->bounce_buf)
 			goto ebouncebuf;
 
-		tasklet_init(&host->dma_complete, tmio_mmc_tasklet_fn, (unsigned long)host);
-		tasklet_init(&host->dma_issue, tmio_mmc_issue_tasklet_fn, (unsigned long)host);
+		tasklet_init(&host->dma_complete, sdhi_sysc_dmac_tasklet_fn, (unsigned long)host);
+		tasklet_init(&host->dma_issue, sdhi_sysc_dmac_issue_tasklet_fn, (unsigned long)host);
 	}
 
-	tmio_mmc_enable_dma(host, true);
+	sdhi_sysc_dmac_enable_dma(host, true);
 
 	return;
 
@@ -325,7 +326,7 @@ ecfgtx:
 	host->chan_tx = NULL;
 }
 
-static void tmio_mmc_release_dma(struct tmio_mmc_host *host)
+static void sdhi_sysc_dmac_release_dma(struct tmio_mmc_host *host)
 {
 	if (host->chan_tx) {
 		struct dma_chan *chan = host->chan_tx;
@@ -343,17 +344,17 @@ static void tmio_mmc_release_dma(struct tmio_mmc_host *host)
 	}
 }
 
-static struct tmio_mmc_dma_ops tmio_mmc_dma_ops __initdata = {
-	.start = tmio_mmc_start_dma,
-	.enable = tmio_mmc_enable_dma,
-	.request = tmio_mmc_request_dma,
-	.release = tmio_mmc_release_dma,
-	.abort = tmio_mmc_abort_dma,
+static struct tmio_mmc_dma_ops sdhi_sysc_dmac_dma_ops = {
+	.start = sdhi_sysc_dmac_start_dma,
+	.enable = sdhi_sysc_dmac_enable_dma,
+	.request = sdhi_sysc_dmac_request_dma,
+	.release = sdhi_sysc_dmac_release_dma,
+	.abort = sdhi_sysc_dmac_abort_dma,
 };
 
-int tmio_mmc_init_dma(void)
+int sdhi_sysc_dmac_init_dma(void)
 {
-	tmio_set_dma_ops(&tmio_mmc_dma_ops);
+	tmio_set_dma_ops(&sdhi_sysc_dmac_dma_ops);
 
 	return 0;
 }
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 45543ed37e5f..320059c61c6c 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -107,9 +107,9 @@ struct sh_mobile_sdhi {
 };
 
 #if IS_ENABLED(MMC_SDHI_SYSC_DMA)
-int tmio_mmc_init_dma(void);
+int sdhi_sysc_dmac_init_dma(void);
 #else
-static int tmio_mmc_init_dma(void)
+static int sdhi_sysc_dmac_init_dma(void)
 {
        return -EINVAL;
 }
@@ -372,7 +372,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		host->bus_shift = of_data->bus_shift;
 	}
 
-	ret = tmio_mmc_init_dma();
+	ret = sdhi_sysc_dmac_init_dma();
 	if (ret < 0)
 		goto efree;
 
-- 
2.7.0.rc3.207.g0ac5344
