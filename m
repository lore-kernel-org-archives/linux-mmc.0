From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/8] mmc: tmio: Keep host active while SDIO irq is enabled
Date: Fri,  8 Nov 2013 07:06:12 +0100
Message-ID: <1383890776-6912-5-git-send-email-ulf.hansson@linaro.org>
References: <1383890776-6912-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:59081 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab3KHGGa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Nov 2013 01:06:30 -0500
Received: by mail-la0-f51.google.com with SMTP id ep20so1401846lab.10
        for <linux-mmc@vger.kernel.org>; Thu, 07 Nov 2013 22:06:29 -0800 (PST)
In-Reply-To: <1383890776-6912-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

The host must be kept active to be able to serve with SDIO irqs. We
prevent it from being put into in-active while the SDIO irq is enabled
by simply adding balanced calls to pm_runtime_get|put.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/tmio_mmc.h     |    1 +
 drivers/mmc/host/tmio_mmc_pio.c |   19 +++++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 6c5b45a..c2c9546 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -102,6 +102,7 @@ struct tmio_mmc_host {
 	struct mutex		ios_lock;	/* protect set_ios() context */
 	bool			native_hotplug;
 	bool			resuming;
+	bool			sdio_irq_enabled;
 };
 
 int tmio_mmc_host_probe(struct tmio_mmc_host **host,
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 472e803..377157e 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -129,15 +129,22 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 
-	if (enable) {
+	if (enable && !host->sdio_irq_enabled) {
+		/* Keep device active while SDIO irq is enabled */
+		pm_runtime_get_sync(mmc_dev(mmc));
+		host->sdio_irq_enabled = true;
+
 		host->sdio_irq_mask = TMIO_SDIO_MASK_ALL &
 					~TMIO_SDIO_STAT_IOIRQ;
 		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
 		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
-	} else {
+	} else if (!enable && host->sdio_irq_enabled) {
 		host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
 		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
 		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0000);
+
+		host->sdio_irq_enabled = false;
+		pm_runtime_put(mmc_dev(mmc));
 	}
 }
 
@@ -1072,8 +1079,12 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 
 	_host->sdcard_irq_mask &= ~irq_mask;
 
-	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
-		tmio_mmc_enable_sdio_irq(mmc, 0);
+	_host->sdio_irq_enabled = false;
+	if (pdata->flags & TMIO_MMC_SDIO_IRQ) {
+		_host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
+		sd_ctrl_write16(_host, CTL_SDIO_IRQ_MASK, _host->sdio_irq_mask);
+		sd_ctrl_write16(_host, CTL_TRANSACTION_CTL, 0x0000);
+	}
 
 	spin_lock_init(&_host->lock);
 	mutex_init(&_host->ios_lock);
-- 
1.7.9.5

