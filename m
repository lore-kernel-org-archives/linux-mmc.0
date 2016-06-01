From: Dan O'Donovan <dan@emutex.com>
Subject: [PATCH] mmc: mmc: fix check on mmc_select_bus_width return value
Date: Wed,  1 Jun 2016 13:17:15 +0100
Message-ID: <1464783435-19338-1-git-send-email-dan@emutex.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bert.emutex.com ([91.103.1.109]:60623 "EHLO bert.emutex.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839AbcFAMP0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 1 Jun 2016 08:15:26 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, arnd@arndb.de, Dan O'Donovan <dan@emutex.com>

This fixes a bug introduced by commit 287980e49ffc ("remove lots of
IS_ERR_VALUE abuses").  mmc_select_bus_width can return positive
integer values upon success, so the (!err) check is incorrect here.
This causes mmc initialisation failure, and subsequently boot
failure, on some platforms.

Signed-off-by: Dan O'Donovan <dan@emutex.com>
---
 drivers/mmc/core/mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c984321..5d438ad 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1276,7 +1276,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 	 * switch to HS200 mode if bus width is set successfully.
 	 */
 	err = mmc_select_bus_width(card);
-	if (!err) {
+	if (err >= 0) {
 		val = EXT_CSD_TIMING_HS200 |
 		      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
@@ -1583,7 +1583,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	} else if (mmc_card_hs(card)) {
 		/* Select the desired bus width optionally */
 		err = mmc_select_bus_width(card);
-		if (!err) {
+		if (err >= 0) {
 			err = mmc_select_hs_ddr(card);
 			if (err)
 				goto free_card;
-- 
2.1.4

