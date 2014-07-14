From: Yunpeng Gao <yunpeng.gao@intel.com>
Subject: [PATCH] mmc: blk: add emmc cache flush in shutdown callback
Date: Mon, 14 Jul 2014 17:34:19 +0800
Message-ID: <1405330459-2335-1-git-send-email-yunpeng.gao@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44089 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753855AbaGNJcp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Jul 2014 05:32:45 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Yunpeng Gao <yunpeng.gao@intel.com>

If eMMC Cache feature enabled, we'd better flush
eMMC cache in the shutdown callback. Otherwise
data corruption issue may be observed.

Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
---
 drivers/mmc/card/block.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 452782b..8a4010e 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2509,6 +2509,10 @@ static int _mmc_blk_suspend(struct mmc_card *card)
 static void mmc_blk_shutdown(struct mmc_card *card)
 {
 	_mmc_blk_suspend(card);
+
+	mmc_claim_host(card->host);
+	mmc_flush_cache(card);
+	mmc_release_host(card->host);
 }
 
 #ifdef CONFIG_PM
-- 
1.7.9.5

