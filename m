From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 08/11] mmc: tmio_mmc: remove unused sdio_irq_enabled flag
Date: Tue, 24 Jan 2012 13:01:37 +0100
Message-ID: <1327406500-7233-9-git-send-email-g.liakhovetski@gmx.de>
References: <1327406500-7233-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1327406500-7233-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

The sdio_irq_enabled member of struct tmio_mmc_host is a left-over from the
previously removed SDIO IRQ workaround. It is no longer needed and can now
be removed too.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.h     |    1 -
 drivers/mmc/host/tmio_mmc_pio.c |    2 --
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index edfcfd7..d857f5c 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -47,7 +47,6 @@ struct tmio_mmc_host {
 	struct mmc_request      *mrq;
 	struct mmc_data         *data;
 	struct mmc_host         *mmc;
-	unsigned int		sdio_irq_enabled;
 
 	/* Controller power state */
 	bool			power;
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index eee9f4f..d7955c6 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -127,7 +127,6 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 
 	if (enable) {
-		host->sdio_irq_enabled = 1;
 		host->sdio_irq_mask = TMIO_SDIO_MASK_ALL &
 					~TMIO_SDIO_STAT_IOIRQ;
 		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
@@ -136,7 +135,6 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 		host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
 		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
 		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0000);
-		host->sdio_irq_enabled = 0;
 	}
 }
 
-- 
1.7.2.5

