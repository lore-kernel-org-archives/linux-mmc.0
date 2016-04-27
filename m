From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v3 1/5] mmc: tmio: give read32/write32 functions more descriptive names
Date: Wed, 27 Apr 2016 18:51:23 +0200
Message-ID: <1461775887-12786-2-git-send-email-wsa@the-dreams.de>
References: <1461775887-12786-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1461775887-12786-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Looking at the backlogs, I am not the only one who missed that the above
functions do not read u32 from one register, but create a virtual u32
from reading to adjacent u16 registers (which depending on 'bus_shift'
can be up to 8 byte apart). Because this driver supports old hardware
for which we don't have documentation, I first wrongly assumed there was
a variant which had a few u32 registers. Let's give the functions more
descriptive names to make it more obvious what is happening.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc.h     |  5 ++---
 drivers/mmc/host/tmio_mmc_pio.c | 22 +++++++++++-----------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 439fdad2bad91d..e75e5ca220bc0a 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -232,7 +232,7 @@ static inline void sd_ctrl_read16_rep(struct tmio_mmc_host *host, int addr,
 	readsw(host->ctl + (addr << host->bus_shift), buf, count);
 }
 
-static inline u32 sd_ctrl_read32(struct tmio_mmc_host *host, int addr)
+static inline u32 sd_ctrl_read16_and_16_as_32(struct tmio_mmc_host *host, int addr)
 {
 	return readw(host->ctl + (addr << host->bus_shift)) |
 	       readw(host->ctl + ((addr + 2) << host->bus_shift)) << 16;
@@ -254,11 +254,10 @@ static inline void sd_ctrl_write16_rep(struct tmio_mmc_host *host, int addr,
 	writesw(host->ctl + (addr << host->bus_shift), buf, count);
 }
 
-static inline void sd_ctrl_write32(struct tmio_mmc_host *host, int addr, u32 val)
+static inline void sd_ctrl_write32_as_16_and_16(struct tmio_mmc_host *host, int addr, u32 val)
 {
 	writew(val, host->ctl + (addr << host->bus_shift));
 	writew(val >> 16, host->ctl + ((addr + 2) << host->bus_shift));
 }
 
-
 #endif
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 0b52ef1271a5cd..3635940bc31d1b 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -55,18 +55,18 @@
 void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i)
 {
 	host->sdcard_irq_mask &= ~(i & TMIO_MASK_IRQ);
-	sd_ctrl_write32(host, CTL_IRQ_MASK, host->sdcard_irq_mask);
+	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask);
 }
 
 void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i)
 {
 	host->sdcard_irq_mask |= (i & TMIO_MASK_IRQ);
-	sd_ctrl_write32(host, CTL_IRQ_MASK, host->sdcard_irq_mask);
+	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask);
 }
 
 static void tmio_mmc_ack_mmc_irqs(struct tmio_mmc_host *host, u32 i)
 {
-	sd_ctrl_write32(host, CTL_STATUS, ~i);
+	sd_ctrl_write32_as_16_and_16(host, CTL_STATUS, ~i);
 }
 
 static void tmio_mmc_init_sg(struct tmio_mmc_host *host, struct mmc_data *data)
@@ -375,7 +375,7 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command
 	tmio_mmc_enable_mmc_irqs(host, irq_mask);
 
 	/* Fire off the command */
-	sd_ctrl_write32(host, CTL_ARG_REG, cmd->arg);
+	sd_ctrl_write32_as_16_and_16(host, CTL_ARG_REG, cmd->arg);
 	sd_ctrl_write16(host, CTL_SD_CMD, c);
 
 	return 0;
@@ -530,7 +530,7 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
 		goto out;
 
 	if (host->chan_tx && (data->flags & MMC_DATA_WRITE) && !host->force_pio) {
-		u32 status = sd_ctrl_read32(host, CTL_STATUS);
+		u32 status = sd_ctrl_read16_and_16_as_32(host, CTL_STATUS);
 		bool done = false;
 
 		/*
@@ -585,7 +585,7 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 	 */
 
 	for (i = 3, addr = CTL_RESPONSE ; i >= 0 ; i--, addr += 4)
-		cmd->resp[i] = sd_ctrl_read32(host, addr);
+		cmd->resp[i] = sd_ctrl_read16_and_16_as_32(host, addr);
 
 	if (cmd->flags &  MMC_RSP_136) {
 		cmd->resp[0] = (cmd->resp[0] << 8) | (cmd->resp[1] >> 24);
@@ -702,14 +702,14 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid)
 	struct tmio_mmc_host *host = devid;
 	unsigned int ireg, status;
 
-	status = sd_ctrl_read32(host, CTL_STATUS);
+	status = sd_ctrl_read16_and_16_as_32(host, CTL_STATUS);
 	ireg = status & TMIO_MASK_IRQ & ~host->sdcard_irq_mask;
 
 	pr_debug_status(status);
 	pr_debug_status(ireg);
 
 	/* Clear the status except the interrupt status */
-	sd_ctrl_write32(host, CTL_STATUS, TMIO_MASK_IRQ);
+	sd_ctrl_write32_as_16_and_16(host, CTL_STATUS, TMIO_MASK_IRQ);
 
 	if (__tmio_mmc_card_detect_irq(host, ireg, status))
 		return IRQ_HANDLED;
@@ -944,7 +944,7 @@ static int tmio_mmc_get_ro(struct mmc_host *mmc)
 		return ret;
 
 	ret = !((pdata->flags & TMIO_MMC_WRPROTECT_DISABLE) ||
-		(sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT));
+		(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT));
 
 	return ret;
 }
@@ -964,7 +964,7 @@ static int tmio_mmc_card_busy(struct mmc_host *mmc)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 
-	return !(sd_ctrl_read32(host, CTL_STATUS2) & TMIO_STATUS2_DAT0);
+	return !(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS2) & TMIO_STATUS2_DAT0);
 }
 
 static struct mmc_host_ops tmio_mmc_ops = {
@@ -1113,7 +1113,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	tmio_mmc_clk_stop(_host);
 	tmio_mmc_reset(_host);
 
-	_host->sdcard_irq_mask = sd_ctrl_read32(_host, CTL_IRQ_MASK);
+	_host->sdcard_irq_mask = sd_ctrl_read16_and_16_as_32(_host, CTL_IRQ_MASK);
 	tmio_mmc_disable_mmc_irqs(_host, TMIO_MASK_ALL);
 
 	/* Unmask the IRQs we want to know about */
-- 
2.7.0
