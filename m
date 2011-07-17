From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH] mmc: print debug messages for runtime PM actions
Date: Sun, 17 Jul 2011 16:38:41 +0100 (BST)
Message-ID: <20110717153841.D4BF29D401C@zog.reactivated.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:45847 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755971Ab1GQQSH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Jul 2011 12:18:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, ohad@wizery.com

At
http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg08371.html
we found and fixed a bug where mmc's runtime power management functions
were not being called. We have now also made improvements to the SDIO
powerup routine which could possibly mask this kind of issue in future.

Add debug messages to the runtime PM hooks so that it is easy to verify
if and when runtime PM is happening.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/mmc/core/core.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

For linux-3.1.

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0a04886..ad0c55a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1664,6 +1664,10 @@ int mmc_power_save_host(struct mmc_host *host)
 {
 	int ret = 0;
 
+#ifdef CONFIG_MMC_DEBUG
+	pr_info("%s: %s: powering down\n", mmc_hostname(host), __func__);
+#endif
+
 	mmc_bus_get(host);
 
 	if (!host->bus_ops || host->bus_dead || !host->bus_ops->power_restore) {
@@ -1686,6 +1690,10 @@ int mmc_power_restore_host(struct mmc_host *host)
 {
 	int ret;
 
+#ifdef CONFIG_MMC_DEBUG
+	pr_info("%s: %s: powering up\n", mmc_hostname(host), __func__);
+#endif
+
 	mmc_bus_get(host);
 
 	if (!host->bus_ops || host->bus_dead || !host->bus_ops->power_restore) {
-- 
1.7.6

