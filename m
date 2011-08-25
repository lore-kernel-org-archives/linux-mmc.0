From: Simon Horman <horms@verge.net.au>
Subject: [PATCH v8 1/4] mmc: tmio: Cache interrupt masks
Date: Thu, 25 Aug 2011 10:27:25 +0900
Message-ID: <1314235648-8959-2-git-send-email-horms@verge.net.au>
References: <1314235648-8959-1-git-send-email-horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1314235648-8959-1-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

This avoids the need to look up the masks each time an interrupt
is handled.

As suggested by Guennadi.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Acked-by: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

---

* SDCARD portion tested on AP4/Mackerel
* SDIO portion untested

v3
* As suggested by Guennadi Liakhovetski
  - Only read sdcard_irq_mask once and never read sdio_irq_mask,
    instead use the cached values as much as possible

v2
* Initial release
---
 drivers/mmc/host/tmio_mmc.h     |    4 ++++
 drivers/mmc/host/tmio_mmc_pio.c |   34 ++++++++++++++++++----------------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index eeaf643..1cf8db5 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -79,6 +79,10 @@ struct tmio_mmc_host {
 	struct delayed_work	delayed_reset_work;
 	struct work_struct	done;
 
+	/* Cache IRQ mask */
+	u32			sdcard_irq_mask;
+	u32			sdio_irq_mask;
+
 	spinlock_t		lock;		/* protect host private data */
 	unsigned long		last_req_ts;
 	struct mutex		ios_lock;	/* protect set_ios() context */
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 1f16357..f0c7830 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -48,14 +48,14 @@
 
 void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i)
 {
-	u32 mask = sd_ctrl_read32(host, CTL_IRQ_MASK) & ~(i & TMIO_MASK_IRQ);
-	sd_ctrl_write32(host, CTL_IRQ_MASK, mask);
+	host->sdcard_irq_mask &= ~(i & TMIO_MASK_IRQ);
+	sd_ctrl_write32(host, CTL_IRQ_MASK, host->sdcard_irq_mask);
 }
 
 void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i)
 {
-	u32 mask = sd_ctrl_read32(host, CTL_IRQ_MASK) | (i & TMIO_MASK_IRQ);
-	sd_ctrl_write32(host, CTL_IRQ_MASK, mask);
+	host->sdcard_irq_mask |= (i & TMIO_MASK_IRQ);
+	sd_ctrl_write32(host, CTL_IRQ_MASK, host->sdcard_irq_mask);
 }
 
 static void tmio_mmc_ack_mmc_irqs(struct tmio_mmc_host *host, u32 i)
@@ -127,11 +127,13 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 
 	if (enable) {
 		host->sdio_irq_enabled = 1;
+		host->sdio_irq_mask = TMIO_SDIO_MASK_ALL &
+					~TMIO_SDIO_STAT_IOIRQ;
 		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
-		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK,
-			(TMIO_SDIO_MASK_ALL & ~TMIO_SDIO_STAT_IOIRQ));
+		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
 	} else {
-		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, TMIO_SDIO_MASK_ALL);
+		host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
+		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
 		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0000);
 		host->sdio_irq_enabled = 0;
 	}
@@ -548,26 +550,25 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid)
 	struct tmio_mmc_host *host = devid;
 	struct mmc_host *mmc = host->mmc;
 	struct tmio_mmc_data *pdata = host->pdata;
-	unsigned int ireg, irq_mask, status;
-	unsigned int sdio_ireg, sdio_irq_mask, sdio_status;
+	unsigned int ireg, status;
+	unsigned int sdio_ireg, sdio_status;
 
 	pr_debug("MMC IRQ begin\n");
 
 	status = sd_ctrl_read32(host, CTL_STATUS);
-	irq_mask = sd_ctrl_read32(host, CTL_IRQ_MASK);
-	ireg = status & TMIO_MASK_IRQ & ~irq_mask;
+	ireg = status & TMIO_MASK_IRQ & ~host->sdcard_irq_mask;
 
 	sdio_ireg = 0;
 	if (!ireg && pdata->flags & TMIO_MMC_SDIO_IRQ) {
 		sdio_status = sd_ctrl_read16(host, CTL_SDIO_STATUS);
-		sdio_irq_mask = sd_ctrl_read16(host, CTL_SDIO_IRQ_MASK);
-		sdio_ireg = sdio_status & TMIO_SDIO_MASK_ALL & ~sdio_irq_mask;
+		sdio_ireg = sdio_status & TMIO_SDIO_MASK_ALL &
+				~host->sdio_irq_mask;
 
 		sd_ctrl_write16(host, CTL_SDIO_STATUS, sdio_status & ~TMIO_SDIO_MASK_ALL);
 
 		if (sdio_ireg && !host->sdio_irq_enabled) {
 			pr_warning("tmio_mmc: Spurious SDIO IRQ, disabling! 0x%04x 0x%04x 0x%04x\n",
-				   sdio_status, sdio_irq_mask, sdio_ireg);
+				   sdio_status, host->sdio_irq_mask, sdio_ireg);
 			tmio_mmc_enable_sdio_irq(mmc, 0);
 			goto out;
 		}
@@ -623,9 +624,9 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid)
 	}
 
 	pr_warning("tmio_mmc: Spurious irq, disabling! "
-		"0x%08x 0x%08x 0x%08x\n", status, irq_mask, ireg);
+		"0x%08x 0x%08x 0x%08x\n", status, host->sdcard_irq_mask, ireg);
 	pr_debug_status(status);
-	tmio_mmc_disable_mmc_irqs(host, status & ~irq_mask);
+	tmio_mmc_disable_mmc_irqs(host, status & ~host->sdcard_irq_mask);
 
 out:
 	return IRQ_HANDLED;
@@ -882,6 +883,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	tmio_mmc_clk_stop(_host);
 	tmio_mmc_reset(_host);
 
+	_host->sdcard_irq_mask = sd_ctrl_read32(_host, CTL_IRQ_MASK);
 	tmio_mmc_disable_mmc_irqs(_host, TMIO_MASK_ALL);
 	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
 		tmio_mmc_enable_sdio_irq(mmc, 0);
-- 
1.7.5.4

