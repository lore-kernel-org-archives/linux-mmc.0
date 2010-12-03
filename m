From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH] mmci: corrected calculation of clock div for ux500 v2
Date: Fri, 3 Dec 2010 09:46:27 +0100
Message-ID: <1291365987-17882-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:53590 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751777Ab0LCIqj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Dec 2010 03:46:39 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

From: Ulf Hansson <ulf.hansson@stericsson.com>

The Ux500 variant of this block has a different divider.
The value used right now is too big and which means a loss
in performance. This fix corrects it. Also expand the math
comments a bit so it's clear what's happening. Further
the Ux500 variant does not like if we use the BYPASS bit,
instead we are supposed to set the clock divider to zero.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 7567872..9bd3a18 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -51,6 +51,7 @@ static unsigned int fmax = 515633;
  * @broken_blockend_dma: the MCI_DATABLOCKEND is broken on the hardware when
  *		using DMA.
  * @sdio: variant supports SDIO
+ * @st_clkdiv: true if using a ST-specific clock divider algorithm
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -61,6 +62,7 @@ struct variant_data {
 	bool			broken_blockend;
 	bool			broken_blockend_dma;
 	bool			sdio;
+	bool			st_clkdiv;
 };
 
 static struct variant_data variant_arm = {
@@ -86,7 +88,9 @@ static struct variant_data variant_ux500 = {
 	.datalength_bits	= 24,
 	.broken_blockend	= true,
 	.sdio			= true,
+	.st_clkdiv		= true,
 };
+
 /*
  * This must be called with host->lock held
  */
@@ -97,9 +101,30 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 
 	if (desired) {
 		if (desired >= host->mclk) {
-			clk = MCI_CLK_BYPASS;
+			/*
+			 * The ST clock divider does not like the bypass bit,
+			 * even though it's available. Instead the datasheet
+			 * recommends setting the divider to zero.
+			 */
+			if (!variant->st_clkdiv)
+				clk = MCI_CLK_BYPASS;
 			host->cclk = host->mclk;
+		} else if (variant->st_clkdiv) {
+			/*
+			 * DB8500 TRM says f = mclk / (clkdiv + 2)
+			 * => clkdiv = (mclk / f) - 2
+			 * Round the divider up so we don't exceed the max
+			 * frequency
+			 */
+			clk = DIV_ROUND_UP(host->mclk, desired) - 2;
+			if (clk >= 256)
+				clk = 255;
+			host->cclk = host->mclk / (clk + 2);
 		} else {
+			/*
+			 * PL180 TRM says f = mclk / (2 * (clkdiv + 1))
+			 * => clkdiv = mclk / (2 * f) - 1
+			 */
 			clk = host->mclk / (2 * desired) - 1;
 			if (clk >= 256)
 				clk = 255;
-- 
1.7.3.2

