From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 5/7] mmc: sdio: Don't re-initialize powered-on removable SDIO cards at resume
Date: Tue, 18 Jun 2019 17:34:46 +0200
Message-ID: <20190618153448.27145-6-ulf.hansson@linaro.org>
References: <20190618153448.27145-1-ulf.hansson@linaro.org>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20190618153448.27145-1-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Arend Van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

It looks like the original idea behind always doing a re-initialization of
a removable SDIO card during system resume in mmc_sdio_resume(), is to try
to play safe to detect whether the card has been removed.

However, this seems like a really a bad idea as it will most likely screw
things up, especially when the card is expected to remain powered on during
system suspend by the SDIO func driver.

Let's fix this, simply by trusting that the detect work checks if the card
is alive and inserted, which is being scheduled at the PM_POST_SUSPEND
notification anyway.

Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/core/sdio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index a9bfcae8db5b..945416c53b56 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -982,7 +982,11 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	/* Basic card reinitialization. */
 	mmc_claim_host(host);
 
-	/* Restore power if needed */
+	/*
+	 * Restore power and reinitialize the card when needed. Note that a
+	 * removable card is checked from a detect work later on in the resume
+	 * process.
+	 */
 	if (!mmc_card_keep_power(host)) {
 		mmc_power_up(host, host->card->ocr);
 		/*
@@ -996,12 +1000,8 @@ static int mmc_sdio_resume(struct mmc_host *host)
 			pm_runtime_set_active(&host->card->dev);
 			pm_runtime_enable(&host->card->dev);
 		}
-	}
