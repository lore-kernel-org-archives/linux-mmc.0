From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 03/16] mmc: core: refactor mmc_request_done()
Date: Thu,  9 Feb 2017 16:33:50 +0100
Message-ID: <20170209153403.9730-4-linus.walleij@linaro.org>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33511 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdBIPlD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Feb 2017 10:41:03 -0500
Received: by mail-lf0-f45.google.com with SMTP id x1so4693142lff.0
        for <linux-mmc@vger.kernel.org>; Thu, 09 Feb 2017 07:41:03 -0800 (PST)
In-Reply-To: <20170209153403.9730-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paolo Valente <paolo.valente@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>

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

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/core.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b2e7a6dfcbf0..8dbed198750f 100644
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

