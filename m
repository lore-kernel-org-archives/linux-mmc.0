From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH] MMC: fix a race between card-detect rescan and
 clock-gate work instances
Date: Wed, 11 May 2011 20:15:26 +0800
Message-ID: <5D8008F58939784290FAB48F549751983DB52B1EEF@shsmsx502.ccr.corp.intel.com>
References: <Pine.LNX.4.64.1104152006110.18593@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:9304 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755482Ab1EKPuF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 May 2011 11:50:05 -0400
In-Reply-To: <Pine.LNX.4.64.1104152006110.18593@axis700.grange>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hello Liakhovetski,

Right now I am facing some problem during kernel booting which indicate caused by MMC driver. So I think I encountered the race condition you mentioned below.
I have gone through MMC stack code, seems sdhci_set_ios already wrapped by spin lock/unlock, so I am a little not understanding why there is still a race condition?
Is this race condition caused by sdhci_set_ios function reenter or something else?

Thanks for your help on this.

BR
Chuanxiao
-----Original Message-----
From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Guennadi Liakhovetski
Sent: Saturday, April 16, 2011 2:08 AM
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org; Magnus Damm; Simon Horman; Linus Walleij
Subject: [PATCH] MMC: fix a race between card-detect rescan and clock-gate work instances

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

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
