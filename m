From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/7] mmc: sdio: Drop powered-on re-init at runtime resume and HW reset
Date: Tue, 18 Jun 2019 17:34:45 +0200
Message-ID: <20190618153448.27145-5-ulf.hansson@linaro.org>
References: <20190618153448.27145-1-ulf.hansson@linaro.org>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20190618153448.27145-1-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Arend Van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

To use the so called powered-on re-initialization of an SDIO card, the
power to the card must obviously have stayed on. If not, the initialization
will simply fail.

In the runtime suspend case, the card is always powered off. Hence, let's
drop the support for powered-on re-initialization during runtime resume, as
it doesn't make sense.

Moreover, during a HW reset, the point is to cut the power to the card and
then do fresh re-initialization. Therefore drop the support for powered-on
re-initialization during HW reset.

Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/core/sdio.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 29f86c1e9923..a9bfcae8db5b 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1028,13 +1028,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
 
 static int mmc_sdio_power_restore(struct mmc_host *host)
 {
-	int ret;
-
-	ret = mmc_sdio_reinit_card(host, mmc_card_keep_power(host));
-	if (!ret && host->sdio_irqs)
-		mmc_signal_sdio_irq(host);
