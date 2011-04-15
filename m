From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] MMC: fix a race between card-detect rescan and clock-gate
 work instances
Date: Fri, 15 Apr 2011 20:08:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1104152006110.18593@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Currently there is a race in the MMC core between a card-detect
rescan work and the clock-gating work, scheduled from a command
completion. Fix it by removing the dedicated clock-gating mutex and
using the MMC standard locking mechanism instead.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <damm@opensource.se>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/host.c  |    9 ++++-----
 include/linux/mmc/host.h |    1 -
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 461e6a1..2b200c1 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -94,7 +94,7 @@ static void mmc_host_clk_gate_delayed(struct mmc_host *host)
 		spin_unlock_irqrestore(&host->clk_lock, flags);
 		return;
 	}
-	mutex_lock(&host->clk_gate_mutex);
+	mmc_claim_host(host);
 	spin_lock_irqsave(&host->clk_lock, flags);
 	if (!host->clk_requests) {
 		spin_unlock_irqrestore(&host->clk_lock, flags);
@@ -104,7 +104,7 @@ static void mmc_host_clk_gate_delayed(struct mmc_host *host)
 		pr_debug("%s: gated MCI clock\n", mmc_hostname(host));
 	}
 	spin_unlock_irqrestore(&host->clk_lock, flags);
-	mutex_unlock(&host->clk_gate_mutex);
+	mmc_release_host(host);
 }
 
 /*
@@ -130,7 +130,7 @@ void mmc_host_clk_ungate(struct mmc_host *host)
 {
 	unsigned long flags;
 
-	mutex_lock(&host->clk_gate_mutex);
+	mmc_claim_host(host);
 	spin_lock_irqsave(&host->clk_lock, flags);
 	if (host->clk_gated) {
 		spin_unlock_irqrestore(&host->clk_lock, flags);
@@ -140,7 +140,7 @@ void mmc_host_clk_ungate(struct mmc_host *host)
 	}
 	host->clk_requests++;
 	spin_unlock_irqrestore(&host->clk_lock, flags);
-	mutex_unlock(&host->clk_gate_mutex);
+	mmc_release_host(host);
 }
 
 /**
@@ -215,7 +215,6 @@ static inline void mmc_host_clk_init(struct mmc_host *host)
 	host->clk_gated = false;
 	INIT_WORK(&host->clk_gate_work, mmc_host_clk_gate_work);
 	spin_lock_init(&host->clk_lock);
-	mutex_init(&host->clk_gate_mutex);
 }
 
 /**
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index bcb793e..eb792cb 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -183,7 +183,6 @@ struct mmc_host {
 	struct work_struct	clk_gate_work; /* delayed clock gate */
 	unsigned int		clk_old;	/* old clock value cache */
 	spinlock_t		clk_lock;	/* lock for clk fields */
-	struct mutex		clk_gate_mutex;	/* mutex for clock gating */
 #endif
 
 	/* host specific block data */
-- 
1.7.2.5

