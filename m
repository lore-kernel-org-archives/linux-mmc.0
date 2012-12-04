From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/3] mmc: sdhci: implement the .card_event() method
Date: Tue, 4 Dec 2012 16:51:40 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1212041650290.26918@axis700.grange>
References: <Pine.LNX.4.64.1212041633470.26918@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64214 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882Ab2LDPwC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Dec 2012 10:52:02 -0500
In-Reply-To: <Pine.LNX.4.64.1212041633470.26918@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Mike Rapoport <mike@compulab.co.il>, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>

Extracting a part of the SDHCI card tasklet into a .card_event()
implementation allows SDHCI hosts to use generic card-detection
services, e.g. the GPIO slot function.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sdhci.c |   48 +++++++++++++++++++++++++--------------------
 1 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c7851c0..2323553 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1994,30 +1994,11 @@ static void sdhci_enable_preset_value(struct mmc_host *mmc, bool enable)
 	sdhci_runtime_pm_put(host);
 }
 
-static const struct mmc_host_ops sdhci_ops = {
-	.request	= sdhci_request,
-	.set_ios	= sdhci_set_ios,
-	.get_ro		= sdhci_get_ro,
-	.hw_reset	= sdhci_hw_reset,
-	.enable_sdio_irq = sdhci_enable_sdio_irq,
-	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
-	.execute_tuning			= sdhci_execute_tuning,
-	.enable_preset_value		= sdhci_enable_preset_value,
-};
-
-/*****************************************************************************\
- *                                                                           *
- * Tasklets                                                                  *
- *                                                                           *
-\*****************************************************************************/
-
-static void sdhci_tasklet_card(unsigned long param)
+static void sdhci_card_event(struct mmc_host *mmc)
 {
-	struct sdhci_host *host;
+	struct sdhci_host *host = mmc_priv(mmc);
 	unsigned long flags;
 
-	host = (struct sdhci_host*)param;
-
 	spin_lock_irqsave(&host->lock, flags);
 
 	/* Check host->mrq first in case we are runtime suspended */
@@ -2036,6 +2017,31 @@ static void sdhci_tasklet_card(unsigned long param)
 	}
 
 	spin_unlock_irqrestore(&host->lock, flags);
+}
+
+static const struct mmc_host_ops sdhci_ops = {
+	.request	= sdhci_request,
+	.set_ios	= sdhci_set_ios,
+	.get_ro		= sdhci_get_ro,
+	.hw_reset	= sdhci_hw_reset,
+	.enable_sdio_irq = sdhci_enable_sdio_irq,
+	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
+	.execute_tuning			= sdhci_execute_tuning,
+	.enable_preset_value		= sdhci_enable_preset_value,
+	.card_event			= sdhci_card_event,
+};
+
+/*****************************************************************************\
+ *                                                                           *
+ * Tasklets                                                                  *
+ *                                                                           *
+\*****************************************************************************/
+
+static void sdhci_tasklet_card(unsigned long param)
+{
+	struct sdhci_host *host = (struct sdhci_host*)param;
+
+	sdhci_card_event(host->mmc);
 
 	mmc_detect_change(host->mmc, msecs_to_jiffies(200));
 }
-- 
1.7.2.5

