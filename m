From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 3/4] mmc: mmci: Prepare for SDIO before setting up DMA job
Date: Tue, 27 Sep 2011 09:46:43 +0200
Message-ID: <1317109603-17975-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:44420 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751303Ab1I0HrW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Sep 2011 03:47:22 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

Move the SDIO preparation to be done before the DMA job is setup.
This makes it possible to do DMA for SDIO transfers as well as the
earlier supported pio mode.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
---
 drivers/mmc/host/mmci.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f1d27d9..cd3bc25 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -604,6 +604,11 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	if (data->flags & MMC_DATA_READ)
 		datactrl |= MCI_DPSM_DIRECTION;
 
+	/* The ST Micro variants has a special bit to enable SDIO */
+	if (variant->sdio && host->mmc->card)
+		if (mmc_card_sdio(host->mmc->card))
+			datactrl |= MCI_ST_DPSM_SDIOEN;
+
 	/*
 	 * Attempt to use DMA operation mode, if this
 	 * should fail, fall back to PIO mode
@@ -632,11 +637,6 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 		irqmask = MCI_TXFIFOHALFEMPTYMASK;
 	}
 
-	/* The ST Micro variants has a special bit to enable SDIO */
-	if (variant->sdio && host->mmc->card)
-		if (mmc_card_sdio(host->mmc->card))
-			datactrl |= MCI_ST_DPSM_SDIOEN;
-
 	writel(datactrl, base + MMCIDATACTRL);
 	writel(readl(base + MMCIMASK0) & ~MCI_DATAENDMASK, base + MMCIMASK0);
 	mmci_set_mask1(host, irqmask);
-- 
1.7.5.4

