From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 17/22] mmc: tmio: move TMIO_MASK_{READOP,WRITEOP} handling to correct place
Date: Sat, 25 Nov 2017 01:24:52 +0900
Message-ID: <1511540697-27387-18-git-send-email-yamada.masahiro@socionext.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This driver was largely extended by Renesas, but actually used by
several SoC vendors.  The current code does not work for UniPhier
SoCs at least.

The DMA mode for UniPhier SoCs failed with the following error message:
  PIO IRQ in DMA mode!

For UniPhier SoCs, the TMIO_MASK_{READOP,WRITEOP} are asserted in the
DMA mode as well.

In fact, the code is very strange.

The TMIO_MASK_{READOP,WRITEOP} IRQs are set as follows:

    /* Unmask the IRQs we want to know about */
    if (!_host->chan_rx)
            irq_mask |= TMIO_MASK_READOP;
    if (!_host->chan_tx)
            irq_mask |= TMIO_MASK_WRITEOP;

At this point, _host->{chan_rx,chan_tx} are _always_ NULL because
tmio_mmc_request_dma() is called after this code.  Consequently,
TMIO_MASK_{READOP,WRITEOP} are set whether DMA is used or not.

tmio_mmc_cmd_irq() enables TMIO_MASK_{READOP,WRITEOP}, but never
disables them.  This does not take care of a case where ->force_pio
is set, but unset later.

After all, the correct place to handle those flags is just before
starting the data transfer.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Newly added

 drivers/mmc/host/tmio_mmc_core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 7d169ed..345e379 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -621,15 +621,19 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host, unsigned int stat)
 	 */
 	if (host->data && (!cmd->error || cmd->error == -EILSEQ)) {
 		if (host->data->flags & MMC_DATA_READ) {
-			if (host->force_pio || !host->chan_rx)
+			if (host->force_pio || !host->chan_rx) {
 				tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_READOP);
-			else
+			} else {
+				tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_READOP);
 				tasklet_schedule(&host->dma_issue);
+			}
 		} else {
-			if (host->force_pio || !host->chan_tx)
+			if (host->force_pio || !host->chan_tx) {
 				tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_WRITEOP);
-			else
+			} else {
+				tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_WRITEOP);
 				tasklet_schedule(&host->dma_issue);
+			}
 		}
 	} else {
 		schedule_work(&host->done);
@@ -1285,12 +1289,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
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
