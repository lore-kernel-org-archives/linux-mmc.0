From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 6/8] mmc: mmci: Fix incorrect handling of HW flow control for SDIO
Date: Tue, 17 Jan 2012 15:34:25 +0100
Message-ID: <1326810867-5346-7-git-send-email-ulf.hansson@stericsson.com>
References: <1326810867-5346-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:41099 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754549Ab2AQOfI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jan 2012 09:35:08 -0500
In-Reply-To: <1326810867-5346-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

For data writes smaller than 8 bytes (only SDIO case), HW flow
control was disabled but never re-enabled again. This meant that
a following large read request could randomly give buffer overrun
errors.

This patch is based upon a patch from Stefan Nilsson.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Signed-off-by: Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |   38 ++++++++++++++++++++------------------
 1 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 3defe69..e7b4500 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -638,10 +638,28 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	if (data->flags & MMC_DATA_READ)
 		datactrl |= MCI_DPSM_DIRECTION;
 
-	/* The ST Micro variants has a special bit to enable SDIO */
 	if (variant->sdio && host->mmc->card)
-		if (mmc_card_sdio(host->mmc->card))
+		if (mmc_card_sdio(host->mmc->card)) {
+
+			/*
+			 * The ST Micro variant for SDIO write transfer sizes
+			 * less then 8 bytes must have clock H/W flow control
+			 * disabled.
+			 */
+			u32 clk;
+			if ((host->size < 8) && (data->flags & MMC_DATA_WRITE))
+				clk = host->clk_reg & ~variant->clkreg_enable;
+			else
+				clk = host->clk_reg | variant->clkreg_enable;
+
+			mmci_write_clkreg(host, clk);
+
+			/*
+			 * The ST Micro variants has a special bit
+			 * to enable SDIO.
+			 */
 			datactrl |= MCI_ST_DPSM_SDIOEN;
+		}
 
 	/*
 	 * Attempt to use DMA operation mode, if this
@@ -863,22 +881,6 @@ static int mmci_pio_write(struct mmci_host *host, char *buffer, unsigned int rem
 		count = min(remain, maxcnt);
 
 		/*
-		 * The ST Micro variant for SDIO transfer sizes
-		 * less then 8 bytes should have clock H/W flow
-		 * control disabled.
-		 */
-		if (variant->sdio &&
-		    mmc_card_sdio(host->mmc->card)) {
-			u32 clk;
-			if (count < 8)
-				clk = host->clk_reg & ~variant->clkreg_enable;
-			else
-				clk = host->clk_reg | variant->clkreg_enable;
-
-			mmci_write_clkreg(host, clk);
-		}
-
-		/*
 		 * SDIO especially may want to send something that is
 		 * not divisible by 4 (as opposed to card sectors
 		 * etc), and the FIFO only accept full 32-bit writes.
-- 
1.7.5.4

