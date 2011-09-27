From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 4/4] mmc: mmci: Fix incorrect handling of HW flow control for SDIO
Date: Tue, 27 Sep 2011 09:46:56 +0200
Message-ID: <1317109616-18010-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:45238 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751150Ab1I0HrO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Sep 2011 03:47:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

For data writes smaller <= 8 bytes (only SDIO case), HW flow control was
disabled but never re-enabled again. This meant that a following large read
request would randomly give buffer overrun errors.

Moreover HW flow control is not needed for transfers that fits in the
FIFO of PL18x. Thus it is disabled for write operations <= the FIFO size.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
---
 drivers/mmc/host/mmci.c |   42 ++++++++++++++++++++++++------------------
 1 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index cd3bc25..4da20ec 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -606,9 +606,32 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 
 	/* The ST Micro variants has a special bit to enable SDIO */
 	if (variant->sdio && host->mmc->card)
-		if (mmc_card_sdio(host->mmc->card))
+		if (mmc_card_sdio(host->mmc->card)) {
+			/*
+			 * The ST Micro variants has a special bit
+			 * to enable SDIO.
+			 */
 			datactrl |= MCI_ST_DPSM_SDIOEN;
 
+			/*
+			 * The ST Micro variant for SDIO transfer sizes
+			 * less then or equal to 8 bytes needs to have clock
+			 * H/W flow control disabled. Since flow control is
+			 * not really needed for anything that fits in the
+			 * FIFO, we can disable it for any write smaller
+			 * than the FIFO size.
+			 */
+			if ((host->size <= variant->fifosize) &&
+			    (data->flags & MMC_DATA_WRITE))
+				writel(readl(host->base + MMCICLOCK) &
+				       ~variant->clkreg_enable,
+				       host->base + MMCICLOCK);
+			else
+				writel(readl(host->base + MMCICLOCK) |
+				       variant->clkreg_enable,
+				       host->base + MMCICLOCK);
+		}
+
 	/*
 	 * Attempt to use DMA operation mode, if this
 	 * should fail, fall back to PIO mode
@@ -824,23 +847,6 @@ static int mmci_pio_write(struct mmci_host *host, char *buffer, unsigned int rem
 		count = min(remain, maxcnt);
 
 		/*
-		 * The ST Micro variant for SDIO transfer sizes
-		 * less then 8 bytes should have clock H/W flow
-		 * control disabled.
-		 */
-		if (variant->sdio &&
-		    mmc_card_sdio(host->mmc->card)) {
-			if (count < 8)
-				writel(readl(host->base + MMCICLOCK) &
-					~variant->clkreg_enable,
-					host->base + MMCICLOCK);
-			else
-				writel(readl(host->base + MMCICLOCK) |
-					variant->clkreg_enable,
-					host->base + MMCICLOCK);
-		}
-
-		/*
 		 * SDIO especially may want to send something that is
 		 * not divisible by 4 (as opposed to card sectors
 		 * etc), and the FIFO only accept full 32-bit writes.
-- 
1.7.5.4

