From: Johan Rudholm <johan.rudholm@axis.com>
Subject: [PATCH v5 2/2] mmc: core: let hw_reset default to power_cycle
Date: Fri, 28 Nov 2014 16:56:54 +0100
Message-ID: <1417190214-32181-3-git-send-email-johanru@axis.com>
References: <1417190214-32181-1-git-send-email-johanru@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:37918 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbaK1P5W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Nov 2014 10:57:22 -0500
In-Reply-To: <1417190214-32181-1-git-send-email-johanru@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <johanru@axis.com>

If bus_ops->hw_reset is missing, try to power cycle the card instead.

This will allow SD cards to be power cycled and re-initialized as well.
Power cycling a buggy SD card sometimes helps it get back on track.

Signed-off-by: Johan Rudholm <johanru@axis.com>
---
 drivers/mmc/core/core.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 7a17cd2..45b367d 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2254,19 +2254,23 @@ static int mmc_do_hw_reset(struct mmc_host *host, int do_init)
 		return -EINVAL;
 
 	mmc_bus_get(host);
-	if (!host->bus_ops || host->bus_dead || !host->bus_ops->hw_reset) {
+	if (!host->bus_ops || host->bus_dead) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	ret = host->bus_ops->hw_reset(host);
-	if (ret)
-		goto out;
+	if (!host->bus_ops->hw_reset) {
+		mmc_power_cycle(host, host->card->ocr);
+	} else {
+		ret = host->bus_ops->hw_reset(host);
+		if (ret)
+			goto out;
+		if (do_init)
+			mmc_set_initial_state(host);
+	}
 
-	if (do_init) {
-		mmc_set_initial_state(host);
+	if (do_init)
 		ret = host->bus_ops->power_restore(host);
-	}
 
 	pr_warn("%s: tried to reset card\n", mmc_hostname(host));
 out:
-- 
1.7.2.5

