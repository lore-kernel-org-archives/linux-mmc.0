From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2] mmc: core: Only change mode if mmc_select_bus_width() is successful.
Date: Wed,  8 Jun 2016 11:27:52 +0100
Message-ID: <1465381672-9772-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37813 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423210AbcFHK17 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2016 06:27:59 -0400
Received: by mail-wm0-f44.google.com with SMTP id k204so10226133wmk.0
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jun 2016 03:27:58 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, linux-mmc@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Arnd Bergmann <arnd@arndb.de>

mmc_select_bus_width() returns bus width (4 or 8) on success or
zero if unsupported. So only change mode if setting the bus width
is successful.

Fixes f741494 mmc: fix mmc mode selection for HS-DDR and higher
Fixes: 287980e (remove lots of IS_ERR_VALUE abuses)

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Arnd Bergmann <arnd@arndb.de>

---

v2: Rebase on v4.7-rc2 which includes a fix from Chen-Yu and update
    commit message.
---
 drivers/mmc/core/mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 5d438ad..aafb73d 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1276,7 +1276,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 	 * switch to HS200 mode if bus width is set successfully.
 	 */
 	err = mmc_select_bus_width(card);
-	if (err >= 0) {
+	if (err > 0) {
 		val = EXT_CSD_TIMING_HS200 |
 		      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
@@ -1583,7 +1583,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	} else if (mmc_card_hs(card)) {
 		/* Select the desired bus width optionally */
 		err = mmc_select_bus_width(card);
-		if (err >= 0) {
+		if (err > 0) {
 			err = mmc_select_hs_ddr(card);
 			if (err)
 				goto free_card;
-- 
1.9.1

