From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v3] mmc: core: Fix init_card in 52Mhz
Date: Mon, 12 Oct 2015 17:22:23 +0800
Message-ID: <1444641743-15614-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:60014 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750858AbbJLJWe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Oct 2015 05:22:34 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@freescale.com>, Johan Rudholm <johan.rudholm@axis.com>, Gwendal Grignou <gwendal@chromium.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>

Suppose that we got a data crc error, and it triggers the mmc_reset.
mmc_reset will call mmc_send_status to see if HW reset was supported.
before issue CMD13, it will do retune, and if EMMC was in HS400 mode,
it will reduce frequency to 52Mhz firstly, then results in card init
was doing at 52Mhz.
The mmc_send_status was originally only done for mmc_test, should drop
it. And, rename the "eMMC hardware reset" to "Reset test", as we would
also be able to use the test for SD-cards.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/mmc_test.c | 9 +++------
 drivers/mmc/core/mmc.c      | 7 -------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index b78cf5d..7fc9174 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -2263,15 +2263,12 @@ static int mmc_test_profile_sglen_r_nonblock_perf(struct mmc_test_card *test)
 /*
  * eMMC hardware reset.
  */
-static int mmc_test_hw_reset(struct mmc_test_card *test)
+static int mmc_test_reset(struct mmc_test_card *test)
 {
 	struct mmc_card *card = test->card;
 	struct mmc_host *host = card->host;
 	int err;
 
-	if (!mmc_card_mmc(card) || !mmc_can_reset(card))
-		return RESULT_UNSUP_CARD;
-
 	err = mmc_hw_reset(host);
 	if (!err)
 		return RESULT_OK;
@@ -2605,8 +2602,8 @@ static const struct mmc_test_case mmc_test_cases[] = {
 	},
 
 	{
-		.name = "eMMC hardware reset",
-		.run = mmc_test_hw_reset,
+		.name = "Reset test",
+		.run = mmc_test_reset,
 	},
 };
 
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e726903..f6cd995 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1924,7 +1924,6 @@ EXPORT_SYMBOL(mmc_can_reset);
 static int mmc_reset(struct mmc_host *host)
 {
 	struct mmc_card *card = host->card;
-	u32 status;
 
 	if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
 		return -EOPNOTSUPP;
@@ -1937,12 +1936,6 @@ static int mmc_reset(struct mmc_host *host)
 
 	host->ops->hw_reset(host);
 
-	/* If the reset has happened, then a status command will fail */
-	if (!mmc_send_status(card, &status)) {
-		mmc_host_clk_release(host);
-		return -ENOSYS;
-	}
-
 	/* Set initial state and call mmc_set_ios */
 	mmc_set_initial_state(host);
 	mmc_host_clk_release(host);
-- 
1.8.1.1.dirty

