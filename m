From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: mmci: Gate the clock when freq is 0
Date: Wed, 12 Dec 2012 16:50:21 +0100
Message-ID: <1355327421-20187-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:44265 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754361Ab2LLPuj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Dec 2012 10:50:39 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>

From: Johan Rudholm <johan.rudholm@stericsson.com>

In the ST Micro variant, the MMCI_CLOCK register should not be used to
gate the clock. Use MMCI_POWER to do this.

Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index edc3e9b..bf07823 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1147,6 +1147,15 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 	}
 
+	/*
+	 * If clock = 0 and the block needs a certain value in the clreg
+	 * to function, we need to gate the clock by removing MCI_PWR_ON.
+	 * This is a special case for ST Micro variants, since the power
+	 * register in the ARM legacy case is used for powering the cards.
+	 */
+	if (!ios->clock && variant->clkreg)
+		pwr &= ~MCI_PWR_ON;
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	mmci_set_clkreg(host, ios->clock);
-- 
1.7.10

