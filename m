From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 2/2] mmc: mmci: Switching off HWFC for SDIO depends on MCLK
Date: Wed, 10 Oct 2012 17:43:45 +0200
Message-ID: <1349883825-22517-2-git-send-email-ulf.hansson@stericsson.com>
References: <1349883825-22517-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:50733 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752302Ab2JJPo0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Oct 2012 11:44:26 -0400
In-Reply-To: <1349883825-22517-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>

For writes, HWFC shall be switched off when transfer size <= 8
bytes and when MCLK rate is above 50 MHz. For 50MHz and below
it shall be switched off when transfer size < 8 bytes.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 877079e..cd0fbee 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -664,12 +664,14 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 			datactrl |= MCI_ST_DPSM_SDIOEN;
 
 			/*
-			 * The ST Micro variant for SDIO transfer sizes
-			 * less then 8 bytes should have clock H/W flow
-			 * control disabled.
+			 * The ST Micro variant for SDIO small write transfers
+			 * needs to have clock H/W flow control disabled,
+			 * otherwise the transfer will not start. The threshold
+			 * depends on the rate of MCLK.
 			 */
-			if ((host->size < 8) &&
-			    (data->flags & MMC_DATA_WRITE))
+			if (data->flags & MMC_DATA_WRITE &&
+			    (host->size < 8 ||
+			     (host->size <= 8 && host->mclk > 50000000)))
 				clk = host->clk_reg & ~variant->clkreg_enable;
 			else
 				clk = host->clk_reg | variant->clkreg_enable;
-- 
1.7.10

