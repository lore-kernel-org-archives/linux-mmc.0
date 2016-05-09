From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] mmc: sdio: fall back to SDIO 1.0 for broken 1.1 cards
Date: Mon,  9 May 2016 09:59:59 +0200
Message-ID: <1462780799-5366-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47676 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752332AbcEIIAR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 9 May 2016 04:00:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

I have two SDIO WLAN cards which specify being SDIO Rev. 1.1 cards but
their FUNCE tuple reports the smaller size of a Rev 1.0 card. So,
enforce 1.0 on these cards to avoid reading the not present registers.
They are not really used anyhow. My cards initialize properly after this
patch.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/sdio_cis.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
index 6f6fc527a26338..dcb3dee59fa5f2 100644
--- a/drivers/mmc/core/sdio_cis.c
+++ b/drivers/mmc/core/sdio_cis.c
@@ -177,8 +177,13 @@ static int cistpl_funce_func(struct mmc_card *card, struct sdio_func *func,
 	vsn = func->card->cccr.sdio_vsn;
 	min_size = (vsn == SDIO_SDIO_REV_1_00) ? 28 : 42;
 
-	if (size < min_size)
+	if (size == 28 && vsn == SDIO_SDIO_REV_1_10) {
+		pr_warn("%s: card has broken SDIO 1.1 CIS, forcing SDIO 1.0\n",
+			mmc_hostname(card->host));
+		vsn = SDIO_SDIO_REV_1_00;
+	} else if (size < min_size) {
 		return -EINVAL;
+	}
 
 	/* TPLFE_MAX_BLK_SIZE */
 	func->max_blksize = buf[12] | (buf[13] << 8);
-- 
2.7.0

