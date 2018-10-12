From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] mmc: tmio: simplify the DMA mode test
Date: Sat, 13 Oct 2018 00:03:08 +0900
Message-ID: <1539356588-18191-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

host->chan_{rx,tx} represents the DMA capability of the platform.
Even if DMA is supported, there are cases where we want to use PIO,
for example, data length is short enough as commit 5f52c3552946
("mmc: tmio: use PIO for short transfers") mentioned.

Regarding the hardware control flow, we are interested in whether DMA
is currently enabled or not, instead of whether the platform has the
DMA capability.

Hence, the several conditionals in tmio_mmc_core.c end up with
checking host->chan_{rx,tx} and !host->force_pio. This is not nice.

Let's flip the flag host->force_pio into host->dma_on.

host->dma_on represents whether the DMA is currently enabled or not.
This flag is set false in the beginning of each command, then should
be set true by tmio_mmc_start_dma() when the DMA is turned on.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 ++-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 10 ++++------
 drivers/mmc/host/tmio_mmc.h                   |  2 +-
 drivers/mmc/host/tmio_mmc_core.c              | 14 +++++++-------
 drivers/mmc/host/uniphier-sd.c                |  6 ++++--
 5 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index ca0b439..885676b 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -201,13 +201,14 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_host *host,
 	renesas_sdhi_internal_dmac_dm_write(host, DM_DTRAN_ADDR,
 					    sg_dma_address(sg));
 
+	host->dma_on = true;
+
 	return;
 
 force_pio_with_unmap:
 	dma_unmap_sg(&host->pdev->dev, sg, host->sg_len, mmc_get_dma_dir(data));
 
 force_pio:
-	host->force_pio = true;
 	renesas_sdhi_internal_dmac_enable_dma(host, false);
 }
 
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 5389c48..3c97831 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -213,10 +213,8 @@ static void renesas_sdhi_sys_dmac_start_dma_rx(struct tmio_mmc_host *host)
 		goto pio;
 	}
 
-	if (sg->length < TMIO_MMC_MIN_DMA_LEN) {
-		host->force_pio = true;
+	if (sg->length < TMIO_MMC_MIN_DMA_LEN)
 		return;
-	}
 
 	/* The only sg element can be unaligned, use our bounce buffer then */
 	if (!aligned) {
@@ -240,6 +238,7 @@ static void renesas_sdhi_sys_dmac_start_dma_rx(struct tmio_mmc_host *host)
 			desc = NULL;
 			ret = cookie;
 		}
+		host->dma_on = true;
 	}
 pio:
 	if (!desc) {
@@ -286,10 +285,8 @@ static void renesas_sdhi_sys_dmac_start_dma_tx(struct tmio_mmc_host *host)
 		goto pio;
 	}
 
-	if (sg->length < TMIO_MMC_MIN_DMA_LEN) {
-		host->force_pio = true;
+	if (sg->length < TMIO_MMC_MIN_DMA_LEN)
 		return;
-	}
 
 	/* The only sg element can be unaligned, use our bounce buffer then */
 	if (!aligned) {
@@ -318,6 +315,7 @@ static void renesas_sdhi_sys_dmac_start_dma_tx(struct tmio_mmc_host *host)
 			desc = NULL;
 			ret = cookie;
 		}
+		host->dma_on = true;
 	}
 pio:
 	if (!desc) {
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 18b4308..1c3bdad 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -142,7 +142,7 @@ struct tmio_mmc_host {
 	struct tmio_mmc_data *pdata;
 
 	/* DMA support */
-	bool			force_pio;
+	bool			dma_on;
 	struct dma_chan		*chan_rx;
 	struct dma_chan		*chan_tx;
 	struct tasklet_struct	dma_issue;
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index a571106..38be3fc 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -364,7 +364,7 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 	unsigned int count;
 	unsigned long flags;
 
-	if ((host->chan_tx || host->chan_rx) && !host->force_pio) {
+	if (host->dma_on) {
 		pr_err("PIO IRQ in DMA mode!\n");
 		return;
 	} else if (!data) {
@@ -436,7 +436,7 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 	 */
 
 	if (data->flags & MMC_DATA_READ) {
-		if (host->chan_rx && !host->force_pio)
+		if (host->dma_on)
 			tmio_mmc_check_bounce_buffer(host);
 		dev_dbg(&host->pdev->dev, "Complete Rx request %p\n",
 			host->mrq);
@@ -473,7 +473,7 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host, unsigned int stat)
 	if (stat & TMIO_STAT_CRCFAIL || stat & TMIO_STAT_STOPBIT_ERR ||
 	    stat & TMIO_STAT_TXUNDERRUN)
 		data->error = -EILSEQ;
-	if (host->chan_tx && (data->flags & MMC_DATA_WRITE) && !host->force_pio) {
+	if (host->dma_on && (data->flags & MMC_DATA_WRITE)) {
 		u32 status = sd_ctrl_read16_and_16_as_32(host, CTL_STATUS);
 		bool done = false;
 
@@ -497,7 +497,7 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host, unsigned int stat)
 			tmio_mmc_disable_mmc_irqs(host, TMIO_STAT_DATAEND);
 			tmio_mmc_dataend_dma(host);
 		}
-	} else if (host->chan_rx && (data->flags & MMC_DATA_READ) && !host->force_pio) {
+	} else if (host->dma_on && (data->flags & MMC_DATA_READ)) {
 		tmio_mmc_disable_mmc_irqs(host, TMIO_STAT_DATAEND);
 		tmio_mmc_dataend_dma(host);
 	} else {
@@ -550,7 +550,7 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host, unsigned int stat)
 	 */
 	if (host->data && (!cmd->error || cmd->error == -EILSEQ)) {
 		if (host->data->flags & MMC_DATA_READ) {
-			if (host->force_pio || !host->chan_rx) {
+			if (!host->dma_on) {
 				tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_READOP);
 			} else {
 				tmio_mmc_disable_mmc_irqs(host,
@@ -558,7 +558,7 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host, unsigned int stat)
 				tasklet_schedule(&host->dma_issue);
 			}
 		} else {
-			if (host->force_pio || !host->chan_tx) {
+			if (!host->dma_on) {
 				tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_WRITEOP);
 			} else {
 				tmio_mmc_disable_mmc_irqs(host,
@@ -688,7 +688,7 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
 
 	tmio_mmc_init_sg(host, data);
 	host->data = data;
-	host->force_pio = false;
+	host->dma_on = false;
 
 	/* Set transfer length / blocksize */
 	sd_ctrl_write16(host, CTL_SD_XFER_LEN, data->blksz);
diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 1ee9fd0..91a2be4 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -157,13 +157,14 @@ static void uniphier_sd_external_dma_start(struct tmio_mmc_host *host,
 	if (cookie < 0)
 		goto unmap_sg;
 
+	host->dma_on = true;
+
 	return;
 
 unmap_sg:
 	dma_unmap_sg(mmc_dev(host->mmc), host->sg_ptr, host->sg_len,
 		     priv->dma_dir);
 force_pio:
-	host->force_pio = true;
 	uniphier_sd_dma_endisable(host, 0);
 }
 
@@ -283,9 +284,10 @@ static void uniphier_sd_internal_dma_start(struct tmio_mmc_host *host,
 	writel(lower_32_bits(dma_addr), host->ctl + UNIPHIER_SD_DMA_ADDR_L);
 	writel(upper_32_bits(dma_addr), host->ctl + UNIPHIER_SD_DMA_ADDR_H);
 
+	host->dma_on = true;
+
 	return;
 force_pio:
-	host->force_pio = true;
 	uniphier_sd_dma_endisable(host, 0);
 }
 
-- 
2.7.4
