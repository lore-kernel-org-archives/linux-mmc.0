From: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Subject: [PATCH 2/2] mmc: mxs-mmc: fix deadlock caused by recursion loop
Date: Tue, 17 Jul 2012 17:16:10 +0300
Message-ID: <1342534570-8293-3-git-send-email-lauri.hintsala@bluegiga.com>
References: <1342534570-8293-1-git-send-email-lauri.hintsala@bluegiga.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bluegiga.fi ([194.100.31.45]:54770 "EHLO blue-gw.bluegiga.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754751Ab2GQOQi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 17 Jul 2012 10:16:38 -0400
In-Reply-To: <1342534570-8293-1-git-send-email-lauri.hintsala@bluegiga.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, Marek Vasut <marex@denx.de>, attila@kinali.ch, koen.beel@barco.com, Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, veli-pekka.peltola@bluegiga.com, Lauri Hintsala <lauri.hintsala@bluegiga.com>

Release the lock before mmc_signal_sdio_irq is called by
mxs_mmc_enable_sdio_irq.

Backtrace:
[   65.470000] =============================================
[   65.470000] [ INFO: possible recursive locking detected ]
[   65.470000] 3.5.0-rc5 #2 Not tainted
[   65.470000] ---------------------------------------------
[   65.470000] ksdioirqd/mmc0/73 is trying to acquire lock:
[   65.470000]  (&(&host->lock)->rlock#2){-.-...}, at: [<bf054120>] mxs_mmc_enable_sdio_irq+0x18/0xdc [mxs_mmc]
[   65.470000]
[   65.470000] but task is already holding lock:
[   65.470000]  (&(&host->lock)->rlock#2){-.-...}, at: [<bf054120>] mxs_mmc_enable_sdio_irq+0x18/0xdc [mxs_mmc]
[   65.470000]
[   65.470000] other info that might help us debug this:
[   65.470000]  Possible unsafe locking scenario:
[   65.470000]
[   65.470000]        CPU0
[   65.470000]        ----
[   65.470000]   lock(&(&host->lock)->rlock#2);
[   65.470000]   lock(&(&host->lock)->rlock#2);
[   65.470000]
[   65.470000]  *** DEADLOCK ***
[   65.470000]
[   65.470000]  May be due to missing lock nesting notation
[   65.470000]
[   65.470000] 1 lock held by ksdioirqd/mmc0/73:
[   65.470000]  #0:  (&(&host->lock)->rlock#2){-.-...}, at: [<bf054120>] mxs_mmc_enable_sdio_irq+0x18/0xdc [mxs_mmc]
[   65.470000]
[   65.470000] stack backtrace:
[   65.470000] [<c0014990>] (unwind_backtrace+0x0/0xf4) from [<c005ccb8>] (__lock_acquire+0x14f8/0x1b98)
[   65.470000] [<c005ccb8>] (__lock_acquire+0x14f8/0x1b98) from [<c005d3f8>] (lock_acquire+0xa0/0x108)
[   65.470000] [<c005d3f8>] (lock_acquire+0xa0/0x108) from [<c02f671c>] (_raw_spin_lock_irqsave+0x48/0x5c)
[   65.470000] [<c02f671c>] (_raw_spin_lock_irqsave+0x48/0x5c) from [<bf054120>] (mxs_mmc_enable_sdio_irq+0x18/0xdc [mxs_mmc])
[   65.470000] [<bf054120>] (mxs_mmc_enable_sdio_irq+0x18/0xdc [mxs_mmc]) from [<bf0541d0>] (mxs_mmc_enable_sdio_irq+0xc8/0xdc [mxs_mmc])
[   65.470000] [<bf0541d0>] (mxs_mmc_enable_sdio_irq+0xc8/0xdc [mxs_mmc]) from [<c0219b38>] (sdio_irq_thread+0x1bc/0x274)
[   65.470000] [<c0219b38>] (sdio_irq_thread+0x1bc/0x274) from [<c003c324>] (kthread+0x8c/0x98)
[   65.470000] [<c003c324>] (kthread+0x8c/0x98) from [<c00101ac>] (kernel_thread_exit+0x0/0x8)
[   65.470000] BUG: spinlock lockup suspected on CPU#0, ksdioirqd/mmc0/73
[   65.470000]  lock: 0xc3358724, .magic: dead4ead, .owner: ksdioirqd/mmc0/73, .owner_cpu: 0
[   65.470000] [<c0014990>] (unwind_backtrace+0x0/0xf4) from [<c01b46b0>] (do_raw_spin_lock+0x100/0x144)
[   65.470000] [<c01b46b0>] (do_raw_spin_lock+0x100/0x144) from [<c02f6724>] (_raw_spin_lock_irqsave+0x50/0x5c)
[   65.470000] [<c02f6724>] (_raw_spin_lock_irqsave+0x50/0x5c) from [<bf054120>] (mxs_mmc_enable_sdio_irq+0x18/0xdc [mxs_mmc])
[   65.470000] [<bf054120>] (mxs_mmc_enable_sdio_irq+0x18/0xdc [mxs_mmc]) from [<bf0541d0>] (mxs_mmc_enable_sdio_irq+0xc8/0xdc [mxs_mmc])
[   65.470000] [<bf0541d0>] (mxs_mmc_enable_sdio_irq+0xc8/0xdc [mxs_mmc]) from [<c0219b38>] (sdio_irq_thread+0x1bc/0x274)
[   65.470000] [<c0219b38>] (sdio_irq_thread+0x1bc/0x274) from [<c003c324>] (kthread+0x8c/0x98)
[   65.470000] [<c003c324>] (kthread+0x8c/0x98) from [<c00101ac>] (kernel_thread_exit+0x0/0x8)

Reported-by: Attila Kinali <attila@kinali.ch>
Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/mxs-mmc.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 20a0550..e1fd2c8 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -637,11 +637,6 @@ static void mxs_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 		       host->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
 		writel(BM_SSP_CTRL1_SDIO_IRQ_EN,
 		       host->base + HW_SSP_CTRL1(host) + STMP_OFFSET_REG_SET);
-
-		if (readl(host->base + HW_SSP_STATUS(host)) &
-				BM_SSP_STATUS_SDIO_IRQ)
-			mmc_signal_sdio_irq(host->mmc);
-
 	} else {
 		writel(BM_SSP_CTRL0_SDIO_IRQ_CHECK,
 		       host->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
@@ -650,6 +645,11 @@ static void mxs_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	}
 
 	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (enable && readl(host->base + HW_SSP_STATUS(host)) &
+			BM_SSP_STATUS_SDIO_IRQ)
+		mmc_signal_sdio_irq(host->mmc);
+
 }
 
 static const struct mmc_host_ops mxs_mmc_ops = {
-- 
1.7.9.5

