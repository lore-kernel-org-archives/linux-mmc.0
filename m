From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 1/4] mmc: core: Remove unnecessary check for the remove callback
Date: Thu, 30 May 2013 14:53:08 +0200
Message-ID: <1369918391-15277-2-git-send-email-ulf.hansson@stericsson.com>
References: <1369918391-15277-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:51785 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754569Ab3E3Mxe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 May 2013 08:53:34 -0400
In-Reply-To: <1369918391-15277-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

For every bus_ops type the .remove callback always exist, thus there
are no need to check the existence of it, before we decide to call it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index e9a104b..d2ee282 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2483,9 +2483,7 @@ void mmc_stop_host(struct mmc_host *host)
 	mmc_bus_get(host);
 	if (host->bus_ops && !host->bus_dead) {
 		/* Calling bus_ops->remove() with a claimed host can deadlock */
-		if (host->bus_ops->remove)
-			host->bus_ops->remove(host);
-
+		host->bus_ops->remove(host);
 		mmc_claim_host(host);
 		mmc_detach_bus(host);
 		mmc_power_off(host);
@@ -2638,8 +2636,7 @@ int mmc_suspend_host(struct mmc_host *host)
 			 * bus_ops->remove() with a claimed host can
 			 * deadlock.)
 			 */
-			if (host->bus_ops->remove)
-				host->bus_ops->remove(host);
+			host->bus_ops->remove(host);
 			mmc_claim_host(host);
 			mmc_detach_bus(host);
 			mmc_power_off(host);
@@ -2722,9 +2719,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
 			break;
 
 		/* Calling bus_ops->remove() with a claimed host can deadlock */
-		if (host->bus_ops->remove)
-			host->bus_ops->remove(host);
-
+		host->bus_ops->remove(host);
 		mmc_claim_host(host);
 		mmc_detach_bus(host);
 		mmc_power_off(host);
-- 
1.7.10

