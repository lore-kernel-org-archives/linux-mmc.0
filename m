From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH] mmc: core: Fix mmc_select_hs200() regression in v4.7-rc.
Date: Tue,  7 Jun 2016 14:02:23 +0100
Message-ID: <1465304543-23988-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

mmc_select_bus_width() returns bus width (4 or 8) on success or
zero if unsupported. If bus width is set successfully we then wish
to switch to HS200 mode.

This avoids the following error message in v4.70-rc2

[    2.523674] mmc0: mmc_select_hs200 failed, error 3
[    2.528516] mmc0: error 3 whilst initialising MMC card

With this patch card is enumerated correctly

[    2.468065] mmc0: new HS200 MMC card at address 0001
[    2.468335] mmcblk0: mmc0:0001 P1XXXX 7.20 GiB
[    2.468441] mmcblk0boot0: mmc0:0001 P1XXXX partition 1 2.00 MiB
[    2.468552] mmcblk0boot1: mmc0:0001 P1XXXX partition 2 2.00 MiB
[    2.468651] mmcblk0rpmb: mmc0:0001 P1XXXX partition 3 128 KiB
[    2.469269]  mmcblk0: p1

Fixes: 287980e (remove lots of IS_ERR_VALUE abuses)
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
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
