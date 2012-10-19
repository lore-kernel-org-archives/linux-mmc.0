From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH] mmc: core: fix UHS-I card invalid allocation unit issue
Date: Fri, 19 Oct 2012 18:22:34 +0800
Message-ID: <1350642154-14314-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:33288 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754008Ab2JSKX3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Oct 2012 06:23:29 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, ulf.hansson@linaro.org, zgao6@marvell.com
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com, Dingyong Hu <hudy@marvell.com>

From: Kevin Liu <kliu5@marvell.com>

For UHS-I card, UHS_AU_SIZE rather than AU_SIZE should be
referred. And since SD spec3.0, the valid value for AU_SIZE
is changed from 0x1~0x9 to 0x1~0xF.

Signed-off-by: Dingyong Hu <hudy@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/core/sd.c   |   18 +++++++++++-------
 drivers/mmc/core/sd.h   |    2 +-
 drivers/mmc/core/sdio.c |    3 ++-
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 3dafb54..a7b1c38 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -212,9 +212,9 @@ static int mmc_decode_scr(struct mmc_card *card)
 /*
  * Fetch and process SD Status register.
  */
-static int mmc_read_ssr(struct mmc_card *card)
+static int mmc_read_ssr(struct mmc_card *card, bool uhs_card)
 {
-	unsigned int au, es, et, eo;
+	unsigned int au, es, et, eo, au_min, au_max;
 	int err, i;
 	u32 *ssr;
 
@@ -243,8 +243,11 @@ static int mmc_read_ssr(struct mmc_card *card)
 	 * UNSTUFF_BITS only works with four u32s so we have to offset the
 	 * bitfield positions accordingly.
 	 */
-	au = UNSTUFF_BITS(ssr, 428 - 384, 4);
-	if (au > 0 && au <= 9) {
+	au_min = uhs_card ? 0x7 : 0x1;
+	au_max = card->scr.sda_spec3 ? 0xF : 0x9;
+	au = uhs_card ? UNSTUFF_BITS(ssr, 392 - 384, 4) :
+		UNSTUFF_BITS(ssr, 428 - 384, 4);
+	if (au >= au_min && au <= au_max) {
 		card->ssr.au = 1 << (au + 4);
 		es = UNSTUFF_BITS(ssr, 408 - 384, 16);
 		et = UNSTUFF_BITS(ssr, 402 - 384, 6);
@@ -793,7 +796,7 @@ int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card)
 }
 
 int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
-	bool reinit)
+	bool reinit, bool uhs_card)
 {
 	int err;
 
@@ -812,7 +815,7 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
 		/*
 		 * Fetch and process SD Status register.
 		 */
-		err = mmc_read_ssr(card);
+		err = mmc_read_ssr(card, uhs_card);
 		if (err)
 			return err;
 
@@ -948,7 +951,8 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 			return err;
 	}
 
-	err = mmc_sd_setup_card(host, card, oldcard != NULL);
+	err = mmc_sd_setup_card(host, card, oldcard != NULL,
+		rocr & SD_ROCR_S18A);
 	if (err)
 		goto free_card;
 
diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
index 4b34b24..93ce00a 100644
--- a/drivers/mmc/core/sd.h
+++ b/drivers/mmc/core/sd.h
@@ -9,7 +9,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr);
 int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card);
 void mmc_decode_cid(struct mmc_card *card);
 int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
-	bool reinit);
+	bool reinit, bool uhs_card);
 unsigned mmc_sd_get_max_clock(struct mmc_card *card);
 int mmc_sd_switch_hs(struct mmc_card *card);
 void mmc_sd_go_highspeed(struct mmc_card *card);
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 2273ce6..fc9c63f 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -742,7 +742,8 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	mmc_fixup_device(card, NULL);
 
 	if (card->type == MMC_TYPE_SD_COMBO) {
-		err = mmc_sd_setup_card(host, card, oldcard != NULL);
+		err = mmc_sd_setup_card(host, card, oldcard != NULL,
+			ocr & R4_18V_PRESENT);
 		/* handle as SDIO-only card if memory init failed */
 		if (err) {
 			mmc_go_idle(host);
-- 
1.7.0.4

