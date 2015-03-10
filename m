From: Scott Branden <sbranden@broadcom.com>
Subject: [PATCH] mmc: sdhci: fix card presence logic in sdhci_request function
Date: Tue, 10 Mar 2015 11:35:10 -0700
Message-ID: <1426012510-15890-1-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:10783 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbbCJSfW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Mar 2015 14:35:22 -0400
In-Reply-To: <Scott Branden <sbranden@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: bcm-kernel-feedback-list@broadcom.com, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Ray Jui <rjui@broadcom.com>, Jonathan Richardson <jonathar@broadcom.com>, Corneliu Doban <cdoban@broadcom.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazao <anatol@google.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Scott Branden <sbranden@broadcom.com>

The sdhci_request function should consider a non-removable device
always present.
Call the correct logic already available in sdhci_do_get_cd function.

This fixes some logic paths where MMC requests are being made to
non-removable devices that do not have the card detect pin connected
on the hardware as it is non-removable.

Signed-off-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/mmc/host/sdhci.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0ad412a..bafc7ac 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -56,6 +56,7 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
 static int sdhci_pre_dma_transfer(struct sdhci_host *host,
 					struct mmc_data *data,
 					struct sdhci_host_next *next);
+static int sdhci_do_get_cd(struct sdhci_host *host);
 
 #ifdef CONFIG_PM
 static int sdhci_runtime_pm_get(struct sdhci_host *host);
@@ -1356,7 +1357,8 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	sdhci_runtime_pm_get(host);
 
-	present = mmc_gpio_get_cd(host->mmc);
+	/* Firstly check card presence */
+	present = sdhci_do_get_cd(host);
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -1379,22 +1381,6 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	host->mrq = mrq;
 
-	/*
-	 * Firstly check card presence from cd-gpio.  The return could
-	 * be one of the following possibilities:
-	 *     negative: cd-gpio is not available
-	 *     zero: cd-gpio is used, and card is removed
-	 *     one: cd-gpio is used, and card is present
-	 */
-	if (present < 0) {
-		/* If polling, assume that the card is always present. */
-		if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
-			present = 1;
-		else
-			present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
-					SDHCI_CARD_PRESENT;
-	}
-
 	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
 		host->mrq->cmd->error = -ENOMEDIUM;
 		tasklet_schedule(&host->finish_tasklet);
-- 
2.3.0

