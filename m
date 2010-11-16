From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 3/3] mmc: protect some gating variables
Date: Tue, 16 Nov 2010 17:57:00 +0100
Message-ID: <1289926620-14085-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:40620 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754277Ab0KPQ5M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Nov 2010 11:57:12 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Linus Walleij <linus.walleij@stericsson.com>

This adds some more picky variable protection to the state holders
for the clock gating code. This is particularly important when
ordinary .set_ios() calls would race with the .set_ios() call
resulting from a delayed gate operation.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/core/core.c |   33 ++++++++++++++++++++++++---------
 drivers/mmc/core/core.h |    1 +
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8afc620..c5ae489 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -617,15 +617,8 @@ static inline void mmc_set_ios(struct mmc_host *host)
 		 ios->power_mode, ios->chip_select, ios->vdd,
 		 ios->bus_width, ios->timing);
 
-#ifdef CONFIG_MMC_CLKGATE
-	/*
-	 * We've been given a new frequency while the clock is gated,
-	 * so make sure we regard this as ungating it.
-	 */
-	if (ios->clock > 0 && host->clk_gated)
-		host->clk_gated = false;
-#endif
-
+	if (ios->clock > 0)
+		mmc_set_ungated(host);
 	host->ops->set_ios(host, ios);
 }
 
@@ -659,9 +652,13 @@ void mmc_set_clock(struct mmc_host *host, unsigned int hz)
  */
 void mmc_gate_clock(struct mmc_host *host)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->clk_lock, flags);
 	host->clk_old = host->ios.clock;
 	host->ios.clock = 0;
 	host->clk_gated = true;
+	spin_unlock_irqrestore(&host->clk_lock, flags);
 	mmc_set_ios(host);
 }
 
@@ -680,9 +677,27 @@ void mmc_ungate_clock(struct mmc_host *host)
 	 */
 	if (host->clk_old) {
 		BUG_ON(host->ios.clock);
+		/* This call will also set host->clk_gated to false */
 		mmc_set_clock(host, host->clk_old);
 	}
+}
+
+void mmc_set_ungated(struct mmc_host *host)
+{
+	unsigned long flags;
+
+	/*
+	 * We've been given a new frequency while the clock is gated,
+	 * so make sure we regard this as ungating it.
+	 */
+	spin_lock_irqsave(&host->clk_lock, flags);
 	host->clk_gated = false;
+	spin_unlock_irqrestore(&host->clk_lock, flags);
+}
+
+#else
+void mmc_set_ungated(struct mmc_host *host)
+{
 }
 #endif
 
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 9972808..026c975 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -35,6 +35,7 @@ void mmc_set_chip_select(struct mmc_host *host, int mode);
 void mmc_set_clock(struct mmc_host *host, unsigned int hz);
 void mmc_gate_clock(struct mmc_host *host);
 void mmc_ungate_clock(struct mmc_host *host);
+void mmc_set_ungated(struct mmc_host *host);
 void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode);
 void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
 void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
-- 
1.6.3.3

