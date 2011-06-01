From: Per Forlin <per.forlin-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH v2 1/2] sdio: add quirk to handle pending IRQ in case of none
	CCCR_INTx bits
Date: Wed, 1 Jun 2011 10:48:32 +0200
Message-ID: <1306918113-23872-2-git-send-email-per.forlin@stericsson.com>
References: <1306918113-23872-1-git-send-email-per.forlin@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1306918113-23872-1-git-send-email-per.forlin-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Linus
List-Id: linux-mmc@vger.kernel.org

From: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Add quirk MMC_QUIRK_SDIO_IRQ_CCCR_INTX_0 to handle SDIO device that may
have pending IRQ when none bits are set in CCCR_INTx.

This IRQ issue was identified in the libertas sdio driver where the
SDIO device seems to raise an interrupt even if there were none function
bits in CCCR_INTx set. SDIO single irq feature will call irq handler directly
in case of only one interrupt registered. It will not check the CCCR_INTx
register and miss if the register is 0 and call the irq handler anyway.
This IRQ issue is not defined by the SDIO spec.
Use this quirk to work around this SDIO IRQ issue for a specific device.

Signed-off-by: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/core/sdio_irq.c |    4 ++--
 include/linux/mmc/card.h    |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 03ead02..df1e946 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -204,7 +204,8 @@ static void sdio_single_irq_set(struct mmc_card *card)
 	int i;
 
 	card->sdio_single_irq = NULL;
-	if ((card->host->caps & MMC_CAP_SDIO_IRQ) &&
+	if (!(card->quirks & MMC_QUIRK_SDIO_IRQ_CCCR_INTX_0) &&
+	    (card->host->caps & MMC_CAP_SDIO_IRQ) &&
 	    card->host->sdio_irqs == 1)
 		for (i = 0; i < card->sdio_funcs; i++) {
 		       func = card->sdio_func[i];
@@ -301,4 +302,3 @@ int sdio_release_irq(struct sdio_func *func)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sdio_release_irq);
-
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 7b4fd7b..852021c 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -175,6 +175,7 @@ struct mmc_card {
 #define MMC_QUIRK_DISABLE_CD	(1<<5)		/* disconnect CD/DAT[3] resistor */
 #define MMC_QUIRK_INAND_CMD38	(1<<6)		/* iNAND devices have broken CMD38 */
 #define MMC_QUIRK_BLK_NO_CMD23	(1<<7)		/* Avoid CMD23 for regular multiblock */
+#define MMC_QUIRK_SDIO_IRQ_CCCR_INTX_0 (1<<7)	/* SDIO card has IRQ even if CCCR_INTx is 0 */
 
 	unsigned int		erase_size;	/* erase size in sectors */
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
-- 
1.7.4.1
