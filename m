From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH/RFC] mmc: ignore asynchronous calls on dead buses
Date: Wed, 15 Jun 2011 15:28:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1106151349260.23363@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:59123 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173Ab1FON2e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2011 09:28:34 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

MMC host drivers have three main asynchronous event types, that they 
report to the MMC core: request completions, SDIO interrupts and card 
hotplug events. Avoid processing these calls during driver removal.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

This is my attempt to answer my own question:

http://article.gmane.org/gmane.linux.kernel.mmc/8280

All these races are very unlikely, but can be triggered artificially by 
inserting a delay in host drivers after mmc_remove_host().

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 68091dd..c11e47b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -95,6 +95,9 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 	struct mmc_command *cmd = mrq->cmd;
 	int err = cmd->error;
 
+	if (host->bus_dead)
+		return;
+
 	if (err && cmd->retries && mmc_host_is_spi(host)) {
 		if (cmd->resp[0] & R1_SPI_ILLEGAL_COMMAND)
 			cmd->retries = 0;
@@ -1162,7 +1165,8 @@ void mmc_detect_change(struct mmc_host *host, unsigned long delay)
 	spin_unlock_irqrestore(&host->lock, flags);
 #endif
 
-	mmc_schedule_delayed_work(&host->detect, delay);
+	if (!host->bus_dead)
+		mmc_schedule_delayed_work(&host->detect, delay);
 }
 
 EXPORT_SYMBOL(mmc_detect_change);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 1ee4424..1a1f2a4 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -311,6 +311,9 @@ extern void mmc_request_done(struct mmc_host *, struct mmc_request *);
 
 static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 {
+	if (host->bus_dead)
+		return;
+
 	host->ops->enable_sdio_irq(host, 0);
 	wake_up_process(host->sdio_irq_thread);
 }
