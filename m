From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v2 2/6] mmc: renesas-sdhi, tmio: make dma more modular
Date: Wed, 10 May 2017 11:25:26 +0200
Message-ID: <1494408330-28161-3-git-send-email-horms+renesas@verge.net.au>
References: <1494408330-28161-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:54135 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbdEJJZ5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 May 2017 05:25:57 -0400
In-Reply-To: <1494408330-28161-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms+renesas@verge.net.au>

Refactor DMA support to allow it to be provided by a set of call-backs
that are provided by a host driver. The motivation is to allow multiple
DMA implementations to be provided and instantiated at run-time.

Instantiate the existing DMA implementation from the sh_mobile_sdhi driver
which appears to match the current use-case. This has the side effect
of moving the DMA code from the tmio_core to the sh_mobile_sdhi driver.

A follow-up patch will change the source file for the SDHI DMA
implementation accordingly. Another follow-up patch will re-organise the
SDHI driver removing the need for tmio_mmc_get_dma_ops().

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v2
* Consistently check for if (host->dma_ops) before using dma_ops.
---
 drivers/mmc/host/Makefile         |  3 +--
 drivers/mmc/host/sh_mobile_sdhi.c |  2 +-
 drivers/mmc/host/tmio_mmc.c       |  2 +-
 drivers/mmc/host/tmio_mmc.h       | 55 ++++++++++++++++-----------------------
 drivers/mmc/host/tmio_mmc_dma.c   | 24 +++++++++++++----
 drivers/mmc/host/tmio_mmc_pio.c   | 43 +++++++++++++++++++++++++++++-
 6 files changed, 86 insertions(+), 43 deletions(-)

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 926347c2eeb4..f11b3d4b121d 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -37,8 +37,7 @@ obj-$(CONFIG_MMC_SDRICOH_CS)	+= sdricoh_cs.o
 obj-$(CONFIG_MMC_TMIO)		+= tmio_mmc.o
 obj-$(CONFIG_MMC_TMIO_CORE)	+= tmio_mmc_core.o
 tmio_mmc_core-y			:= tmio_mmc_pio.o
-tmio_mmc_core-$(subst m,y,$(CONFIG_MMC_SDHI))	+= tmio_mmc_dma.o
-obj-$(CONFIG_MMC_SDHI)		+= sh_mobile_sdhi.o
+obj-$(CONFIG_MMC_SDHI)		+= sh_mobile_sdhi.o tmio_mmc_dma.o
 obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
 obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index bc6be0dbea39..90ab460811f6 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -667,7 +667,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	/* All SDHI have SDIO status bits which must be 1 */
 	mmc_data->flags |= TMIO_MMC_SDIO_STATUS_SETBITS;
 
-	ret = tmio_mmc_host_probe(host, mmc_data);
+	ret = tmio_mmc_host_probe(host, mmc_data, tmio_mmc_get_dma_ops());
 	if (ret < 0)
 		goto efree;
 
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index ff14311bddbe..59880146e7f9 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -97,7 +97,7 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 	/* SD control register space size is 0x200, 0x400 for bus_shift=1 */
 	host->bus_shift = resource_size(res) >> 10;
 
-	ret = tmio_mmc_host_probe(host, pdata);
+	ret = tmio_mmc_host_probe(host, pdata, NULL);
 	if (ret)
 		goto host_free;
 
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 08076d2bc3b0..5b8f61de78c9 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -114,6 +114,15 @@ struct tmio_mmc_dma {
 	void (*enable)(struct tmio_mmc_host *host, bool enable);
 };
 
+struct tmio_mmc_dma_ops {
+	void (*start)(struct tmio_mmc_host *host, struct mmc_data *data);
+	void (*enable)(struct tmio_mmc_host *host, bool enable);
+	void (*request)(struct tmio_mmc_host *host,
+			struct tmio_mmc_data *pdata);
+	void (*release)(struct tmio_mmc_host *host);
+	void (*abort)(struct tmio_mmc_host *host);
+};
+
 struct tmio_mmc_host {
 	void __iomem *ctl;
 	struct mmc_command      *cmd;
@@ -188,12 +197,15 @@ struct tmio_mmc_host {
 	/* Tuning values: 1 for success, 0 for failure */
 	DECLARE_BITMAP(taps, BITS_PER_BYTE * sizeof(long));
 	unsigned int tap_num;
+
+	const struct tmio_mmc_dma_ops *dma_ops;
 };
 
 struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
 void tmio_mmc_host_free(struct tmio_mmc_host *host);
 int tmio_mmc_host_probe(struct tmio_mmc_host *host,
-			struct tmio_mmc_data *pdata);
+			struct tmio_mmc_data *pdata,
+			const struct tmio_mmc_dma_ops *dma_ops);
 void tmio_mmc_host_remove(struct tmio_mmc_host *host);
 void tmio_mmc_do_data_irq(struct tmio_mmc_host *host);
 
@@ -201,6 +213,15 @@ void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 irqreturn_t tmio_mmc_irq(int irq, void *devid);
 
+#if IS_ENABLED(CONFIG_MMC_SDHI)
+const struct tmio_mmc_dma_ops *tmio_mmc_get_dma_ops(void);
+#else
+static inline const struct tmio_mmc_dma_ops *tmio_mmc_get_dma_ops(void)
+{
+	return NULL;
+}
+#endif
+
 static inline char *tmio_mmc_kmap_atomic(struct scatterlist *sg,
 					 unsigned long *flags)
 {
@@ -215,38 +236,6 @@ static inline void tmio_mmc_kunmap_atomic(struct scatterlist *sg,
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
-
-static inline void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
-{
-}
-#endif
-
 #ifdef CONFIG_PM
 int tmio_mmc_host_runtime_suspend(struct device *dev);
 int tmio_mmc_host_runtime_resume(struct device *dev);
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index 98ce896b13e4..537ee4ad8b60 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -20,7 +20,7 @@
 
 #define TMIO_MMC_MIN_DMA_LEN 8
 
-void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
+static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
 {
 	if (!host->chan_tx || !host->chan_rx)
 		return;
@@ -29,7 +29,7 @@ void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
 		host->dma->enable(host, enable);
 }
 
-void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
+static void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
 {
 	tmio_mmc_enable_dma(host, false);
 
@@ -221,7 +221,7 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 	}
 }
 
-void tmio_mmc_start_dma(struct tmio_mmc_host *host,
+static void tmio_mmc_start_dma(struct tmio_mmc_host *host,
 			       struct mmc_data *data)
 {
 	if (data->flags & MMC_DATA_READ) {
@@ -255,7 +255,8 @@ static void tmio_mmc_issue_tasklet_fn(unsigned long priv)
 		dma_async_issue_pending(chan);
 }
 
-void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdata)
+static void tmio_mmc_request_dma(struct tmio_mmc_host *host,
+				 struct tmio_mmc_data *pdata)
 {
 	/* We can only either use DMA for both Tx and Rx or not use it at all */
 	if (!host->dma || (!host->pdev->dev.of_node &&
@@ -335,7 +336,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
 	host->chan_tx = NULL;
 }
 
-void tmio_mmc_release_dma(struct tmio_mmc_host *host)
+static void tmio_mmc_release_dma(struct tmio_mmc_host *host)
 {
 	if (host->chan_tx) {
 		struct dma_chan *chan = host->chan_tx;
@@ -352,3 +353,16 @@ void tmio_mmc_release_dma(struct tmio_mmc_host *host)
 		host->bounce_buf = NULL;
 	}
 }
+
+static const struct tmio_mmc_dma_ops tmio_mmc_dma_ops = {
+	.start = tmio_mmc_start_dma,
+	.enable = tmio_mmc_enable_dma,
+	.request = tmio_mmc_request_dma,
+	.release = tmio_mmc_release_dma,
+	.abort = tmio_mmc_abort_dma,
+};
+
+const struct tmio_mmc_dma_ops *tmio_mmc_get_dma_ops(void)
+{
+	return &tmio_mmc_dma_ops;
+}
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index d816a1061639..a649a5ff9957 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -50,17 +50,55 @@
 
 #include "tmio_mmc.h"
 
+static inline void tmio_mmc_start_dma(struct tmio_mmc_host *host,
+				      struct mmc_data *data)
+{
+	if (host->dma_ops)
+		host->dma_ops->start(host, data);
+}
+
+static inline void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
+{
+	if (host->dma_ops)
+		host->dma_ops->enable(host, enable);
+}
+
+static inline void tmio_mmc_request_dma(struct tmio_mmc_host *host,
+					struct tmio_mmc_data *pdata)
+{
+	if (host->dma_ops) {
+		host->dma_ops->request(host, pdata);
+	} else {
+		host->chan_tx = NULL;
+		host->chan_rx = NULL;
+	}
+}
+
+static inline void tmio_mmc_release_dma(struct tmio_mmc_host *host)
+{
+	if (host->dma_ops)
+		host->dma_ops->release(host);
+}
+
+static inline void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
+{
+	if (host->dma_ops)
+		host->dma_ops->abort(host);
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
@@ -563,6 +601,7 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 
 	schedule_work(&host->done);
 }
+EXPORT_SYMBOL(tmio_mmc_do_data_irq);
 
 static void tmio_mmc_data_irq(struct tmio_mmc_host *host, unsigned int stat)
 {
@@ -1138,7 +1177,8 @@ void tmio_mmc_host_free(struct tmio_mmc_host *host)
 EXPORT_SYMBOL(tmio_mmc_host_free);
 
 int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
-			struct tmio_mmc_data *pdata)
+			struct tmio_mmc_data *pdata,
+			const struct tmio_mmc_dma_ops *dma_ops)
 {
 	struct platform_device *pdev = _host->pdev;
 	struct mmc_host *mmc = _host->mmc;
@@ -1250,6 +1290,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	INIT_WORK(&_host->done, tmio_mmc_done_work);
 
 	/* See if we also get DMA */
+	_host->dma_ops = dma_ops;
 	tmio_mmc_request_dma(_host, pdata);
 
 	pm_runtime_set_active(&pdev->dev);
-- 
2.1.4

