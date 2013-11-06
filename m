From: Alexey Neyman <stilor@att.net>
Subject: [PATCH] mmc: sdhci: Avoid needless loop while handling SDIO interrupts in sdhci_irq()
Date: Tue,  5 Nov 2013 19:40:36 -0800
Message-ID: <1383709236-26692-1-git-send-email-stilor@att.net>
References: <CAA+hA=StthxfMWjQ+0fhdRiPuDDVWUGrrW9E71Q+E3RoF_QdHw@mail.gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from asmtp.lnxw.com ([207.21.185.2]:48643 "EHLO asmtp.lnxw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752916Ab3KFDjK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 5 Nov 2013 22:39:10 -0500
In-Reply-To: <CAA+hA=StthxfMWjQ+0fhdRiPuDDVWUGrrW9E71Q+E3RoF_QdHw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>, Chris Ball <cjb@laptop.org>, "open list:SECURE DIGITAL HO..." <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: Alexey Neyman <stilor@att.net>

Ignore Card Interrupt bit in the interrupt status if we already know that
mmc_signal_sdio_irq() is going to be called at the end of sdhci_irq(). This
avoids a needless loop in sdhci_irq() repeatedly reading interrupt status
and doing nothing.

Signed-off-by: Alexey Neyman <stilor@att.net>
Acked-by: Dong Aisheng <b29396@freescale.com>
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

