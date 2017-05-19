From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFT PATCH] mmc: tmio: make sure SDIO gets reinitialized after resume
Date: Fri, 19 May 2017 14:30:52 +0200
Message-ID: <20170519123052.26565-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46482 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752050AbdESMa4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 19 May 2017 08:30:56 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Yasushi SHOJI <yashi@atmark-techno.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

To achieve that, we set the registers in the generic HW reset routine
which gets called at both, init and resume. We also make sure to move
SDIO initialization before reset gets called in probe().

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

This patch addresses a report I got from Shimoda-san. I can't really test it
because the SDIO cards I have all require MMC_PM_KEEP_POWER to suspend and
that we don't support. So, I send this out to ask for testing. At least it
didn't cause regressions for the setup I used. To make testing easier, this
is *not* put on top of Simon's SDHI DMA rework patches, so it should apply
on current upstream and development branches.

 drivers/mmc/host/tmio_mmc_pio.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index a2d92f10501bdd..5e87fcaa99d430 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -229,6 +229,12 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
 	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
 		sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
 	msleep(10);
+
+	if (host->pdata->flags & TMIO_MMC_SDIO_IRQ) {
+		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
+		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
+	}
+
 }
 
 static void tmio_mmc_reset_work(struct work_struct *work)
@@ -1221,6 +1227,10 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	if (_host->native_hotplug)
 		pm_runtime_get_noresume(&pdev->dev);
 
+	_host->sdio_irq_enabled = false;
+	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
+		_host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
+
 	tmio_mmc_clk_stop(_host);
 	tmio_mmc_reset(_host);
 
@@ -1237,13 +1247,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 
 	_host->sdcard_irq_mask &= ~irq_mask;
 
-	_host->sdio_irq_enabled = false;
-	if (pdata->flags & TMIO_MMC_SDIO_IRQ) {
-		_host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
-		sd_ctrl_write16(_host, CTL_SDIO_IRQ_MASK, _host->sdio_irq_mask);
-		sd_ctrl_write16(_host, CTL_TRANSACTION_CTL, 0x0001);
-	}
-
 	spin_lock_init(&_host->lock);
 	mutex_init(&_host->ios_lock);
 
-- 
2.11.0

