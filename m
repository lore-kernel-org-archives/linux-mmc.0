From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC 3/3] mmc: tmio: discard obsolete SDIO irqs before enabling irqs
Date: Thu,  5 Jan 2017 12:43:26 +0100
Message-ID: <20170105114326.12426-4-wsa+renesas@sang-engineering.com>
References: <20170105114326.12426-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:47358 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970584AbdAELuY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 5 Jan 2017 06:50:24 -0500
In-Reply-To: <20170105114326.12426-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Before enabling SDIO irqs, clear the status bit, so we discard old and
stale interrupts. Needed to get two wireless cards working.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index d6033620a45c12..ebe3e12f0083dd 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -134,12 +134,21 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
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
+			sdio_status |= 6;
+		sd_ctrl_write16(host, CTL_SDIO_STATUS, sdio_status);
+
 		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
 	} else if (!enable && host->sdio_irq_enabled) {
 		host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
-- 
2.11.0

