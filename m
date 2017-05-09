From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 5/5] Revert "mmc: dw_mmc: Don't allow Runtime PM for SDIO cards"
Date: Tue,  9 May 2017 10:27:29 +0200
Message-ID: <1494318449-2591-6-git-send-email-ulf.hansson@linaro.org>
References: <1494318449-2591-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:34731 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbdEII1n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 May 2017 04:27:43 -0400
Received: by mail-wr0-f179.google.com with SMTP id l9so63240786wre.1
        for <linux-mmc@vger.kernel.org>; Tue, 09 May 2017 01:27:42 -0700 (PDT)
In-Reply-To: <1494318449-2591-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Brian Norris <briannorris@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@google.com>

This reverts commit a6db2c86033b ("mmc: dw_mmc: Don't allow Runtime PM for
SDIO cards")'

As dw_mmc now is capable of preventing runtime PM suspend while SDIO IRQs
are enabled, let's drop the less fine-grained method, which is preventing
runtime PM suspend for all SDIO cards - no matter of whether SDIO IRQs are
being enabled or not.

In this way we don't keep the host runtime PM resumed, unless it's really
needed, thus avoiding to waste power.

Especially when SDIO IRQs is supported via a separate out-of-band IRQ line,
which isn't defined by the SDIO standard, typically the SDIO func driver
doesn't enable SDIO IRQs via sdio_claim_irq(). So, for these cases we can
now allow the dwmmc device to be runtime PM suspended in-between requests.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
	- Don't remove include of pm_runtime.h as it's needed.

---
 drivers/mmc/host/dw_mmc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 454b847..0e2d6f7 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1621,16 +1621,10 @@ static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card *card)
 
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

