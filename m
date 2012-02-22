From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: tmio_mmc: do not enable card hotplug interrupts, if
 unused
Date: Wed, 22 Feb 2012 13:16:09 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1202221314351.3136@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

If TMIO MMC is used in polling mode, or the card is non-removable, or
card-detection is performed, using an external interrupt, there is no
need to enable controller native card hotplug interrupts.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 69b826a..6294c91 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -302,6 +302,7 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command
 {
 	struct mmc_data *data = host->data;
 	int c = cmd->opcode;
+	u32 irq_mask = TMIO_MASK_CMD;
 
 	/* Command 12 is handled by hardware */
 	if (cmd->opcode == 12 && !cmd->arg) {
@@ -337,7 +338,9 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command
 			c |= TRANSFER_READ;
 	}
 
-	tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_CMD);
+	if (!host->native_hotplug)
+		irq_mask &= ~(TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT);
+	tmio_mmc_enable_mmc_irqs(host, irq_mask);
 
 	/* Fire off the command */
 	sd_ctrl_write32(host, CTL_ARG_REG, cmd->arg);
@@ -966,6 +969,8 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 		irq_mask |= TMIO_MASK_READOP;
 	if (!_host->chan_tx)
 		irq_mask |= TMIO_MASK_WRITEOP;
+	if (!_host->native_hotplug)
+		irq_mask &= ~(TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT);
 
 	tmio_mmc_enable_mmc_irqs(_host, irq_mask);
 
-- 
1.7.2.5

