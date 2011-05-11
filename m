From: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v4] sdio: optimized SDIO IRQ handling for single irq
Date: Wed, 11 May 2011 09:53:36 +0200
Message-ID: <1305100416-5395-2-git-send-email-per.forlin@linaro.org>
References: <1305100416-5395-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1305100416-5395-1-git-send-email-per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Stefan Nilsson XK <stefan.xk.nilsson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Stefan Nilsson XK <stefan.xk.nilsson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

If there is only 1 function interrupt registered it is possible to
improve performance by directly calling the irq handler
and avoiding the overhead of reading the CCCR registers.

Signed-off-by: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Ulf Hansson <ulf.hansson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Reviewed-by: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/core/sdio_irq.c |   33 ++++++++++++++++++++++++++++++++-
 include/linux/mmc/card.h    |    1 +
 2 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index b300161..03ead02 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -31,6 +31,17 @@ static int process_sdio_pending_irqs(struct mmc_card *card)
 {
 	int i, ret, count;
 	unsigned char pending;
+	struct sdio_func *func;
+
+	/*
+	 * Optimization, if there is only 1 function interrupt registered
+	 * call irq handler directly
+	 */
+	func = card->sdio_single_irq;
+	if (func) {
+		func->irq_handler(func);
+		return 1;
+	}
 
 	ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0, &pending);
 	if (ret) {
@@ -42,7 +53,7 @@ static int process_sdio_pending_irqs(struct mmc_card *card)
 	count = 0;
 	for (i = 1; i <= 7; i++) {
 		if (pending & (1 << i)) {
-			struct sdio_func *func = card->sdio_func[i - 1];
+			func = card->sdio_func[i - 1];
 			if (!func) {
 				printk(KERN_WARNING "%s: pending IRQ for "
 					"non-existent function\n",
@@ -186,6 +197,24 @@ static int sdio_card_irq_put(struct mmc_card *card)
 	return 0;
 }
 
+/* If there is only 1 function registered set sdio_single_irq */
+static void sdio_single_irq_set(struct mmc_card *card)
+{
+	struct sdio_func *func;
+	int i;
+
+	card->sdio_single_irq = NULL;
+	if ((card->host->caps & MMC_CAP_SDIO_IRQ) &&
+	    card->host->sdio_irqs == 1)
+		for (i = 0; i < card->sdio_funcs; i++) {
+		       func = card->sdio_func[i];
+		       if (func && func->irq_handler) {
+			       card->sdio_single_irq = func;
+			       break;
+		       }
+	       }
+}
+
 /**
  *	sdio_claim_irq - claim the IRQ for a SDIO function
  *	@func: SDIO function
@@ -227,6 +256,7 @@ int sdio_claim_irq(struct sdio_func *func, sdio_irq_handler_t *handler)
 	ret = sdio_card_irq_get(func->card);
 	if (ret)
 		func->irq_handler = NULL;
+	sdio_single_irq_set(func->card);
 
 	return ret;
 }
@@ -251,6 +281,7 @@ int sdio_release_irq(struct sdio_func *func)
 	if (func->irq_handler) {
 		func->irq_handler = NULL;
 		sdio_card_irq_put(func->card);
+		sdio_single_irq_set(func->card);
 	}
 
 	ret = mmc_io_rw_direct(func->card, 0, 0, SDIO_CCCR_IENx, 0, &reg);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index d8dffc9..4910dec 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -191,6 +191,7 @@ struct mmc_card {
 	struct sdio_cccr	cccr;		/* common card info */
 	struct sdio_cis		cis;		/* common tuple info */
 	struct sdio_func	*sdio_func[SDIO_MAX_FUNCS]; /* SDIO functions (devices) */
+	struct sdio_func	*sdio_single_irq; /* SDIO function when only one IRQ active */
 	unsigned		num_info;	/* number of info strings */
 	const char		**info;		/* info strings */
 	struct sdio_func_tuple	*tuples;	/* unknown common tuples */
-- 
1.7.4.1
