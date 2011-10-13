From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: core: Prevent too long response times for suspend
Date: Thu, 13 Oct 2011 16:03:58 +0200
Message-ID: <1318514638-32452-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:57380 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755587Ab1JMOEP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2011 10:04:15 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>

While trying to suspend the mmc host there could still be
ongoing requests that we need to wait for. At the same time
a device driver must respond to a suspend request rather quickly.

Instead of potentially wait "forever" by claiming the host we now
"try" to claim the host instead. If it fails, -EBUSY is returned.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/mmc/core/core.c |   42 +++++++++++++++++++++++++++---------------
 1 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 61d7730..b900932 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2121,21 +2121,33 @@ int mmc_suspend_host(struct mmc_host *host)
 
 	mmc_bus_get(host);
 	if (host->bus_ops && !host->bus_dead) {
-		if (host->bus_ops->suspend)
-			err = host->bus_ops->suspend(host);
-		if (err == -ENOSYS || !host->bus_ops->resume) {
-			/*
-			 * We simply "remove" the card in this case.
-			 * It will be redetected on resume.
-			 */
-			if (host->bus_ops->remove)
-				host->bus_ops->remove(host);
-			mmc_claim_host(host);
-			mmc_detach_bus(host);
-			mmc_power_off(host);
-			mmc_release_host(host);
-			host->pm_flags = 0;
-			err = 0;
+
+		/*
+		 * A long response time is not acceptable for device drivers
+		 * when doing suspend. Prevent mmc_claim_host in the suspend
+		 * sequence, to potentially wait "forever" by trying to
+		 * pre-claim the host.
+		 */
+		if (mmc_try_claim_host(host)) {
+			if (host->bus_ops->suspend)
+				err = host->bus_ops->suspend(host);
+			if (err == -ENOSYS || !host->bus_ops->resume) {
+				/*
+				 * We simply "remove" the card in this case.
+				 * It will be redetected on resume.
+				 */
+				if (host->bus_ops->remove)
+					host->bus_ops->remove(host);
+				mmc_claim_host(host);
+				mmc_detach_bus(host);
+				mmc_power_off(host);
+				mmc_release_host(host);
+				host->pm_flags = 0;
+				err = 0;
+			}
+			mmc_do_release_host(host);
+		} else {
+			err = -EBUSY;
 		}
 	}
 	mmc_bus_put(host);
-- 
1.7.5.4

