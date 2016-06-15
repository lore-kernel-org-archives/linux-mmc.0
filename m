From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC 2/4] mmc: renesas_sdhi, tmio: make dma more modular
Date: Wed, 15 Jun 2016 13:01:55 +0900
Message-ID: <1465963317-28672-3-git-send-email-horms+renesas@verge.net.au>
References: <1465963317-28672-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1465963317-28672-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Refactor DMA support to allow it to be provided by a set of call-backs
that are provided by a host driver. The motivation is to allow multiple
DMA implementations to be provided and instantiated at run-time.

Instantiate the existing DMA implementation from the renesas_sdhi driver
which appears to match the current use-case. This has the side effect
of moving the DMA code from the tmio_core to the renesas_sdhi driver.

A follow-up patch will change the source file for the SDHI DMA
implementation accordingly.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/mmc/host/Kconfig        |  9 ++++++++
 drivers/mmc/host/Makefile       |  2 +-
 drivers/mmc/host/renesas_sdhi.c | 13 ++++++++++++
 drivers/mmc/host/tmio_mmc.h     | 39 ++++++++--------------------------
 drivers/mmc/host/tmio_mmc_dma.c | 26 ++++++++++++++++++-----
 drivers/mmc/host/tmio_mmc_pio.c | 47 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 100 insertions(+), 36 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 840b17150263..7ccae04632aa 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -564,10 +564,19 @@ config MMC_SDHI
 	depends on SUPERH || ARM || ARM64
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
 	select MMC_TMIO_CORE
+	select MMC_SDHI_DMA if (SUPERH || ARM)
 	help
 	  This provides support for the SDHI SD/SDIO controller found in
 	  SuperH, and Renesas ARM and arm64 based SoCs.
 
+config MMC_SDHI_DMA
+	tristate "DMA support for non R-Car Gen 3 Renesas SDHI SD/SDIO controller"
+	depends on SUPERH || ARM || COMPILE_TEST
+	depends on MMC_SDHI
+	help
+	  This provides DMA support for the DMA support the SDHI SD/SDIO
+	  found in SuperH and Renesas ARM based SoCs.
+
 config MMC_CB710
 	tristate "ENE CB710 MMC/SD Interface support"
 	depends on PCI
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 206233218781..4f7903fbef26 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -37,8 +37,8 @@ obj-$(CONFIG_MMC_SDRICOH_CS)	+= sdricoh_cs.o
 obj-$(CONFIG_MMC_TMIO)		+= tmio_mmc.o
 obj-$(CONFIG_MMC_TMIO_CORE)	+= tmio_mmc_core.o
 tmio_mmc_core-y			:= tmio_mmc_pio.o
-tmio_mmc_core-$(subst m,y,$(CONFIG_MMC_SDHI))	+= tmio_mmc_dma.o
 obj-$(CONFIG_MMC_SDHI)		+= renesas_sdhi.o
+renesas_sdhi-$(subst m,y,$(CONFIG_MMC_SDHI_DMA))	+= tmio_mmc_dma.o
 obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
 obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
diff --git a/drivers/mmc/host/renesas_sdhi.c b/drivers/mmc/host/renesas_sdhi.c
index c3b651bf89cb..4403dfe1413d 100644
--- a/drivers/mmc/host/renesas_sdhi.c
+++ b/drivers/mmc/host/renesas_sdhi.c
@@ -106,6 +106,15 @@ struct sh_mobile_sdhi {
 	struct pinctrl_state *pins_default, *pins_uhs;
 };
 
+#if IS_ENABLED(CONFIG_MMC_SDHI_DMA)
+int tmio_mmc_init_dma(void);
+#else
+static int tmio_mmc_init_dma(void)
+{
+       return -EINVAL;
+}
+#endif
+
 static void sh_mobile_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
 {
 	u32 val;
@@ -363,6 +372,10 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		host->bus_shift = of_data->bus_shift;
 	}
 
+	ret = tmio_mmc_init_dma();
+	if (ret < 0)
+		goto efree;
+
 	host->dma		= dma_priv;
 	host->write16_hook	= sh_mobile_sdhi_write16_hook;
 	host->clk_enable	= sh_mobile_sdhi_clk_enable;
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 7f63ec05bdf4..cbe0212fbbf4 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -187,37 +187,16 @@ static inline void tmio_mmc_kunmap_atomic(struct scatterlist *sg,
 	local_irq_restore(*flags);
 }
 
-#if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
-void tmio_mmc_start_dma(struct tmio_mmc_host *host, struct mmc_data *data);
-void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable);
-void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdata);
-void tmio_mmc_release_dma(struct tmio_mmc_host *host);
-void tmio_mmc_abort_dma(struct tmio_mmc_host *host);
-#else
-static inline void tmio_mmc_start_dma(struct tmio_mmc_host *host,
-			       struct mmc_data *data)
-{
-}
-
-static inline void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
-{
-}
-
-static inline void tmio_mmc_request_dma(struct tmio_mmc_host *host,
-				 struct tmio_mmc_data *pdata)
-{
-	host->chan_tx = NULL;
-	host->chan_rx = NULL;
-}
-
-static inline void tmio_mmc_release_dma(struct tmio_mmc_host *host)
-{
-}
+struct tmio_mmc_dma_ops {
+	void (*start)(struct tmio_mmc_host *host, struct mmc_data *data);
+	void (*enable)(struct tmio_mmc_host *host, bool enable);
+	void (*request)(struct tmio_mmc_host *host,
+			struct tmio_mmc_data *pdata);
+	void (*release)(struct tmio_mmc_host *host);
+	void (*abort)(struct tmio_mmc_host *host);
+};
 
-static inline void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
-{
-}
-#endif
+void tmio_set_dma_ops(const struct tmio_mmc_dma_ops *ops);
 
 #ifdef CONFIG_PM
 int tmio_mmc_host_runtime_suspend(struct device *dev);
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index fa8a936a3d9b..381bc40e506b 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -22,7 +22,7 @@
 
 #define TMIO_MMC_MIN_DMA_LEN 8
 
-void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
+static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
 {
 	if (!host->chan_tx || !host->chan_rx)
 		return;
@@ -31,7 +31,7 @@ void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
 		host->dma->enable(host, enable);
 }
 
-void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
+static void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
 {
 	tmio_mmc_enable_dma(host, false);
 
@@ -187,7 +187,7 @@ pio:
 	}
 }
 
-void tmio_mmc_start_dma(struct tmio_mmc_host *host,
+static void tmio_mmc_start_dma(struct tmio_mmc_host *host,
 			       struct mmc_data *data)
 {
 	if (data->flags & MMC_DATA_READ) {
@@ -244,7 +244,8 @@ out:
 	spin_unlock_irq(&host->lock);
 }
 
-void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdata)
+static void tmio_mmc_request_dma(struct tmio_mmc_host *host,
+				 struct tmio_mmc_data *pdata)
 {
 	/* We can only either use DMA for both Tx and Rx or not use it at all */
 	if (!host->dma || (!host->pdev->dev.of_node &&
@@ -324,7 +325,7 @@ ecfgtx:
 	host->chan_tx = NULL;
 }
 
-void tmio_mmc_release_dma(struct tmio_mmc_host *host)
+static void tmio_mmc_release_dma(struct tmio_mmc_host *host)
 {
 	if (host->chan_tx) {
 		struct dma_chan *chan = host->chan_tx;
@@ -341,3 +342,18 @@ void tmio_mmc_release_dma(struct tmio_mmc_host *host)
 		host->bounce_buf = NULL;
 	}
 }
+
+static struct tmio_mmc_dma_ops tmio_mmc_dma_ops __initdata = {
+	.start = tmio_mmc_start_dma,
+	.enable = tmio_mmc_enable_dma,
+	.request = tmio_mmc_request_dma,
+	.release = tmio_mmc_release_dma,
+	.abort = tmio_mmc_abort_dma,
+};
+
+int tmio_mmc_init_dma(void)
+{
+	tmio_set_dma_ops(&tmio_mmc_dma_ops);
+
+	return 0;
+}
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index f44e2ab7aea2..59e773cc36c1 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -52,17 +52,63 @@
 
 #include "tmio_mmc.h"
 
+static struct tmio_mmc_dma_ops tmio_dma_ops;
+
+void tmio_set_dma_ops(const struct tmio_mmc_dma_ops *ops)
+{
+	tmio_dma_ops = *ops;
+}
+EXPORT_SYMBOL(tmio_set_dma_ops);
+
+static inline void tmio_mmc_start_dma(struct tmio_mmc_host *host,
+				      struct mmc_data *data)
+{
+	if (tmio_dma_ops.start)
+		tmio_dma_ops.start(host, data);
+}
+
+static inline void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
+{
+	if (tmio_dma_ops.enable)
+		tmio_dma_ops.enable(host, enable);
+}
+
+static inline void tmio_mmc_request_dma(struct tmio_mmc_host *host,
+					struct tmio_mmc_data *pdata)
+{
+	if (tmio_dma_ops.request) {
+		tmio_dma_ops.request(host, pdata);
+	} else {
+		host->chan_tx = NULL;
+		host->chan_rx = NULL;
+	}
+}
+
+static inline void tmio_mmc_release_dma(struct tmio_mmc_host *host)
+{
+	if (tmio_dma_ops.release)
+		tmio_dma_ops.release(host);
+}
+
+static inline void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
+{
+	if (tmio_dma_ops.abort)
+		tmio_dma_ops.abort(host);
+}
+
 void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i)
 {
 	host->sdcard_irq_mask &= ~(i & TMIO_MASK_IRQ);
 	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask);
 }
+EXPORT_SYMBOL(tmio_mmc_enable_mmc_irqs);
 
 void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i)
 {
 	host->sdcard_irq_mask |= (i & TMIO_MASK_IRQ);
 	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask);
 }
+EXPORT_SYMBOL(tmio_mmc_disable_mmc_irqs);
 
 static void tmio_mmc_ack_mmc_irqs(struct tmio_mmc_host *host, u32 i)
 {
@@ -519,6 +565,7 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 
 	schedule_work(&host->done);
 }
+EXPORT_SYMBOL(tmio_mmc_do_data_irq);
 
 static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
 {
-- 
2.1.4
