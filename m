From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 7/7] mmc: sdio: Drop unused in-parameter from mmc_sdio_init_card()
Date: Tue, 18 Jun 2019 17:34:48 +0200
Message-ID: <20190618153448.27145-8-ulf.hansson@linaro.org>
References: <20190618153448.27145-1-ulf.hansson@linaro.org>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20190618153448.27145-1-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Arend Van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The "powered_resume" in-parameter to mmc_sdio_init_card() has now become
redundant as all callers set it to 0. Therefore let's just drop it.

Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/core/sdio.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 0bf603670f61..8dd8fc32ecca 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -559,7 +559,7 @@ static void mmc_sdio_resend_if_cond(struct mmc_host *host,
  * we're trying to reinitialise.
  */
 static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
-			      struct mmc_card *oldcard, int powered_resume)
+			      struct mmc_card *oldcard)
 {
 	struct mmc_card *card;
 	int err;
@@ -582,11 +582,9 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	/*
 	 * Inform the card of the voltage
 	 */
-	if (!powered_resume) {
-		err = mmc_send_io_op_cond(host, ocr, &rocr);
-		if (err)
-			goto err;
-	}
+	err = mmc_send_io_op_cond(host, ocr, &rocr);
+	if (err)
+		goto err;
 
 	/*
 	 * For SPI, enable CRC as appropriate.
@@ -645,7 +643,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	 * try to init uhs card. sdio_read_cccr will take over this task
 	 * to make sure which speed mode should work.
 	 */
-	if (!powered_resume && (rocr & ocr & R4_18V_PRESENT)) {
+	if (rocr & ocr & R4_18V_PRESENT) {
 		err = mmc_set_uhs_voltage(host, ocr_card);
 		if (err == -EAGAIN) {
 			mmc_sdio_resend_if_cond(host, card);
@@ -659,7 +657,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	/*
 	 * For native busses:  set card RCA and quit open drain mode.
 	 */
-	if (!powered_resume && !mmc_host_is_spi(host)) {
+	if (!mmc_host_is_spi(host)) {
 		err = mmc_send_relative_addr(host, &card->rca);
 		if (err)
 			goto remove;
@@ -687,7 +685,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	/*
 	 * Select card, as all following commands rely on that.
 	 */
-	if (!powered_resume && !mmc_host_is_spi(host)) {
+	if (!mmc_host_is_spi(host)) {
 		err = mmc_select_card(card);
 		if (err)
 			goto remove;
@@ -845,7 +843,7 @@ static int mmc_sdio_reinit_card(struct mmc_host *host)
 	if (ret)
 		return ret;
 
-	return mmc_sdio_init_card(host, host->card->ocr, host->card, 0);
+	return mmc_sdio_init_card(host, host->card->ocr, host->card);
 }
 
 /*
@@ -1113,7 +1111,7 @@ int mmc_attach_sdio(struct mmc_host *host)
 	/*
 	 * Detect and init the card.
 	 */
-	err = mmc_sdio_init_card(host, rocr, NULL, 0);
+	err = mmc_sdio_init_card(host, rocr, NULL);
 	if (err)
 		goto err;
 
-- 
2.17.1
