From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] RFT: mmc: block: restore NULL check when retrying
Date: Mon, 30 Jan 2017 14:26:25 +0100
Message-ID: <20170130132625.18296-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:32995 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752783AbdA3NfO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2017 08:35:14 -0500
Received: by mail-lf0-f52.google.com with SMTP id x1so107723119lff.0
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2017 05:34:54 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>

When retrying to send a request, we used to have a NULL
check on the request we try to resend.

It was removed in commit
c659b878689c ("mmc: block: inline command abortions")
but maybe that was not such a good idea. Maybe it can
actually be NULL?

This might be causeing regressions in errorpath behaviour
seen in kernelci boot tests on the sunxi.

I'm not sure because this state machine has so many
entrances and exits that I can't wrap my head around it.

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ede759dda395..6c8be1a80551 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1606,6 +1606,9 @@ static void mmc_blk_rw_cmd_abort(struct mmc_card *card, struct request *req)
 static void mmc_blk_rw_start_new(struct mmc_queue *mq, struct mmc_card *card,
 				 struct request *req)
 {
+	if (!req)
+		return;
+
 	if (mmc_card_removed(card)) {
 		req->rq_flags |= RQF_QUIET;
 		blk_end_request_all(req, -EIO);
-- 
2.9.3

