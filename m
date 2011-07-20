From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH v2] mmc: enable runtime PM by default
Date: Wed, 20 Jul 2011 17:39:22 +0100 (BST)
Message-ID: <20110720163922.859369D401C@zog.reactivated.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:50512 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751543Ab1GTQjd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jul 2011 12:39:33 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, ohad@wizery.com

Now that we have improved the runtime power management powerup/powerdown
code, we believe that MMC_CAP_POWER_OFF_CARD is no longer necessary:
runtime PM should now work everywhere.

The only hard evidence for introducing MMC_CAP_POWER_OFF_CARD was the
Marvell sd8686 wifi chip, which was believed to require external gpio
manipulation which wasn't supported by some boards.

After further investigation it was realized (and confirmed by Marvell
folks) that sd8686 requirements can be fulfilled by changing the reset
sequence itself, even if no external gpio is manipulated.

For further information, see the following thread:
http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg04289.html

Enable this trivially for a release or two. If no problems are reported,
we will follow up with a more extensive patch to remove this flag
altogether. If problems are reported, we can look at whitelist/blacklist
possibilities as before.

Signed-off-by: Daniel Drake <dsd@laptop.org>
Acked-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/mmc/core/host.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

For Linux 3.2.

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

