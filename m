From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 4/7] mmc: core: Check SWITCH_ERROR bit from each CMD13 response when polling
Date: Tue, 22 Nov 2016 21:56:10 +0100
Message-ID: <1479848173-20881-5-git-send-email-ulf.hansson@linaro.org>
References: <1479848173-20881-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35825 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756824AbcKVU4y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2016 15:56:54 -0500
Received: by mail-wm0-f47.google.com with SMTP id a197so46219333wmd.0
        for <linux-mmc@vger.kernel.org>; Tue, 22 Nov 2016 12:56:27 -0800 (PST)
In-Reply-To: <1479848173-20881-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

According to the JEDEC specification, the SWITCH_ERROR bit in the device
status from a R1 response, is an error bit which may be cleared as soon as
the response that reports the error is sent.

When polling with CMD13 to find out when the card stops signaling busy
after a CMD6 has been sent, we currently parse only the last CMD13 response
for the SWITCH_ERROR bit. Consequentially we could loose important
information about the card.

In worst case if the card stops signaling busy within the allowed timeout,
we could end up believing that the CMD6 command completed successfully,
when in fact it didn't.

To improve the behaviour, let's parse each CMD13 response to see if the
SWITCH_ERROR bit is set in the device status. In such case, we abort the
polling loop and report the error.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- New patch.

---
 drivers/mmc/core/mmc_ops.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 214e734..fba5d29 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -496,12 +496,16 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 			busy = host->ops->card_busy(host);
 		} else {
 			err = mmc_send_status(card, &status);
-			if (retry_crc_err && err == -EILSEQ)
+			if (retry_crc_err && err == -EILSEQ) {
 				busy = true;
-			else if (err)
+			} else if (err) {
 				return err;
-			else
+			} else {
+				err = mmc_switch_status_error(host, status);
+				if (err)
+					return err;
 				busy = R1_CURRENT_STATE(status) == R1_STATE_PRG;
+			}
 		}
 
 		/* Timeout if the device still remains busy. */
@@ -515,7 +519,7 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 	if (host->ops->card_busy && send_status)
 		return mmc_switch_status(card);
 
-	return mmc_switch_status_error(host, status);
+	return 0;
 }
 
 /**
-- 
1.9.1

