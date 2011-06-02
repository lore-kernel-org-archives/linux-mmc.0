From: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] libertas_sdio: handle spurious interrupts
Date: Fri,  3 Jun 2011 00:13:26 +0100 (BST)
Message-ID: <20110602231327.116A79D401C@zog.reactivated.net>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org
Cc: dcbw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, libertas-dev-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Commit 06e8935febe687e2a561707d4c7ca4245d261dbe adds an IRQ handling
optimization for single-function SDIO cards like this one, but at the
same time exposes a small hardware bug.

During hardware init, an interrupt is generated with (apparently) no
source. Previously, mmc threw this interrupt away, but now (due to the
optimization), the mmc layer passes this onto libertas, before it is ready
(and before it has enabled interrupts), causing a crash.

Work around this hardware bug by registering the IRQ handler later and
making it capable of handling interrupts with no cause. The change that
makes the IRQ handler registration happen later actually eliminates
the spurious interrupt as well.

Signed-off-by: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
---
 drivers/net/wireless/libertas/if_sdio.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/libertas/if_sdio.c b/drivers/net/wireless/libertas/if_sdio.c
index a7b5cb0..224e985 100644
--- a/drivers/net/wireless/libertas/if_sdio.c
+++ b/drivers/net/wireless/libertas/if_sdio.c
@@ -907,7 +907,7 @@ static void if_sdio_interrupt(struct sdio_func *func)
 	card = sdio_get_drvdata(func);
 
 	cause = sdio_readb(card->func, IF_SDIO_H_INT_STATUS, &ret);
-	if (ret)
+	if (ret || !cause)
 		goto out;
 
 	lbs_deb_sdio("interrupt: 0x%X\n", (unsigned)cause);
@@ -1008,10 +1008,6 @@ static int if_sdio_probe(struct sdio_func *func,
 	if (ret)
 		goto release;
 
-	ret = sdio_claim_irq(func, if_sdio_interrupt);
-	if (ret)
-		goto disable;
-
 	/* For 1-bit transfers to the 8686 model, we need to enable the
 	 * interrupt flag in the CCCR register. Set the MMC_QUIRK_LENIENT_FN0
 	 * bit to allow access to non-vendor registers. */
@@ -1083,6 +1079,21 @@ static int if_sdio_probe(struct sdio_func *func,
 		card->rx_unit = 0;
 
 	/*
+	 * Set up the interrupt handler late.
+	 *
+	 * If we set it up earlier, the (buggy) hardware generates a spurious
+	 * interrupt, even before the interrupt has been enabled, with
+	 * CCCR_INTx = 0.
+	 *
+	 * We register the interrupt handler late so that we can handle any
+	 * spurious interrupts, and also to avoid generation of that known
+	 * spurious interrupt in the first place.
+	 */
+	ret = sdio_claim_irq(func, if_sdio_interrupt);
+	if (ret)
+		goto disable;
+
+	/*
 	 * Enable interrupts now that everything is set up
 	 */
 	sdio_writeb(func, 0x0f, IF_SDIO_H_INT_MASK, &ret);
-- 
1.7.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
