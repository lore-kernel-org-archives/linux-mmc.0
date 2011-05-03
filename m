From: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] sdio: optimized SDIO IRQ handling for single function
Date: Tue,  3 May 2011 22:04:47 +0200
Message-ID: <1304453087-7365-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Cc: Stefan Nilsson XK <stefan.xk.nilsson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Stefan Nilsson XK <stefan.xk.nilsson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

If there is only 1 function registered, and IRQ:s are supported and
currently enabled, call the callback handler directly
without checking the CCCR registers.

Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/core/sdio_irq.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index b300161..25291bf 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -32,6 +32,20 @@ static int process_sdio_pending_irqs(struct mmc_card *card)
 	int i, ret, count;
 	unsigned char pending;
 
+	/*
+	 * If there is only 1 function registered
+	 * call irq directly without checking the CCCR registers.
+	 */
+	if ((card->host->caps & MMC_CAP_SDIO_IRQ) &&
+	    card->host->sdio_irqs && (card->sdio_funcs == 1))
+		for (i = 0; i < SDIO_MAX_FUNCS; i++) {
+			struct sdio_func *func = card->sdio_func[i];
+			if (func && func->irq_handler) {
+				func->irq_handler(func);
+				return 1;
+			}
+		}
+
 	ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0, &pending);
 	if (ret) {
 		printk(KERN_DEBUG "%s: error %d reading SDIO_CCCR_INTx\n",
-- 
1.7.4.1
