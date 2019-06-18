From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/7] mmc: sdio: Move comment about re-initialization to mmc_sdio_reinit_card()
Date: Tue, 18 Jun 2019 17:34:44 +0200
Message-ID: <20190618153448.27145-4-ulf.hansson@linaro.org>
References: <20190618153448.27145-1-ulf.hansson@linaro.org>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20190618153448.27145-1-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Arend Van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The comment in mmc_sdio_power_restore() belongs in mmc_sdio_reinit_card(),
which was created during a previous commit that re-factored some code. Fix
this by moving the comment into mmc_sdio_reinit_card().

Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/core/sdio.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index b3303b7d9956..29f86c1e9923 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -820,6 +820,23 @@ static int mmc_sdio_reinit_card(struct mmc_host *host, bool powered_resume)
 {
 	int ret;
 
+	/*
+	 * Reset the card by performing the same steps that are taken by
+	 * mmc_rescan_try_freq() and mmc_attach_sdio() during a "normal" probe.
+	 *
+	 * sdio_reset() is technically not needed. Having just powered up the
+	 * hardware, it should already be in reset state. However, some
+	 * platforms (such as SD8686 on OLPC) do not instantly cut power,
+	 * meaning that a reset is required when restoring power soon after
+	 * powering off. It is harmless in other cases.
+	 *
+	 * The CMD5 reset (mmc_send_io_op_cond()), according to the SDIO spec,
+	 * is not necessary for non-removable cards. However, it is required
+	 * for OLPC SD8686 (which expects a [CMD5,5,3,7] init sequence), and
+	 * harmless in other situations.
+	 *
+	 */
+
 	sdio_reset(host);
 	mmc_go_idle(host);
 	mmc_send_if_cond(host, host->card->ocr);
@@ -1013,23 +1030,6 @@ static int mmc_sdio_power_restore(struct mmc_host *host)
 {
 	int ret;
 
-	/*
-	 * Reset the card by performing the same steps that are taken by
-	 * mmc_rescan_try_freq() and mmc_attach_sdio() during a "normal" probe.
-	 *
-	 * sdio_reset() is technically not needed. Having just powered up the
-	 * hardware, it should already be in reset state. However, some
-	 * platforms (such as SD8686 on OLPC) do not instantly cut power,
-	 * meaning that a reset is required when restoring power soon after
-	 * powering off. It is harmless in other cases.
-	 *
-	 * The CMD5 reset (mmc_send_io_op_cond()), according to the SDIO spec,
-	 * is not necessary for non-removable cards. However, it is required
-	 * for OLPC SD8686 (which expects a [CMD5,5,3,7] init sequence), and
-	 * harmless in other situations.
-	 *
-	 */
