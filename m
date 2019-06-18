From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 6/7] mmc: sdio: Drop unused in-parameter to mmc_sdio_reinit_card()
Date: Tue, 18 Jun 2019 17:34:47 +0200
Message-ID: <20190618153448.27145-7-ulf.hansson@linaro.org>
References: <20190618153448.27145-1-ulf.hansson@linaro.org>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20190618153448.27145-1-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Arend Van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The "powered_resume" in-parameter to mmc_sdio_reinit_card() has now become
redundant as all callers set it to 0. Therefore let's just drop it.

Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/core/sdio.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 945416c53b56..0bf603670f61 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -816,7 +816,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	return err;
 }
 
-static int mmc_sdio_reinit_card(struct mmc_host *host, bool powered_resume)
+static int mmc_sdio_reinit_card(struct mmc_host *host)
 {
 	int ret;
 
@@ -845,8 +845,7 @@ static int mmc_sdio_reinit_card(struct mmc_host *host, bool powered_resume)
 	if (ret)
 		return ret;
 
-	return mmc_sdio_init_card(host, host->card->ocr, host->card,
-				  powered_resume);
+	return mmc_sdio_init_card(host, host->card->ocr, host->card, 0);
 }
 
 /*
@@ -1000,7 +999,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
 			pm_runtime_set_active(&host->card->dev);
 			pm_runtime_enable(&host->card->dev);
 		}
-		err = mmc_sdio_reinit_card(host, 0);
+		err = mmc_sdio_reinit_card(host);
 	} else if (mmc_card_wake_sdio_irq(host)) {
 		/* We may have switched to 1-bit mode during suspend */
 		err = sdio_enable_4bit_bus(host->card);
@@ -1026,11 +1025,6 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	return err;
 }
 
-static int mmc_sdio_power_restore(struct mmc_host *host)
-{
-	return mmc_sdio_reinit_card(host, 0);
-}
-
 static int mmc_sdio_runtime_suspend(struct mmc_host *host)
 {
 	/* No references to the card, cut the power to it. */
@@ -1048,7 +1042,7 @@ static int mmc_sdio_runtime_resume(struct mmc_host *host)
 	/* Restore power and re-initialize. */
 	mmc_claim_host(host);
 	mmc_power_up(host, host->card->ocr);
-	ret = mmc_sdio_power_restore(host);
+	ret = mmc_sdio_reinit_card(host);
 	mmc_release_host(host);
 
 	return ret;
@@ -1057,7 +1051,7 @@ static int mmc_sdio_runtime_resume(struct mmc_host *host)
 static int mmc_sdio_hw_reset(struct mmc_host *host)
 {
 	mmc_power_cycle(host, host->card->ocr);
-	return mmc_sdio_power_restore(host);
+	return mmc_sdio_reinit_card(host);
 }
 
 static int mmc_sdio_sw_reset(struct mmc_host *host)
@@ -1069,7 +1063,7 @@ static int mmc_sdio_sw_reset(struct mmc_host *host)
 	mmc_set_initial_state(host);
 	mmc_set_initial_signal_voltage(host);
 
-	return mmc_sdio_reinit_card(host, 0);
+	return mmc_sdio_reinit_card(host);
 }
 
 static const struct mmc_bus_ops mmc_sdio_ops = {
-- 
2.17.1
