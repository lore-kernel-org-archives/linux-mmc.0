From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [PATCH]mmc: core: not to --qty when calculate timeout for
 SECURE_ERASE
Date: Fri, 13 Apr 2012 12:19:34 +0800
Message-ID: <20120413041934.GA30513@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6990 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007Ab2DMEZD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 13 Apr 2012 00:25:03 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: adrian.hunter@intel.com, cjb@laptop.org

--qty when calculating erase timeout for trim/erase & secure trim/erase
can prevent the erase range crossing qty+1 erase groups, which made
the final timeout value is too large for the host.

When operate SECURE_ERASE, driver needs the erase range is aligned with
erase size, otherwise do nothing and return an error. That is to say
it is not necessary for SECURE_ERASE to --qty since it will never cross
an erase group.

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/core/core.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index e541efb..b5a393a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1761,7 +1761,7 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
 	if (!qty)
 		return 0;
 
-	if (qty == 1)
+	if (qty == 1 && arg != MMC_SECURE_ERASE_ARG)
 		return 1;
 
 	/* Convert qty to sectors */
@@ -1772,6 +1772,13 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
 	else
 		max_discard = --qty * card->erase_size;
 
+	/*
+	 * since SECURE_ERASE is erase group aligned, otherwise
+	 * it cannot be erased in secure purpose, needn't --qty
+	 */
+	if (arg == MMC_SECURE_ERASE_ARG)
+		max_discard += card->erase_size;
+
 	return max_discard;
 }
 
-- 
1.7.1

