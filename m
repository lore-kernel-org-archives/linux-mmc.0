From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 3/5] mmc: core: improve the quirks for sdio devices
Date: Wed,  8 Feb 2017 09:15:44 +0800
Message-ID: <1486516546-187771-4-git-send-email-shawn.lin@rock-chips.com>
References: <1486516546-187771-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:57072 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932282AbdBHBXq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2017 20:23:46 -0500
In-Reply-To: <1486516546-187771-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

Rename mmc_fixup_methods to sdio_fixup_methods to better
reflect that it's for sdio devices. So we could also pass
on it from sdio card's probe sequence just like what we do
for eMMC and block there.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/core/quirks.h | 6 +-----
 drivers/mmc/core/sdio.c   | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 253a9d5..7cd873eb 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -17,7 +17,7 @@
 
 #include "card.h"
 
-static const struct mmc_fixup mmc_fixup_methods[] = {
+static const struct mmc_fixup sdio_fixup_methods[] = {
 	SDIO_FIXUP(SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
 		   add_quirk, MMC_QUIRK_NONSTD_FUNC_IF),
 
@@ -39,10 +39,6 @@
 	const struct mmc_fixup *f;
 	u64 rev = cid_rev_card(card);
 
-	/* Non-core specific workarounds. */
-	if (!table)
-		table = mmc_fixup_methods;
-
 	for (f = table; f->vendor_fixup; f++) {
 		if ((f->manfid == CID_MANFID_ANY ||
 		     f->manfid == card->cid.manfid) &&
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index f092a55..fae732c 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -739,7 +739,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 		card = oldcard;
 	}
 	card->ocr = ocr_card;
-	mmc_fixup_device(card, NULL);
+	mmc_fixup_device(card, sdio_fixup_methods);
 
 	if (card->type == MMC_TYPE_SD_COMBO) {
 		err = mmc_sd_setup_card(host, card, oldcard != NULL);
-- 
1.9.1


