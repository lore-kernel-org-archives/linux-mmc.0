From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/3] mmc: core: refactor mmc_request_done()
Date: Tue, 28 Mar 2017 10:40:31 +0200
Message-ID: <20170328084031.11995-4-linus.walleij@linaro.org>
References: <20170328084031.11995-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33821 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754678AbdC1Il3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Mar 2017 04:41:29 -0400
Received: by mail-lf0-f45.google.com with SMTP id z15so33934770lfd.1
        for <linux-mmc@vger.kernel.org>; Tue, 28 Mar 2017 01:40:53 -0700 (PDT)
In-Reply-To: <20170328084031.11995-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>

We have this construction:

if (a && b && !c)
   finalize;
else
   block;
   finalize;

Which is equivalent by boolean logic to:

if (!a || !b || c)
   block;
finalize;

Which is simpler code.

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/core.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c0b3f80c1f39..86314fa85dd2 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -172,14 +172,16 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 
 	trace_mmc_request_done(host, mrq);
 
-	if (err && cmd->retries && !mmc_card_removed(host->card)) {
-		/*
-		 * Request starter must handle retries - see
-		 * mmc_wait_for_req_done().
-		 */
-		if (mrq->done)
-			mrq->done(mrq);
-	} else {
+	/*
+	 * We list various conditions for the command to be considered
+	 * properly done:
+	 *
+	 * - There was no error, OK fine then
+	 * - We are not doing some kind of retry
+	 * - The card was removed (...so just complete everything no matter
+	 *   if there are errors or retries)
+	 */
+	if (!err || !cmd->retries || mmc_card_removed(host->card)) {
 		mmc_should_fail_request(host, mrq);
 
 		if (!host->ongoing_mrq)
@@ -211,10 +213,13 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 				mrq->stop->resp[0], mrq->stop->resp[1],
 				mrq->stop->resp[2], mrq->stop->resp[3]);
 		}
-
-		if (mrq->done)
-			mrq->done(mrq);
 	}
+	/*
+	 * Request starter must handle retries - see
+	 * mmc_wait_for_req_done().
+	 */
+	if (mrq->done)
+		mrq->done(mrq);
 }
 
 EXPORT_SYMBOL(mmc_request_done);
-- 
2.9.3

