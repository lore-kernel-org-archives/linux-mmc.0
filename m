From: Alexey Neyman <stilor@att.net>
Subject: Avoid needless loop in sdhci_irq() for Card Interrupt
Date: Wed, 16 Oct 2013 10:51:12 -0700
Message-ID: <2185940.FhsbmfkKLR@mistral>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2065377.P7sOhBizeh"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart2065377.P7sOhBizeh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

[Patch ping]

Hi all,

I've discovered that the sdhci_irq() function needlessly iterates re-reading 
the interrupt status and doing nothing (until it runs out of max_loops) when 
it handles the "Card Interrupt" status in the interrupt status register.

The reason is that the "Card Interrupt" bit is not cleared until the 
sdhci_irq() calls mmc_signal_sdio_irq(), so if Card Interrupt was asserted, 
re-reading the interrupt status will find this bit set over and over, even if 
no other bits are reported.

The fix: ignore Card Interrupt bits in the interrupt status if we already know 
that mmc_signal_sdio_irq() is going to be called at the end of sdhci_irq().

Signed-off-by: Alexey Neyman <stilor@att.net>
--nextPart2065377.P7sOhBizeh
Content-Disposition: attachment; filename="sdhci.c.diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="utf-8"; name="sdhci.c.diff"

commit 7f23315b344ca51ddf22a78f326f88404fa8c81d
Author: Alexey Neyman <stilor@att.net>
Date:   Wed Oct 9 22:23:54 2013 -0700

    Avoid a loop in sdhci.c.

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

--nextPart2065377.P7sOhBizeh--
