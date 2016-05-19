From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/3] mmc: mmc: do not use CMD13 to get status after speed mode
 switch
Date: Thu, 19 May 2016 16:47:41 +0800
Message-ID: <1463647662-27426-3-git-send-email-chaotian.jing@mediatek.com>
References: <1463647662-27426-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1463647662-27426-1-git-send-email-chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Per JEDEC spec, it is not recommended to use CMD13 to get card status
after speed mode switch. below are two reason about this:
1. CMD13 cannot be guaranteed due to the asynchronous operation.
Therefore it is not recommended to use CMD13 to check busy completion
of the timing change indication.
2. After switch to HS200, CMD13 will get response of 0x800, and even the
busy signal gets de-asserted, the response of CMD13 is aslo 0x800.

Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/mmc/core/mmc.c | 112 ++++++++++++++++++++-----------------------------
 1 file changed, 45 insertions(+), 67 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4dbe3df..97403a6 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -952,6 +952,19 @@ static int mmc_select_bus_width(struct mmc_card *card)
 	return err;
 }
 
+/* Caller must hold re-tuning */
+static int mmc_switch_status(struct mmc_card *card)
+{
+	u32 status;
+	int err;
+
+	err = mmc_send_status(card, &status);
+	if (err)
+		return err;
+
+	return mmc_switch_status_error(card->host, status);
+}
+
 /*
  * Switch to the high-speed mode
  */
@@ -962,9 +975,11 @@ static int mmc_select_hs(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
 			   card->ext_csd.generic_cmd6_time,
-			   true, true, true);
-	if (!err)
+			   true, false, true);
+	if (!err) {
 		mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
+		err = mmc_switch_status(card);
+	}
 
 	return err;
 }
@@ -1040,23 +1055,9 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 	return err;
 }
 
-/* Caller must hold re-tuning */
-static int mmc_switch_status(struct mmc_card *card)
-{
-	u32 status;
-	int err;
-
-	err = mmc_send_status(card, &status);
-	if (err)
-		return err;
-
-	return mmc_switch_status_error(card->host, status);
-}
-
 static int mmc_select_hs400(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
-	bool send_status = true;
 	unsigned int max_dtr;
 	int err = 0;
 	u8 val;
@@ -1068,9 +1069,6 @@ static int mmc_select_hs400(struct mmc_card *card)
 	      host->ios.bus_width == MMC_BUS_WIDTH_8))
 		return 0;
 
-	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
-		send_status = false;
-
 	/* Reduce frequency to HS frequency */
 	max_dtr = card->ext_csd.hs_max_dtr;
 	mmc_set_clock(host, max_dtr);
@@ -1080,7 +1078,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time,
-			   true, send_status, true);
+			   true, false, true);
 	if (err) {
 		pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1090,11 +1088,9 @@ static int mmc_select_hs400(struct mmc_card *card)
 	/* Set host controller to HS timing */
 	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
 
-	if (!send_status) {
-		err = mmc_switch_status(card);
-		if (err)
-			goto out_err;
-	}
+	err = mmc_switch_status(card);
+	if (err)
+		goto out_err;
 
 	/* Switch card to DDR */
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
@@ -1113,7 +1109,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time,
-			   true, send_status, true);
+			   true, false, true);
 	if (err) {
 		pr_err("%s: switch to hs400 failed, err:%d\n",
 			 mmc_hostname(host), err);
@@ -1124,11 +1120,9 @@ static int mmc_select_hs400(struct mmc_card *card)
 	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
 	mmc_set_bus_speed(card);
 
-	if (!send_status) {
-		err = mmc_switch_status(card);
-		if (err)
-			goto out_err;
-	}
+	err = mmc_switch_status(card);
+	if (err)
+		goto out_err;
 
 	return 0;
 
@@ -1146,14 +1140,10 @@ int mmc_hs200_to_hs400(struct mmc_card *card)
 int mmc_hs400_to_hs200(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
-	bool send_status = true;
 	unsigned int max_dtr;
 	int err;
 	u8 val;
 
-	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
-		send_status = false;
-
 	/* Reduce frequency to HS */
 	max_dtr = card->ext_csd.hs_max_dtr;
 	mmc_set_clock(host, max_dtr);
@@ -1162,49 +1152,43 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	val = EXT_CSD_TIMING_HS;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
 			   val, card->ext_csd.generic_cmd6_time,
-			   true, send_status, true);
+			   true, false, true);
 	if (err)
 		goto out_err;
 
 	mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
 
-	if (!send_status) {
-		err = mmc_switch_status(card);
-		if (err)
-			goto out_err;
-	}
+	err = mmc_switch_status(card);
+	if (err)
+		goto out_err;
 
 	/* Switch HS DDR to HS */
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BUS_WIDTH,
 			   EXT_CSD_BUS_WIDTH_8, card->ext_csd.generic_cmd6_time,
-			   true, send_status, true);
+			   true, false, true);
 	if (err)
 		goto out_err;
 
 	mmc_set_timing(host, MMC_TIMING_MMC_HS);
 
-	if (!send_status) {
-		err = mmc_switch_status(card);
-		if (err)
-			goto out_err;
-	}
+	err = mmc_switch_status(card);
+	if (err)
+		goto out_err;
 
 	/* Switch HS to HS200 */
 	val = EXT_CSD_TIMING_HS200 |
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
 			   val, card->ext_csd.generic_cmd6_time, true,
-			   send_status, true);
+			   false, true);
 	if (err)
 		goto out_err;
 
 	mmc_set_timing(host, MMC_TIMING_MMC_HS200);
 
-	if (!send_status) {
-		err = mmc_switch_status(card);
-		if (err)
-			goto out_err;
-	}
+	err = mmc_switch_status(card);
+	if (err)
+		goto out_err;
 
 	mmc_set_bus_speed(card);
 
@@ -1243,7 +1227,6 @@ static void mmc_select_driver_type(struct mmc_card *card)
 static int mmc_select_hs200(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
-	bool send_status = true;
 	unsigned int old_timing;
 	int err = -EINVAL;
 	u8 val;
@@ -1260,9 +1243,6 @@ static int mmc_select_hs200(struct mmc_card *card)
 
 	mmc_select_driver_type(card);
 
-	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
-		send_status = false;
-
 	/*
 	 * Set the bus width(4 or 8) with host's support and
 	 * switch to HS200 mode if bus width is set successfully.
@@ -1274,20 +1254,18 @@ static int mmc_select_hs200(struct mmc_card *card)
 		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				   EXT_CSD_HS_TIMING, val,
 				   card->ext_csd.generic_cmd6_time,
-				   true, send_status, true);
+				   true, false, true);
 		if (err)
 			goto err;
 		old_timing = host->ios.timing;
 		mmc_set_timing(host, MMC_TIMING_MMC_HS200);
-		if (!send_status) {
-			err = mmc_switch_status(card);
-			/*
-			 * mmc_select_timing() assumes timing has not changed if
-			 * it is a switch error.
-			 */
-			if (err == -EBADMSG)
-				mmc_set_timing(host, old_timing);
-		}
+		err = mmc_switch_status(card);
+		/*
+		 * mmc_select_timing() assumes timing has not changed if
+		 * it is a switch error.
+		 */
+		if (err == -EBADMSG)
+			mmc_set_timing(host, old_timing);
 	}
 err:
 	if (err)
-- 
1.8.1.1.dirty
