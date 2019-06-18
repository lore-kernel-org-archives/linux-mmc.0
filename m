From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/7] mmc: sdio: Turn sdio_run_irqs() into static
Date: Tue, 18 Jun 2019 17:34:42 +0200
Message-ID: <20190618153448.27145-2-ulf.hansson@linaro.org>
References: <20190618153448.27145-1-ulf.hansson@linaro.org>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20190618153448.27145-1-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Arend Van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

All external users of sdio_run_irqs() have converted into using the
preferred sdio_signal_irq() interface, thus not calling the function
directly any more. Avoid further new users of it, by turning it into
static.

Suggested-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/core/sdio_irq.c | 3 +--
 include/linux/mmc/host.h    | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 9f54a259a1b3..0bcc5e83bd1a 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -92,7 +92,7 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 	return ret;
 }
 
-void sdio_run_irqs(struct mmc_host *host)
+static void sdio_run_irqs(struct mmc_host *host)
 {
 	mmc_claim_host(host);
 	if (host->sdio_irqs) {
@@ -103,7 +103,6 @@ void sdio_run_irqs(struct mmc_host *host)
 	}
 	mmc_release_host(host);
 }
-EXPORT_SYMBOL_GPL(sdio_run_irqs);
 
 void sdio_irq_work(struct work_struct *work)
 {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ecb7972e2423..a9b12322c775 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -504,7 +504,6 @@ static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 		wake_up_process(host->sdio_irq_thread);
 }
 
-void sdio_run_irqs(struct mmc_host *host);
 void sdio_signal_irq(struct mmc_host *host);
 
 #ifdef CONFIG_REGULATOR
-- 
2.17.1
