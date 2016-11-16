From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/9] mmc: core: Retry instead of ignore at CRC errors when polling for busy
Date: Wed, 16 Nov 2016 11:51:13 +0100
Message-ID: <1479293481-20186-2-git-send-email-ulf.hansson@linaro.org>
References: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:34738 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754313AbcKPKvf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2016 05:51:35 -0500
Received: by mail-qt0-f179.google.com with SMTP id n6so96179034qtd.1
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2016 02:51:34 -0800 (PST)
In-Reply-To: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

After a CMD6 command has been sent, the __mmc_switch() function might be
advised to poll the card for busy by using CMD13 and also by ignoring CRC
errors.

In the case of ignoring CRC errors, the mmc core tells the mmc host to also
ignore these errors via masking the MMC_RSP_CRC response flag. This seems
wrong, as it leads to that the mmc host could propagate an unreliable
response, instead of a proper error code.

What we really want, is not to ignore CRC errors but instead retry the
polling attempt. So, let's change this by treating a CRC error as the card
is still being busy and thus continue to run the polling loop.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 481bbdb..4773c56 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -503,10 +503,13 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 		if (host->ops->card_busy) {
 			busy = host->ops->card_busy(host);
 		} else {
-			err = __mmc_send_status(card, &status, ignore_crc);
-			if (err)
+			err = mmc_send_status(card, &status);
+			if (ignore_crc && err == -EILSEQ)
+				busy = true;
+			else if (err)
 				return err;
-			busy = R1_CURRENT_STATE(status) == R1_STATE_PRG;
+			else
+				busy = R1_CURRENT_STATE(status) == R1_STATE_PRG;
 		}
 
 		/* Timeout if the device still remains busy. */
-- 
1.9.1

