From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 5/5] Revert "mmc: dw_mmc: Don't allow Runtime PM for SDIO cards"
Date: Wed, 19 Apr 2017 23:17:11 +0200
Message-ID: <1492636631-28254-6-git-send-email-ulf.hansson@linaro.org>
References: <1492636631-28254-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35976 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967325AbdDSVR0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Apr 2017 17:17:26 -0400
Received: by mail-wm0-f42.google.com with SMTP id o81so89660865wmb.1
        for <linux-mmc@vger.kernel.org>; Wed, 19 Apr 2017 14:17:25 -0700 (PDT)
In-Reply-To: <1492636631-28254-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Brian Norris <briannorris@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@google.com>

This reverts commit a6db2c86033bc41329770e90c20d4f1fec3824e4.

As dw_mmc now is capable of preventing runtime PM suspend while SDIO IRQs
are enabled, let's drop the less fine-grained approach of preventing
runtime PM suspend for all SDIO cards.

In this way we wont keep the host runtime PM resumed, unless really needed
and thus avoiding to waste power.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/dw_mmc.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c14a36b..c95dc9b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -23,7 +23,6 @@
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
@@ -1622,16 +1621,10 @@ static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card *card)
 
 		if (card->type == MMC_TYPE_SDIO ||
 		    card->type == MMC_TYPE_SD_COMBO) {
-			if (!test_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags)) {
-				pm_runtime_get_noresume(mmc->parent);
-				set_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
-			}
+			set_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
 			clk_en_a = clk_en_a_old & ~clken_low_pwr;
 		} else {
-			if (test_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags)) {
-				pm_runtime_put_noidle(mmc->parent);
-				clear_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
-			}
+			clear_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
 			clk_en_a = clk_en_a_old | clken_low_pwr;
 		}
 
-- 
2.7.4

