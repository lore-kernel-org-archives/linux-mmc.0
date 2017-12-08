From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] mmc: block: blk-mq: Potential NULL deref on
 mmc_blk_alloc_req() failure
Date: Fri, 8 Dec 2017 14:55:16 +0300
Message-ID: <20171208115516.3h55rvjq54hyfecq@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:38148 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753303AbdLHLzi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Dec 2017 06:55:38 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org

mmc_blk_alloc_req() is supposed to return error pointers but there is
one path where we forget to set the error code and accidentally return
NULL.  The callers are not expecting that and will have a NULL pointer
dereference.

Fixes: 23da8bed11f2 ("mmc: block: Simplify cleaning up the queue")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ab384ba6cb37..6af2b660b1f7 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -3037,6 +3037,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	 */
 	if (!blk_get_queue(md->queue.queue)) {
 		mmc_cleanup_queue(&md->queue);
+		ret = -ENODEV;
 		goto err_putdisk;
 	}
 
