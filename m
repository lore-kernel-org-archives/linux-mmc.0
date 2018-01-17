From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 14/16] mmc: tmio: move TMIO_MASK_{READOP,WRITEOP} handling to correct place
Date: Thu, 18 Jan 2018 01:28:14 +0900
Message-ID: <1516206496-16612-15-git-send-email-yamada.masahiro@socionext.com>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

As far as I tested the IP on UniPhier SoCs, TMIO_STAT_{RXRDY,TXRQ}
are asserted for DMA mode as well as for PIO.  I need to disable the
those IRQs in dma_ops->start hook, otherwise the DMA transfer fails
with the following error message:
  PIO IRQ in DMA mode!

Renesas chips are the same cases since I see their dma_ops->start
hooks explicitly clear TMIO_STAT_{RXRDY,TXRQ} (with nice comment!).

If we do this sanity check in TMIO MMC core, RXRDY/TXRQ handling
should be entirely moved to the core.  tmio_mmc_cmd_irq() will
be a suitable place to disable them.

The probe function sets TMIO_MASK_{READOP,WRITEOP} but this is odd.

    /* Unmask the IRQs we want to know about */
    if (!_host->chan_rx)
            irq_mask |= TMIO_MASK_READOP;
    if (!_host->chan_tx)
            irq_mask |= TMIO_MASK_WRITEOP;

At this point, _host->{chan_rx,chan_tx} are _always_ NULL because
tmio_mmc_request_dma() is called after this code.  Consequently,
TMIO_MASK_{READOP,WRITEOP} are set here whether DMA is used or not.
Remove this pointless code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - Remove the first paragraph of git-log
  - Clean up renesas drivers too

Changes in v2:
  - Newly added

 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  6 ------
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  4 ----
 drivers/mmc/host/tmio_mmc_core.c              | 20 ++++++++++----------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 0d1f95e..693ad49 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -145,7 +145,6 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_host *host,
 	u32 dtran_mode = DTRAN_MODE_BUS_WID_TH | DTRAN_MODE_ADDR_MODE;
 	enum dma_data_direction dir;
 	int ret;
-	u32 irq_mask;
 
 	/* This DMAC cannot handle if sg_len is not 1 */
 	WARN_ON(host->sg_len > 1);
@@ -157,11 +156,9 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_host *host,
 	if (data->flags & MMC_DATA_READ) {
 		dtran_mode |= DTRAN_MODE_CH_NUM_CH1;
 		dir = DMA_FROM_DEVICE;
-		irq_mask = TMIO_STAT_RXRDY;
 	} else {
 		dtran_mode |= DTRAN_MODE_CH_NUM_CH0;
 		dir = DMA_TO_DEVICE;
-		irq_mask = TMIO_STAT_TXRQ;
 	}
 
 	ret = dma_map_sg(&host->pdev->dev, sg, host->sg_len, dir);
@@ -170,9 +167,6 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_host *host,
 
 	renesas_sdhi_internal_dmac_enable_dma(host, true);
 
-	/* disable PIO irqs to avoid "PIO IRQ in DMA mode!" */
-	tmio_mmc_disable_mmc_irqs(host, irq_mask);
-
 	/* set dma parameters */
 	renesas_sdhi_internal_dmac_dm_write(host, DM_CM_DTRAN_MODE,
 					    dtran_mode);
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index afdb66b..393df17 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -205,8 +205,6 @@ static void renesas_sdhi_sys_dmac_start_dma_rx(struct tmio_mmc_host *host)
 		return;
 	}
 
-	tmio_mmc_disable_mmc_irqs(host, TMIO_STAT_RXRDY);
-
 	/* The only sg element can be unaligned, use our bounce buffer then */
 	if (!aligned) {
 		sg_init_one(&host->bounce_sg, host->bounce_buf, sg->length);
@@ -280,8 +278,6 @@ static void renesas_sdhi_sys_dmac_start_dma_tx(struct tmio_mmc_host *host)
 		return;
 	}
 
-	tmio_mmc_disable_mmc_irqs(host, TMIO_STAT_TXRQ);
-
 	/* The only sg element can be unaligned, use our bounce buffer then */
 	if (!aligned) {
 		unsigned long flags;
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 0e3dc8c..731552a 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -621,15 +621,21 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host, unsigned int stat)
 	 */
 	if (host->data && (!cmd->error || cmd->error == -EILSEQ)) {
 		if (host->data->flags & MMC_DATA_READ) {
-			if (host->force_pio || !host->chan_rx)
+			if (host->force_pio || !host->chan_rx) {
 				tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_READOP);
-			else
+			} else {
+				tmio_mmc_disable_mmc_irqs(host,
+							  TMIO_MASK_READOP);
 				tasklet_schedule(&host->dma_issue);
+			}
 		} else {
-			if (host->force_pio || !host->chan_tx)
+			if (host->force_pio || !host->chan_tx) {
 				tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_WRITEOP);
-			else
+			} else {
+				tmio_mmc_disable_mmc_irqs(host,
+							  TMIO_MASK_WRITEOP);
 				tasklet_schedule(&host->dma_issue);
+			}
 		}
 	} else {
 		schedule_work(&host->done);
@@ -1287,12 +1293,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	_host->sdcard_irq_mask = sd_ctrl_read16_and_16_as_32(_host, CTL_IRQ_MASK);
 	tmio_mmc_disable_mmc_irqs(_host, TMIO_MASK_ALL);
 
-	/* Unmask the IRQs we want to know about */
-	if (!_host->chan_rx)
-		irq_mask |= TMIO_MASK_READOP;
-	if (!_host->chan_tx)
-		irq_mask |= TMIO_MASK_WRITEOP;
-
 	_host->sdcard_irq_mask &= ~irq_mask;
 
 	if (_host->native_hotplug)
-- 
2.7.4
