From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 3/3] mmc: tmio: discard obsolete SDIO irqs before enabling irqs
Date: Thu, 19 Jan 2017 21:07:18 +0100
Message-ID: <20170119200718.8115-4-wsa+renesas@sang-engineering.com>
References: <20170119200718.8115-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49373 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1754461AbdASUPo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Jan 2017 15:15:44 -0500
In-Reply-To: <20170119200718.8115-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Before enabling SDIO irqs, clear the status bit, so we discard old and
stale interrupts. Needed to get two wireless cards working. Use the
newly introduced macro in all places.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since RFC: use #define for SETBITS_MASK

 drivers/mmc/host/tmio_mmc.h     |  2 ++
 drivers/mmc/host/tmio_mmc_pio.c | 13 +++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 931d67a059adf0..efe6e6ae9d3d71 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -90,6 +90,8 @@
 #define TMIO_SDIO_STAT_EXWT	0x8000
 #define TMIO_SDIO_MASK_ALL	0xc007
 
+#define TMIO_SDIO_SETBITS_MASK	0x0006
+
 /* Define some IRQ masks */
 /* This is the mask used at reset by the chip */
 #define TMIO_MASK_ALL           0x837f031d
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index f21e6a1b1a9206..cb3c4103de156b 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -180,12 +180,21 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 
 	if (enable && !host->sdio_irq_enabled) {
+		u16 sdio_status;
+
 		/* Keep device active while SDIO irq is enabled */
 		pm_runtime_get_sync(mmc_dev(mmc));
-		host->sdio_irq_enabled = true;
 
+		host->sdio_irq_enabled = true;
 		host->sdio_irq_mask = TMIO_SDIO_MASK_ALL &
 					~TMIO_SDIO_STAT_IOIRQ;
+
+		/* Clear obsolete interrupts before enabling */
+		sdio_status = sd_ctrl_read16(host, CTL_SDIO_STATUS) & ~TMIO_SDIO_MASK_ALL;
+		if (host->pdata->flags & TMIO_MMC_SDIO_STATUS_SETBITS)
+			sdio_status |= TMIO_SDIO_SETBITS_MASK;
+		sd_ctrl_write16(host, CTL_SDIO_STATUS, sdio_status);
+
 		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
 	} else if (!enable && host->sdio_irq_enabled) {
 		host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
@@ -771,7 +780,7 @@ static void __tmio_mmc_sdio_irq(struct tmio_mmc_host *host)
 
 	sdio_status = status & ~TMIO_SDIO_MASK_ALL;
 	if (pdata->flags & TMIO_MMC_SDIO_STATUS_SETBITS)
-		sdio_status |= 6;
+		sdio_status |= TMIO_SDIO_SETBITS_MASK;
 
 	sd_ctrl_write16(host, CTL_SDIO_STATUS, sdio_status);
 
-- 
2.11.0

