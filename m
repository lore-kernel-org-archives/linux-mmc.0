From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: fix regression: set default clock gating delay to 0
Date: Thu, 23 Feb 2012 11:22:29 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1202231119030.25586@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49647 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086Ab2BWKWh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Feb 2012 05:22:37 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Chris Ball <cjb@laptop.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>

A recent commit "mmc: core: Use delayed work in clock gating framework"
introduced a default 200ms delay before clock gating actually takes place.
This means, that every time an MMC interface becomes idle it first stays
on for 200ms before gating its clock. This leads to increased power
consumption and is therefore a clear regression. This patch restores the
original behaviour by setting the default delay to 0. Users,
prioritising throughput over power efficiency can still modify the delay
via sysfs.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

As discussed in this thread

http://thread.gmane.org/gmane.linux.kernel.mmc/12307

this is one of the ways to fix the regression. Please, push for 3.3.

 drivers/mmc/core/host.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 30055f2..c3704e2 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -238,10 +238,10 @@ static inline void mmc_host_clk_init(struct mmc_host *host)
 	/* Hold MCI clock for 8 cycles by default */
 	host->clk_delay = 8;
 	/*
-	 * Default clock gating delay is 200ms.
+	 * Default clock gating delay is 0ms to avoid wasting power.
 	 * This value can be tuned by writing into sysfs entry.
 	 */
-	host->clkgate_delay = 200;
+	host->clkgate_delay = 0;
 	host->clk_gated = false;
 	INIT_DELAYED_WORK(&host->clk_gate_work, mmc_host_clk_gate_work);
 	spin_lock_init(&host->clk_lock);
-- 
1.7.2.5

