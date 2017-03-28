From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/3] mmc: core: move some code in mmc_start_areq()
Date: Tue, 28 Mar 2017 10:40:29 +0200
Message-ID: <20170328084031.11995-2-linus.walleij@linaro.org>
References: <20170328084031.11995-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:36277 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754563AbdC1Il2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Mar 2017 04:41:28 -0400
Received: by mail-lf0-f53.google.com with SMTP id x137so33901294lff.3
        for <linux-mmc@vger.kernel.org>; Tue, 28 Mar 2017 01:40:46 -0700 (PDT)
In-Reply-To: <20170328084031.11995-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>

"previous" is a better name for the variable storing the previous
asynchronous request, better than the opaque name "data" atleast.
We see that we assign the return status to the returned variable
on all code paths, so we might as well just do that immediately
after calling mmc_finalize_areq().

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 926e0fde07d7..b8468950e59d 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -683,7 +683,7 @@ struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
 {
 	enum mmc_blk_status status;
 	int start_err = 0;
-	struct mmc_async_req *data = host->areq;
+	struct mmc_async_req *previous = host->areq;
 
 	/* Prepare a new request */
 	if (areq)
@@ -691,13 +691,12 @@ struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
 
 	/* Finalize previous request */
 	status = mmc_finalize_areq(host);
+	if (ret_stat)
+		*ret_stat = status;
 
 	/* The previous request is still going on... */
-	if (status == MMC_BLK_NEW_REQUEST) {
-		if (ret_stat)
-			*ret_stat = status;
+	if (status == MMC_BLK_NEW_REQUEST)
 		return NULL;
-	}
 
 	/* Fine so far, start the new request! */
 	if (status == MMC_BLK_SUCCESS && areq)
@@ -716,9 +715,7 @@ struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
 	else
 		host->areq = areq;
 
-	if (ret_stat)
-		*ret_stat = status;
-	return data;
+	return previous;
 }
 EXPORT_SYMBOL(mmc_start_areq);
 
-- 
2.9.3

