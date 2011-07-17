From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH] mmc: enable runtime PM by default
Date: Sun, 17 Jul 2011 16:39:14 +0100 (BST)
Message-ID: <20110717153914.A8FB49D401C@zog.reactivated.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:45847 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753796Ab1GQQSJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Jul 2011 12:18:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, ohad@wizery.com

Now that we have improved the runtime power management powerup/powerdown
code, we believe that MMC_CAP_POWER_OFF_CARD is no longer necessary:
runtime PM should now work everywhere.

Enable this trivially for a release or two. If no problems are reported,
we will follow up with a more extensive patch to remove this flag
altogether. If problems are reported, we can look at whitelist/blacklist
possibilities as before.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/mmc/core/host.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

For linux-3.2. Might cause some breakage, so it should see a full
linux-next cycle first.

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index b29d3e8..63bddd0 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -301,6 +301,17 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->max_blk_size = 512;
 	host->max_blk_count = PAGE_CACHE_SIZE / 512;
 
+	/*
+	 * Enable runtime power management by default. This flag was added due
+	 * to runtime power management causing disruption for some users, but
+	 * the power on/off code has been improved since then.
+	 *
+	 * We'll enable this flag by default as an experiment, and if no
+	 * problems are reported, we will follow up later and remove the flag
+	 * altogether.
+	 */
+	host->caps = MMC_CAP_POWER_OFF_CARD;
+
 	return host;
 
 free:
-- 
1.7.6

