From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 1/3] MMCI Break out clock divider setup
Date: Wed,  9 Sep 2009 22:55:00 +0200
Message-ID: <1252529700-7429-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:56689 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752924AbZIIUzX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 Sep 2009 16:55:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@stericsson.com>

This breaks out the clock divider set-up code from the
mmci_set_ios() code and surrounds the two register
writes with a host lock so we don't get collisions if
(in future code) two code paths want to change the
clock divider at the same time as can be the case if
we get something like pre/post- clock frequency change
notifications soonish.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |   49 +++++++++++++++++++++++++++++++---------------
 1 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index a923ee2..083f9b8 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -38,6 +38,33 @@
 
 static unsigned int fmax = 515633;
 
+/*
+ * This must be called with host->lock held
+ */
+static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
+{
+	u32 clk = 0;
+
+	if (desired) {
+		if (desired >= host->mclk) {
+			clk = MCI_CLK_BYPASS;
+			host->cclk = host->mclk;
+		} else {
+			clk = host->mclk / (2 * desired) - 1;
+			if (clk >= 256)
+				clk = 255;
+			host->cclk = host->mclk / (2 * (clk + 1));
+		}
+		if (host->hw_designer == 0x80)
+			clk |= MCI_FCEN; /* Bug fix in ST IP block */
+		clk |= MCI_CLK_ENABLE;
+		/* This hasn't proven to be worthwhile */
+		/* clk |= MCI_CLK_PWRSAVE; */
+	}
+
+	writel(clk, host->base + MMCICLOCK);
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
@@ -420,21 +447,7 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct mmci_host *host = mmc_priv(mmc);
 	u32 clk = 0, pwr = 0;
-
-	if (ios->clock) {
-		if (ios->clock >= host->mclk) {
-			clk = MCI_CLK_BYPASS;
-			host->cclk = host->mclk;
-		} else {
-			clk = host->mclk / (2 * ios->clock) - 1;
-			if (clk >= 256)
-				clk = 255;
-			host->cclk = host->mclk / (2 * (clk + 1));
-		}
-		if (host->hw_designer == 0x80)
-			clk |= MCI_FCEN; /* Bug fix in ST IP block */
-		clk |= MCI_CLK_ENABLE;
-	}
+	unsigned long flags;
 
 	if (host->plat->translate_vdd)
 		pwr |= host->plat->translate_vdd(mmc_dev(mmc), ios->vdd);
@@ -465,12 +478,16 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 	}
 
-	writel(clk, host->base + MMCICLOCK);
+	spin_lock_irqsave(&host->lock, flags);
+
+	mmci_set_clkreg(host, ios->clock);
 
 	if (host->pwr != pwr) {
 		host->pwr = pwr;
 		writel(pwr, host->base + MMCIPOWER);
 	}
+
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static int mmci_get_ro(struct mmc_host *mmc)
-- 
1.6.2.1

