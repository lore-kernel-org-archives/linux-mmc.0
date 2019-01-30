From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH 1/7] mmc: sdhci: add support for using external DMA devices
Date: Wed, 30 Jan 2019 19:05:48 +0800
Message-ID: <20190130110548.19151-1-zhang.chunyan@linaro.org>
References: <CAG2=9p_mUyY=hKLN4E-ZUaJNueE-h5hHKDnJV5cG5kjtLsEgPA@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAG2=9p_mUyY=hKLN4E-ZUaJNueE-h5hHKDnJV5cG5kjtLsEgPA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Some standard SD host controllers can support both external dma
controllers as well as ADMA/SDMA in which the SD host controller
acts as DMA master. TI's omap controller is the case as an example.

Currently the generic SDHCI code supports ADMA/SDMA integrated in
the host controller but does not have any support for external DMA
controllers implemented using dmaengine, meaning that custom code is
needed for any systems that use an external DMA controller with SDHCI.

Fixes by Faiz Abbas <faiz_abbas@ti.com>:
1. Map scatterlists before dmaengine_prep_slave_sg()
2. Use dma_async() functions inside of the send_command() path and
synchronize once at the start of each request.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
Changes from the last version:
* Moved sdhci_set_timeout() from _prepare_data() to its caller -
  sdhci_send_command();
* Factor out a new function sdhci_reset_data() which deal with sanity
  checks for mmc_data and reset for host->data, these processes were
  in _prepare_data();
* Factor out a new function sdhci_set_block_info() for configuring data
  blocks which were processing at bottom of _prepare_data();
* Added a new tasklet and functions for handling external dma  error case;
* Removed sdhci_external_dma_cleanup() which is not used;
* Added an empty sdhci_external_dma_channel definition for
  !IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA);
* Addressed some other comments from Adrian:
- Removed check for MMC_SET_BLOCK_COUNT, left checking !cmd->data only
  which is enough.
---
 drivers/mmc/host/Kconfig |   3 +
 drivers/mmc/host/sdhci.c | 333 +++++++++++++++++++++++++++++++++++----
 drivers/mmc/host/sdhci.h |  10 ++
 3 files changed, 317 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e26b8145efb3..333292e8ecdd 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -999,3 +999,6 @@ config MMC_SDHCI_AM654
 	  If you have a controller with this interface, say Y or M here.
 
 	  If unsure, say N.
+
+config MMC_SDHCI_EXTERNAL_DMA
+        bool
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a22e11a65658..8b056bb9422d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
 #include <linux/ktime.h>
 #include <linux/highmem.h>
 #include <linux/io.h>
@@ -987,18 +988,9 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
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
@@ -1009,6 +1001,34 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
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
@@ -1100,24 +1120,227 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 
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
+	struct mmc_data *data = cmd->data;
+	struct dma_chan *chan = sdhci_external_dma_channel(host, data);
+
+	if (!sdhci_external_dma_setup(host, cmd)) {
+		__sdhci_external_dma_prepare_data(host, cmd);
 	} else {
-		sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
+		sdhci_external_dma_release(host);
+		pr_err("%s: Cannot use external DMA, switch to the DMA/PIO which standard SDHCI provides.\n",
+		       mmc_hostname(host->mmc));
+		sdhci_prepare_data(host, cmd);
+	}
+}
+
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
+static bool sdhci_external_dma_request_done(struct sdhci_host *host)
+{
+	struct mmc_request *mrq;
+	struct dma_chan *chan;
+	int i;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
+		mrq = host->mrqs_done[i];
+		if (mrq)
+			break;
 	}
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (!mrq)
+		return true;
+
+	sdhci_tasklet_finish(host);
+
+	chan = sdhci_external_dma_channel(host, mrq->data);
+	dmaengine_synchronize(chan);
+
+	return false;
 }
 
+
+static void sdhci_external_dma_tasklet_finish(unsigned long param)
+{
+	struct sdhci_host *host = (struct sdhci_host *)param;
+
+	while (!sdhci_external_dma_request_done(host))
+		;
+}
+#else
+static int sdhci_external_dma_init(struct sdhci_host *host)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline struct dma_chan *
+sdhci_external_dma_channel(struct sdhci_host *host, struct mmc_data *data)
+{
+	return NULL;
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
+static void sdhci_external_dma_tasklet_finish(unsigned long param)
+{}
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
@@ -1215,6 +1438,7 @@ static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
 static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 {
 	int i;
+	struct dma_chan *chan;
 
 	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
 		if (host->mrqs_done[i] == mrq) {
@@ -1232,7 +1456,13 @@ static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 
 	WARN_ON(i >= SDHCI_MAX_MRQS);
 
-	tasklet_schedule(&host->finish_tasklet);
+	if (host->use_external_dma) {
+		chan = sdhci_external_dma_channel(host, mrq->data);
+		dmaengine_terminate_async(chan);
+		tasklet_schedule(&host->external_dma_finish_tasklet);
+	} else {
+		tasklet_schedule(&host->finish_tasklet);
+	}
 }
 
 static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
@@ -1369,12 +1599,19 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
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
 
@@ -1416,6 +1653,9 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		timeout += 10 * HZ;
 	sdhci_mod_timer(host, cmd->mrq, timeout);
 
+	if (host->use_external_dma)
+		sdhci_external_dma_pre_transfer(host, cmd);
+
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
 }
 EXPORT_SYMBOL_GPL(sdhci_send_command);
@@ -1771,6 +2011,7 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	struct sdhci_host *host;
 	int present;
 	unsigned long flags;
+	struct dma_chan *chan;
 
 	host = mmc_priv(mmc);
 
@@ -1781,6 +2022,12 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	sdhci_led_activate(host);
 
+	if (host->use_external_dma && mrq->data) {
+		chan = sdhci_external_dma_channel(host, mrq->data);
+		if (chan)
+			dmaengine_terminate_async(chan);
+	}
+
 	/*
 	 * Ensure we don't send the STOP for non-SET_BLOCK_COUNTED
 	 * requests if Auto-CMD12 is enabled.
@@ -3692,12 +3939,28 @@ int sdhci_setup_host(struct sdhci_host *host)
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
@@ -4201,6 +4464,10 @@ void sdhci_cleanup_host(struct sdhci_host *host)
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
@@ -4216,6 +4483,8 @@ int __sdhci_add_host(struct sdhci_host *host)
 	 */
 	tasklet_init(&host->finish_tasklet,
 		sdhci_tasklet_finish, (unsigned long)host);
+	tasklet_init(&host->external_dma_finish_tasklet,
+		     sdhci_external_dma_tasklet_finish, (unsigned long)host);
 
 	timer_setup(&host->timer, sdhci_timeout_timer, 0);
 	timer_setup(&host->data_timer, sdhci_timeout_data_timer, 0);
@@ -4247,6 +4516,7 @@ int __sdhci_add_host(struct sdhci_host *host)
 
 	pr_info("%s: SDHCI controller on %s [%s] using %s\n",
 		mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
+		host->use_external_dma ? "External DMA" :
 		(host->flags & SDHCI_USE_ADMA) ?
 		(host->flags & SDHCI_USE_64_BIT_DMA) ? "ADMA 64-bit" : "ADMA" :
 		(host->flags & SDHCI_USE_SDMA) ? "DMA" : "PIO");
@@ -4264,6 +4534,7 @@ int __sdhci_add_host(struct sdhci_host *host)
 	free_irq(host->irq, host);
 untasklet:
 	tasklet_kill(&host->finish_tasklet);
+	tasklet_kill(&host->external_dma_finish_tasklet);
 
 	return ret;
 }
@@ -4326,6 +4597,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 	del_timer_sync(&host->data_timer);
 
 	tasklet_kill(&host->finish_tasklet);
+	tasklet_kill(&host->external_dma_finish_tasklet);
 
 	if (!IS_ERR(mmc->supply.vqmmc))
 		regulator_disable(mmc->supply.vqmmc);
@@ -4335,6 +4607,9 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 				  host->adma_table_sz, host->align_buffer,
 				  host->align_addr);
 
+	if (host->use_external_dma)
+		sdhci_external_dma_release(host);
+
 	host->adma_table = NULL;
 	host->align_buffer = NULL;
 }
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6cc9a3c2ac66..43f71b479e0b 100644
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
@@ -555,10 +557,17 @@ struct sdhci_host {
 	unsigned int desc_sz;	/* ADMA descriptor size */
 
 	struct tasklet_struct finish_tasklet;	/* Tasklet structures */
+	/* Tasklet struction for using external dma */
+	struct tasklet_struct external_dma_finish_tasklet;
 
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
@@ -792,5 +801,6 @@ void sdhci_start_tuning(struct sdhci_host *host);
 void sdhci_end_tuning(struct sdhci_host *host);
 void sdhci_reset_tuning(struct sdhci_host *host);
 void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
+void sdhci_switch_external_dma(struct sdhci_host *host, bool en);
 
 #endif /* __SDHCI_HW_H */
-- 
2.17.1
