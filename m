From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] mmc: core: Allow fallback to mmc_select_hs()
Date: Tue, 16 May 2017 15:00:07 -0300
Message-ID: <1494957607-31956-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2nam02on0076.outbound.protection.outlook.com ([104.47.38.76]:18779
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751632AbdEPSAf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 16 May 2017 14:00:35 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, stefan@agner.ch, marcel.ziswiler@toradex.com, aisheng.dong@nxp.com, linux-mmc@vger.kernel.org, festevam@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>

If mmc_select_hs200() fails there is still a chance that the
card could operate in high speed mode, so change the logic in
mmc_select_timing() to allow a fallback to mmc_select_hs().

Tested on a imx7s-warp board.

Before this patch:
                                                          
mmc1: mmc_select_hs200 failed, error -74                         
mmc1: new MMC card at address 0001                               
mmcblk1: mmc1:0001 V10008 7.05 GiB                               
mmcblk1boot0: mmc1:0001 V10008 partition 1 4.00 MiB              
mmcblk1boot1: mmc1:0001 V10008 partition 2 4.00 MiB              
mmcblk1rpmb: mmc1:0001 V10008 partition 3 4.00 MiB 
              
# cat /sys/kernel/debug/mmc1/ios
clock:          25000000 Hz
actual clock:   24545454 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    0 (legacy)
signal voltage: 0 (3.30 V)
driver type:    0 (driver type B)

After this patch:
                                                         
mmc1: mmc_select_hs200 failed, error -74                         
mmc1: new DDR MMC card at address 0001                           
mmcblk1: mmc1:0001 V10008 7.05 GiB                               
mmcblk1boot0: mmc1:0001 V10008 partition 1 4.00 MiB              
mmcblk1boot1: mmc1:0001 V10008 partition 2 4.00 MiB              
mmcblk1rpmb: mmc1:0001 V10008 partition 3 4.00 MiB
               
# cat /sys/kernel/debug/mmc1/ios
clock:          52000000 Hz
actual clock:   49090909 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    8 (mmc DDR52)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Hi,

There was a previous attempt from Dong to fix this issue:
https://patchwork.kernel.org/patch/8893121/

,but it was dropped as it caused regression.

 drivers/mmc/core/mmc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e3b6bea..2c3be9a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1467,15 +1467,22 @@ static int mmc_select_hs200(struct mmc_card *card)
 static int mmc_select_timing(struct mmc_card *card)
 {
 	int err = 0;
+	bool hs400_200 = false;
 
 	if (!mmc_can_ext_csd(card))
 		goto bus_speed;
 
-	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES)
+	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES) {
 		err = mmc_select_hs400es(card);
-	else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
+		if (!err)
+			hs400_200 = true;
+	} else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200) {
 		err = mmc_select_hs200(card);
-	else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
+		if (!err)
+			hs400_200 = true;
+	}
+
+	if (!hs400_200 && (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS))
 		err = mmc_select_hs(card);
 
 	if (err && err != -EBADMSG)
-- 
2.7.4

