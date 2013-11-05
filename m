From: Alexey Neyman <stilor@att.net>
Subject: [PATCH] Avoid needless loop in sdhci_irq()
Date: Tue,  5 Nov 2013 11:58:46 -0800
Message-ID: <1383681526-5316-1-git-send-email-stilor@att.net>
References: <CAA+hA=R=hZfr6Kx_5X8PQ1ck+1wD3C6LOiXyKNMN7yrqdA0YqA@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAA+hA=R=hZfr6Kx_5X8PQ1ck+1wD3C6LOiXyKNMN7yrqdA0YqA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, "open list:SECURE DIGITAL HO..." <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Alexey Neyman <stilor@att.net>
List-Id: linux-mmc@vger.kernel.org

Ignore Card Interrupt bit in the interrupt status if we already know that
mmc_signal_sdio_irq() is going to be called at the end of sdhci_irq(). This
avoids a needless loop in sdhci_irq() repeatedly reading interrupt status
and doing nothing.

Signed-off-by: Alexey Neyman <stilor@att.net>
---
 drivers/mmc/host/sdhci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7a7fb4f..a83cd1b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2491,6 +2491,14 @@ again:
 	result = IRQ_HANDLED;
 
 	intmask = sdhci_readl(host, SDHCI_INT_STATUS);
+
+	/*
+	 * If we know we'll call the driver to signal SDIO IRQ, disregard
+	 * further indications of Card Interrupt in the status to avoid a
+	 * needless loop.
+	 */
+	if (cardint)
+		intmask &= ~SDHCI_INT_CARD_INT;
 	if (intmask && --max_loops)
 		goto again;
 out:
-- 
1.8.4.1
