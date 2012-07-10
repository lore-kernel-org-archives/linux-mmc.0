From: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Subject: mmc: mxs: DEADLOCK
Date: Tue, 10 Jul 2012 17:04:42 +0300
Message-ID: <4FFC367A.8020100@bluegiga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Koen Beel <koen.beel@barco.com>, Marek Vasut <marex@denx.de>
Cc: Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>, linux-mmc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

I was able to get deadlock with CONFIG_DEBUG_SPINLOCK enabled. I added 
also CONFIG_PROVE_LOCKING to get more verbose output. I got following 
error message after SDIO device has been powered.

I'm able to replicate issue with Linux next-20120710. Platform is imx28.

[   79.660000] =============================================
[   79.660000] [ INFO: possible recursive locking detected ]
[   79.660000] 3.4.0-00009-g3e96082-dirty #11 Not tainted
[   79.660000] ---------------------------------------------
[   79.660000] swapper/0 is trying to acquire lock:
[   79.660000]  (&(&host->lock)->rlock#2){-.....}, at: [<c026ea3c>] 
mxs_mmc_enable_sdio_irq+0x18/0xd4
[   79.660000]
[   79.660000] but task is already holding lock:
[   79.660000]  (&(&host->lock)->rlock#2){-.....}, at: [<c026f744>] 
mxs_mmc_irq_handler+0x1c/0xe8
[   79.660000]
[   79.660000] other info that might help us debug this:
[   79.660000]  Possible unsafe locking scenario:
[   79.660000]
[   79.660000]        CPU0
[   79.660000]        ----
[   79.660000]   lock(&(&host->lock)->rlock#2);
[   79.660000]   lock(&(&host->lock)->rlock#2);
[   79.660000]
[   79.660000]  *** DEADLOCK ***
[   79.660000]
[   79.660000]  May be due to missing lock nesting notation
[   79.660000]
[   79.660000] 1 lock held by swapper/0:
[   79.660000]  #0:  (&(&host->lock)->rlock#2){-.....}, at: [<c026f744>] 
mxs_mmc_irq_handler+0x1c/0xe8
[   79.660000]
[   79.660000] stack backtrace:
[   79.660000] [<c0014bd0>] (unwind_backtrace+0x0/0xf4) from 
[<c005f9c0>] (__lock_acquire+0x1948/0x1d48)
[   79.660000] [<c005f9c0>] (__lock_acquire+0x1948/0x1d48) from 
[<c005fea0>] (lock_acquire+0xe0/0xf8)
[   79.660000] [<c005fea0>] (lock_acquire+0xe0/0xf8) from [<c03a8460>] 
(_raw_spin_lock_irqsave+0x44/0x58)
[   79.660000] [<c03a8460>] (_raw_spin_lock_irqsave+0x44/0x58) from 
[<c026ea3c>] (mxs_mmc_enable_sdio_irq+0x18/0xd4)
[   79.660000] [<c026ea3c>] (mxs_mmc_enable_sdio_irq+0x18/0xd4) from 
[<c026f7fc>] (mxs_mmc_irq_handler+0xd4/0xe8)
[   79.660000] [<c026f7fc>] (mxs_mmc_irq_handler+0xd4/0xe8) from 
[<c006bdd8>] (handle_irq_event_percpu+0x70/0x254)
[   79.660000] [<c006bdd8>] (handle_irq_event_percpu+0x70/0x254) from 
[<c006bff8>] (handle_irq_event+0x3c/0x5c)
[   79.660000] [<c006bff8>] (handle_irq_event+0x3c/0x5c) from 
[<c006e6d0>] (handle_level_irq+0x90/0x110)
[   79.660000] [<c006e6d0>] (handle_level_irq+0x90/0x110) from 
[<c006b930>] (generic_handle_irq+0x38/0x50)
[   79.660000] [<c006b930>] (generic_handle_irq+0x38/0x50) from 
[<c00102fc>] (handle_IRQ+0x30/0x84)
[   79.660000] [<c00102fc>] (handle_IRQ+0x30/0x84) from [<c000f058>] 
(__irq_svc+0x38/0x60)
[   79.660000] [<c000f058>] (__irq_svc+0x38/0x60) from [<c0010520>] 
(default_idle+0x2c/0x40)
[   79.660000] [<c0010520>] (default_idle+0x2c/0x40) from [<c0010a90>] 
(cpu_idle+0x64/0xcc)
[   79.660000] [<c0010a90>] (cpu_idle+0x64/0xcc) from [<c04ff858>] 
(start_kernel+0x244/0x2c8)
[   79.660000] BUG: spinlock lockup on CPU#0, swapper/0
[   79.660000]  lock: c398cb2c, .magic: dead4ead, .owner: swapper/0, 
.owner_cpu: 0
[   79.660000] [<c0014bd0>] (unwind_backtrace+0x0/0xf4) from 
[<c01ddb1c>] (do_raw_spin_lock+0xf0/0x144)
[   79.660000] [<c01ddb1c>] (do_raw_spin_lock+0xf0/0x144) from 
[<c03a8468>] (_raw_spin_lock_irqsave+0x4c/0x58)
[   79.660000] [<c03a8468>] (_raw_spin_lock_irqsave+0x4c/0x58) from 
[<c026ea3c>] (mxs_mmc_enable_sdio_irq+0x18/0xd4)
[   79.660000] [<c026ea3c>] (mxs_mmc_enable_sdio_irq+0x18/0xd4) from 
[<c026f7fc>] (mxs_mmc_irq_handler+0xd4/0xe8)
[   79.660000] [<c026f7fc>] (mxs_mmc_irq_handler+0xd4/0xe8) from 
[<c006bdd8>] (handle_irq_event_percpu+0x70/0x254)
[   79.660000] [<c006bdd8>] (handle_irq_event_percpu+0x70/0x254) from 
[<c006bff8>] (handle_irq_event+0x3c/0x5c)
[   79.660000] [<c006bff8>] (handle_irq_event+0x3c/0x5c) from 
[<c006e6d0>] (handle_level_irq+0x90/0x110)
[   79.660000] [<c006e6d0>] (handle_level_irq+0x90/0x110) from 
[<c006b930>] (generic_handle_irq+0x38/0x50)
[   79.660000] [<c006b930>] (generic_handle_irq+0x38/0x50) from 
[<c00102fc>] (handle_IRQ+0x30/0x84)
[   79.660000] [<c00102fc>] (handle_IRQ+0x30/0x84) from [<c000f058>] 
(__irq_svc+0x38/0x60)
[   79.660000] [<c000f058>] (__irq_svc+0x38/0x60) from [<c0010520>] 
(default_idle+0x2c/0x40)
[   79.660000] [<c0010520>] (default_idle+0x2c/0x40) from [<c0010a90>] 
(cpu_idle+0x64/0xcc)
[   79.660000] [<c0010a90>] (cpu_idle+0x64/0xcc) from [<c04ff858>] 
(start_kernel+0x244/0x2c8)


I found a way to fix this issue:

--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -278,11 +278,11 @@ static irqreturn_t mxs_mmc_irq_handler(int irq, 
void *dev_id)
  	writel(stat & MXS_MMC_IRQ_BITS,
  	       host->base + HW_SSP_CTRL1(host) + STMP_OFFSET_REG_CLR);

+	spin_unlock(&host->lock);
+
  	if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
  		mmc_signal_sdio_irq(host->mmc);

-	spin_unlock(&host->lock);
-
  	if (stat & BM_SSP_CTRL1_RESP_TIMEOUT_IRQ)
  		cmd->error = -ETIMEDOUT;
  	else if (stat & BM_SSP_CTRL1_RESP_ERR_IRQ)


Is there any reason to keep mmc_signal_sdio_irq inside the spinlock? 
mmc_signal_sdio_irq calls mxs_mmc_enable_sdio_irq and it tries to 
acquire lock while it is already acquired.


Best regards,
Lauri Hintsala
