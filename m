From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/8 v3] mmc: tmio: don't needlessly enable interrupts during probing
Date: Fri, 25 May 2012 17:45:28 +0200
Message-ID: <1337960752-4944-14-git-send-email-g.liakhovetski@gmx.de>
References: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

We don't have to force-enable MMC interrupts in our .probe() method,
mmc_add_host() will trigger card detection, that will enable all the
necessary interrupts.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 0d2643b..8cd3637 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -948,6 +948,17 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 
 	_host->sdcard_irq_mask = sd_ctrl_read32(_host, CTL_IRQ_MASK);
 	tmio_mmc_disable_mmc_irqs(_host, TMIO_MASK_ALL);
+
+	/* Unmask the IRQs we want to know about */
+	if (!_host->chan_rx)
+		irq_mask |= TMIO_MASK_READOP;
+	if (!_host->chan_tx)
+		irq_mask |= TMIO_MASK_WRITEOP;
+	if (!_host->native_hotplug)
+		irq_mask &= ~(TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT);
+
+	_host->sdcard_irq_mask &= ~irq_mask;
+
 	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
 		tmio_mmc_enable_sdio_irq(mmc, 0);
 
@@ -965,16 +976,6 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 
 	dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
 
-	/* Unmask the IRQs we want to know about */
-	if (!_host->chan_rx)
-		irq_mask |= TMIO_MASK_READOP;
-	if (!_host->chan_tx)
-		irq_mask |= TMIO_MASK_WRITEOP;
-	if (!_host->native_hotplug)
-		irq_mask &= ~(TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT);
-
-	tmio_mmc_enable_mmc_irqs(_host, irq_mask);
-
 	if (pdata->flags & TMIO_MMC_USE_GPIO_CD) {
 		ret = mmc_cd_gpio_request(mmc, pdata->cd_gpio);
 		if (ret < 0) {
-- 
1.7.2.5

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
