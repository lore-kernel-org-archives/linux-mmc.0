From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: core: fix the wrong error control
Date: Mon, 30 May 2016 16:40:14 +0900
Message-ID: <1464594014-31934-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ulf.hansson@linaro.org, arnd@arndb.de, a.hajda@samsung.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, k.kozlowski@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

After applied "remove lots of IS_ERR_VALUE abuses", it shoold be
misoperation. (commit 287980e49)
If mmc_bus_test is successful, it returned the bus-witdh bit.

The below log is error log
[    2.542260] mmc0: mmc_select_hs200 failed, error 3
[    2.542275] mmc0: error 3 whilst initialising MMC card

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/core/mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c984321..aafb73d 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1276,7 +1276,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 	 * switch to HS200 mode if bus width is set successfully.
 	 */
 	err = mmc_select_bus_width(card);
-	if (!err) {
+	if (err > 0) {
 		val = EXT_CSD_TIMING_HS200 |
 		      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
@@ -1583,7 +1583,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	} else if (mmc_card_hs(card)) {
 		/* Select the desired bus width optionally */
 		err = mmc_select_bus_width(card);
-		if (!err) {
+		if (err > 0) {
 			err = mmc_select_hs_ddr(card);
 			if (err)
 				goto free_card;
-- 
1.9.1
