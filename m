From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: mmc: Use 500ms as the default generic CMD6 timeout
Date: Fri,  4 Nov 2016 18:32:33 +0100
Message-ID: <1478280753-2482-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:36114 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934911AbcKDRcs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2016 13:32:48 -0400
Received: by mail-yw0-f171.google.com with SMTP id l124so96244453ywb.3
        for <linux-mmc@vger.kernel.org>; Fri, 04 Nov 2016 10:32:48 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, stable@vger.kernel.org

In the eMMC 4.51 version of the spec, an EXT_CSD field called
GENERIC_CMD6_TIME[248] was added. This allows cards to specify the maximum
time it may need to move out from its busy state, when a CMD6 command has
been sent.

In cases when the card is compliant to versions < 4.51 of the eMMC spec,
obviously the core needs to use a fall-back value for this timeout, which
currently is set to 10 minutes. This value is completely in the wrong range
and importantly in some cases it causes a card initialization to take more
than 10 minute to complete.

Earlier this scenario was avoided as the mmc core used CMD13 to poll the
card, to find out when it stopped signaling busy. Commit 08573eaf1a70
("mmc: mmc: do not use CMD13 to get status after speed mode switch")
changed this behavior.

Instead of reverting that commit, which would cause other issues, let's
instead start by picking a simple solution for the problem, by using a
500ms default generic CMD6 timeout.

The reason for using exactly 500ms, comes from observations that shows it's
quite common for cards to specify 250ms. 500ms is two times that value so
likely it should be enough for most cards.

Cc: <stable@vger.kernel.org> # v4.8+
Fixes: 08573eaf1a70 ("mmc: mmc: do not use CMD13 to get status after speed
mode switch")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e811bd9..9355366 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -26,6 +26,8 @@
 #include "mmc_ops.h"
 #include "sd_ops.h"
 
+#define DEFAULT_CMD6_TIMEOUT_MS	500
+
 static const unsigned int tran_exp[] = {
 	10000,		100000,		1000000,	10000000,
 	0,		0,		0,		0
@@ -571,6 +573,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		card->erased_byte = 0x0;
 
 	/* eMMC v4.5 or later */
+	card->ext_csd.generic_cmd6_time = DEFAULT_CMD6_TIMEOUT_MS;
 	if (card->ext_csd.rev >= 6) {
 		card->ext_csd.feature_support |= MMC_DISCARD_FEATURE;
 
-- 
1.9.1

