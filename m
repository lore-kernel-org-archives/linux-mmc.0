From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH] mmc: core: Fix voltage select in DDR mode
Date: Thu, 15 Dec 2011 17:27:42 +0530
Message-ID: <1323950262-2160-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59341 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758718Ab1LOLxr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Dec 2011 06:53:47 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>, Philip Rakity <prakity@marvell.com>, Arindam Nath <arindam.nath@amd.com>, Chris Ball <cjb@laptop.org>

This patch fixes the wrong comparison before setting the interface
voltage in DDR mode.

The assignment to the variable ddr before comaprison is either
ddr = MMC_1_2V_DDR_MODE; or ddr == MMC_1_8V_DDR_MODE. But the comparison
is done wth the extended csd value if (ddr == EXT_CSD_CARD_TYPE_DDR_1_2V)

cc: Philip Rakity <prakity@marvell.com>
cc: Arindam Nath <arindam.nath@amd.com>
cc: Chris Ball <cjb@laptop.org>
Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
 drivers/mmc/core/mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 006e932..f0a9f1f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1058,7 +1058,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			 *
 			 * WARNING: eMMC rules are NOT the same as SD DDR
 			 */
-			if (ddr == EXT_CSD_CARD_TYPE_DDR_1_2V) {
+			if (ddr == MMC_1_2V_DDR_MODE) {
 				err = mmc_set_signal_voltage(host,
 					MMC_SIGNAL_VOLTAGE_120, 0);
 				if (err)
-- 
1.7.1

