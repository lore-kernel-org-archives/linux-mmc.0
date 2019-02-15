From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 2/8] mmc: sdhci: add support for using external DMA devices
Date: Sat, 16 Feb 2019 00:50:27 +0530
Message-ID: <20190215192033.24203-3-faiz_abbas@ti.com>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215192033.24203-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com, kishon@ti.com, zhang.chunyan@linaro.org, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

From: Chunyan Zhang <zhang.chunyan@linaro.org>

Some standard SD host controllers can support both external dma
controllers as well as ADMA/SDMA in which the SD host controller
acts as DMA master. TI's omap controller is the case as an example.

Currently the generic SDHCI code supports ADMA/SDMA integrated in
the host controller but does not have any support for external DMA
controllers implemented using dmaengine, meaning that custom code is
needed for any systems that use an external DMA controller with SDHCI.

Fixes by Faiz Abbas <faiz_abbas@ti.com>:
1. Map scatterlists before dmaengine_prep_slave_sg()
2. Use dma_async() functions inside of the send_command() path and call
terminate_sync() in non-atomic context in case of an error.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/Kconfig |   3 +
 drivers/mmc/host/sdhci.c | 285 +++++++++++++++++++++++++++++++++++----
 drivers/mmc/host/sdhci.h |   8 ++
 3 files changed, 268 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index a44ec8bb5418..f3b442528ed8 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -999,3 +999,6 @@ config MMC_SDHCI_AM654
 	  If you have a controller with this interface, say Y or M here.
 
 	  If unsure, say N.
+
+config MMC_SDHCI_EXTERNAL_DMA
+        bool
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 20ed09b896d7..2f5f64efad16 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
 #include <linux/ktime.h>
 #include <linux/highmem.h>
 #include <linux/io.h>
@@ -34,6 +35,7 @@
 #include <linux/mmc/card.h>
 #include <linux/mmc/sdio.h>
 #include <linux/mmc/slot-gpio.h>
+#include <linux/workqueue.h>
 
 #include "sdhci.h"
 
@@ -987,18 +989,9 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 }
 
-static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
+static inline void sdhci_reset_data(struct sdhci_host *host,
+				    struct mmc_data *data)
 {
-	struct mmc_data *data = cmd->data;
-
-	host->data_timeout = 0;
-
-	if (sdhci_data_line_cmd(cmd))
-		sdhci_set_timeout(host, cmd);
-
-	if (!data)
-		return;
-
 	WARN_ON(host->data);
 
 	/* Sanity checks */
@@ -1009,6 +1002,34 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	host->data = data;
 	host->data_early = 0;
 	host->data->bytes_xfered = 0;
+}
+
+static inline void sdhci_set_block_info(struct sdhci_host *host)
+{
+
+	/* Set the DMA boundary value and block size */
+	sdhci_writew(host,
+		     SDHCI_MAKE_BLKSZ(host->sdma_boundary, host->data->blksz),
+		     SDHCI_BLOCK_SIZE);
+	/*
+	 * For Version 4.10 onwards, if v4 mode is enabled, 32-bit Block Count
+	 * can be supported, in that case 16-bit block count register must be 0.
+	 */
+	if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
+	    (host->quirks2 & SDHCI_QUIRK2_USE_32BIT_BLK_CNT)) {
+		if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
+			sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
+		sdhci_writew(host, host->data->blocks, SDHCI_32BIT_BLK_CNT);
+	} else {
+		sdhci_writew(host, host->data->blocks, SDHCI_BLOCK_COUNT);
+	}
+}
+
+static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	struct mmc_data *data = cmd->data;
+
+	sdhci_reset_data(host, data);
 
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
 		struct scatterlist *sg;
@@ -1100,24 +1121,186 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 
 	sdhci_set_transfer_irqs(host);
 
-	/* Set the DMA boundary value and block size */
-	sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
-		     SDHCI_BLOCK_SIZE);
+	sdhci_set_block_info(host);
+}
 
-	/*
-	 * For Version 4.10 onwards, if v4 mode is enabled, 32-bit Block Count
-	 * can be supported, in that case 16-bit block count register must be 0.
-	 */
-	if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
-	    (host->quirks2 & SDHCI_QUIRK2_USE_32BIT_BLK_CNT)) {
-		if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
-			sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
-		sdhci_writew(host, data->blocks, SDHCI_32BIT_BLK_CNT);
+#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
+static int sdhci_external_dma_init(struct sdhci_host *host)
+{
+	int ret = 0;
+	struct mmc_host *mmc = host->mmc;
+
+	host->tx_chan = dma_request_chan(mmc->parent, "tx");
+	if (IS_ERR(host->tx_chan)) {
+		ret = PTR_ERR(host->tx_chan);
+		if (ret != -EPROBE_DEFER)
+			pr_warn("Failed to request TX DMA channel.\n");
+		host->tx_chan = NULL;
+		return ret;
+	}
+
+	host->rx_chan = dma_request_chan(mmc->parent, "rx");
+	if (IS_ERR(host->rx_chan)) {
+		if (host->tx_chan) {
+			dma_release_channel(host->tx_chan);
+			host->tx_chan = NULL;
+		}
+
+		ret = PTR_ERR(host->rx_chan);
+		if (ret != -EPROBE_DEFER)
+			pr_warn("Failed to request RX DMA channel.\n");
+		host->rx_chan = NULL;
+	}
+
+	return ret;
+}
+
+static inline struct dma_chan *
+sdhci_external_dma_channel(struct sdhci_host *host, struct mmc_data *data)
+{
+	return data->flags & MMC_DATA_WRITE ? host->tx_chan : host->rx_chan;
+}
+
+static int sdhci_external_dma_setup(struct sdhci_host *host,
+				    struct mmc_command *cmd)
+{
+	int ret, i;
+	struct dma_async_tx_descriptor *desc;
+	struct mmc_data *data = cmd->data;
+	struct dma_chan *chan;
+	struct dma_slave_config cfg;
+	dma_cookie_t cookie;
+	int sg_cnt;
+
+	if (!host->mapbase)
+		return -EINVAL;
+
+	cfg.src_addr = host->mapbase + SDHCI_BUFFER;
+	cfg.dst_addr = host->mapbase + SDHCI_BUFFER;
+	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.src_maxburst = data->blksz / 4;
+	cfg.dst_maxburst = data->blksz / 4;
+
+	/* Sanity check: all the SG entries must be aligned by block size. */
+	for (i = 0; i < data->sg_len; i++) {
+		if ((data->sg + i)->length % data->blksz)
+			return -EINVAL;
+	}
+
+	chan = sdhci_external_dma_channel(host, data);
+
+	ret = dmaengine_slave_config(chan, &cfg);
+	if (ret)
+		return ret;
+
+	sg_cnt = sdhci_pre_dma_transfer(host, data, COOKIE_MAPPED);
+	if (sg_cnt <= 0)
+		return -EINVAL;
+
+	desc = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len,
+				       mmc_get_dma_dir(data),
+				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc)
+		return -EINVAL;
+
+	desc->callback = NULL;
+	desc->callback_param = NULL;
+
+	cookie = dmaengine_submit(desc);
+	if (cookie < 0)
+		ret = cookie;
+
+	return ret;
+}
+
+static void sdhci_external_dma_release(struct sdhci_host *host)
+{
+	if (host->tx_chan) {
+		dma_release_channel(host->tx_chan);
+		host->tx_chan = NULL;
+	}
+
+	if (host->rx_chan) {
+		dma_release_channel(host->rx_chan);
+		host->rx_chan = NULL;
+	}
+
+	sdhci_switch_external_dma(host, false);
+}
+
+static void __sdhci_external_dma_prepare_data(struct sdhci_host *host,
+					      struct mmc_command *cmd)
+{
+	struct mmc_data *data = cmd->data;
+
+	sdhci_reset_data(host, data);
+
+	host->flags |= SDHCI_REQ_USE_DMA;
+	sdhci_set_transfer_irqs(host);
+
+	sdhci_set_block_info(host);
+}
+
+static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
+					    struct mmc_command *cmd)
+{
+	if (!sdhci_external_dma_setup(host, cmd)) {
+		__sdhci_external_dma_prepare_data(host, cmd);
 	} else {
-		sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
+		sdhci_external_dma_release(host);
+		pr_err("%s: Cannot use external DMA, switch to the DMA/PIO which standard SDHCI provides.\n",
+		       mmc_hostname(host->mmc));
+		sdhci_prepare_data(host, cmd);
 	}
 }
 
+static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
+					    struct mmc_command *cmd)
+{
+	struct dma_chan *chan;
+
+	if (!cmd->data)
+		return;
+
+	chan = sdhci_external_dma_channel(host, cmd->data);
+	if (chan)
+		dma_async_issue_pending(chan);
+}
+
+#else
+static int sdhci_external_dma_init(struct sdhci_host *host)
+{
+	return -EOPNOTSUPP;
+}
+
+static void sdhci_external_dma_release(struct sdhci_host *host)
+{}
+
+static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
+					    struct mmc_command *cmd)
+{
+	/* If MMC_SDHCI_EXTERNAL_DMA not supported, PIO will be used */
+	sdhci_prepare_data(host, cmd);
+}
+
+static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
+					    struct mmc_command *cmd)
+{}
+
+static inline struct dma_chan *
+sdhci_external_dma_channel(struct sdhci_host *host, struct mmc_data *data)
+{
+	return NULL;
+}
+#endif
+
+void sdhci_switch_external_dma(struct sdhci_host *host, bool en)
+{
+	host->use_external_dma = en;
+}
+EXPORT_SYMBOL_GPL(sdhci_switch_external_dma);
+
 static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
 				    struct mmc_request *mrq)
 {
@@ -1369,12 +1552,19 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 
 	host->cmd = cmd;
+	host->data_timeout = 0;
 	if (sdhci_data_line_cmd(cmd)) {
 		WARN_ON(host->data_cmd);
 		host->data_cmd = cmd;
+		sdhci_set_timeout(host, cmd);
 	}
 
-	sdhci_prepare_data(host, cmd);
+	if (cmd->data) {
+		if (host->use_external_dma)
+			sdhci_external_dma_prepare_data(host, cmd);
+		else
+			sdhci_prepare_data(host, cmd);
+	}
 
 	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
 
@@ -1416,6 +1606,9 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		timeout += 10 * HZ;
 	sdhci_mod_timer(host, cmd->mrq, timeout);
 
+	if (host->use_external_dma)
+		sdhci_external_dma_pre_transfer(host, cmd);
+
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
 }
 EXPORT_SYMBOL_GPL(sdhci_send_command);
@@ -2619,6 +2812,18 @@ static bool sdhci_request_done(struct sdhci_host *host)
 	if (host->flags & SDHCI_REQ_USE_DMA) {
 		struct mmc_data *data = mrq->data;
 
+		spin_unlock_irqrestore(&host->lock, flags);
+
+		/* Terminate and synchronize dma in case of an error */
+		if (data && (mrq->cmd->error || data->error) &&
+		    host->use_external_dma) {
+			struct dma_chan *chan = sdhci_external_dma_channel(host,
+									  data);
+			dmaengine_terminate_sync(chan);
+		}
+
+		spin_lock_irqsave(&host->lock, flags);
+
 		if (data && data->host_cookie == COOKIE_MAPPED) {
 			if (host->bounce_buffer) {
 				/*
@@ -3691,12 +3896,28 @@ int sdhci_setup_host(struct sdhci_host *host)
 		       mmc_hostname(mmc), host->version);
 	}
 
-	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
+	if (host->use_external_dma) {
+		ret = sdhci_external_dma_init(host);
+		if (ret == -EPROBE_DEFER)
+			goto unreg;
+
+		/*
+		 * Fall back to use the DMA/PIO integrated in standard SDHCI
+		 * instead of external DMA devices.
+		 */
+		if (ret)
+			sdhci_switch_external_dma(host, false);
+	}
+
+	if (host->quirks & SDHCI_QUIRK_FORCE_DMA) {
 		host->flags |= SDHCI_USE_SDMA;
-	else if (!(host->caps & SDHCI_CAN_DO_SDMA))
+	} else if (!(host->caps & SDHCI_CAN_DO_SDMA)) {
 		DBG("Controller doesn't have SDMA capability\n");
-	else
+	} else if (host->use_external_dma) {
+		/* Using dma-names to detect external dma capability */
+	} else {
 		host->flags |= SDHCI_USE_SDMA;
+	}
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_DMA) &&
 		(host->flags & SDHCI_USE_SDMA)) {
@@ -4201,6 +4422,10 @@ void sdhci_cleanup_host(struct sdhci_host *host)
 		dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz +
 				  host->adma_table_sz, host->align_buffer,
 				  host->align_addr);
+
+	if (host->use_external_dma)
+		sdhci_external_dma_release(host);
+
 	host->adma_table = NULL;
 	host->align_buffer = NULL;
 }
@@ -4241,6 +4466,7 @@ int __sdhci_add_host(struct sdhci_host *host)
 
 	pr_info("%s: SDHCI controller on %s [%s] using %s\n",
 		mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
+		host->use_external_dma ? "External DMA" :
 		(host->flags & SDHCI_USE_ADMA) ?
 		(host->flags & SDHCI_USE_64_BIT_DMA) ? "ADMA 64-bit" : "ADMA" :
 		(host->flags & SDHCI_USE_SDMA) ? "DMA" : "PIO");
@@ -4325,6 +4551,9 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 				  host->adma_table_sz, host->align_buffer,
 				  host->align_addr);
 
+	if (host->use_external_dma)
+		sdhci_external_dma_release(host);
+
 	host->adma_table = NULL;
 	host->align_buffer = NULL;
 }
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 624d5aa01995..6ff3e29791ee 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -482,6 +482,7 @@ struct sdhci_host {
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
+	phys_addr_t mapbase;	/* physical address base */
 	char *bounce_buffer;	/* For packing SDMA reads/writes */
 	dma_addr_t bounce_addr;
 	unsigned int bounce_buffer_size;
@@ -531,6 +532,7 @@ struct sdhci_host {
 	bool pending_reset;	/* Cmd/data reset is pending */
 	bool irq_wake_enabled;	/* IRQ wakeup is enabled */
 	bool v4_mode;		/* Host Version 4 Enable */
+	bool use_external_dma;	/* Host selects to use external DMA */
 
 	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
 	struct mmc_command *cmd;	/* Current command */
@@ -559,6 +561,11 @@ struct sdhci_host {
 	struct timer_list timer;	/* Timer for timeouts */
 	struct timer_list data_timer;	/* Timer for data timeouts */
 
+#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
+	struct dma_chan	*rx_chan;
+	struct dma_chan	*tx_chan;
+#endif
+
 	u32 caps;		/* CAPABILITY_0 */
 	u32 caps1;		/* CAPABILITY_1 */
 	bool read_caps;		/* Capability flags have been read */
@@ -792,5 +799,6 @@ void sdhci_start_tuning(struct sdhci_host *host);
 void sdhci_end_tuning(struct sdhci_host *host);
 void sdhci_reset_tuning(struct sdhci_host *host);
 void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
+void sdhci_switch_external_dma(struct sdhci_host *host, bool en);
 
 #endif /* __SDHCI_HW_H */
-- 
2.19.2
