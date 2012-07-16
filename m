From: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Subject: Re: mmc: mxs: DEADLOCK
Date: Mon, 16 Jul 2012 08:57:38 +0300
Message-ID: <5003AD52.7070304@bluegiga.com>
References: <4FFC367A.8020100@bluegiga.com> <20120711060607.GE14060@S2101-09.ap.freescale.net> <20120712160008.03731746cdc5cf4bb0548256@kinali.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bluegiga.fi ([194.100.31.45]:22044 "EHLO darkblue.bluegiga.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769Ab2GPF5q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 16 Jul 2012 01:57:46 -0400
In-Reply-To: <20120712160008.03731746cdc5cf4bb0548256@kinali.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Attila Kinali <attila@kinali.ch>
Cc: Shawn Guo <shawn.guo@linaro.org>, Marek Vasut <marex@denx.de>, Koen Beel <koen.beel@barco.com>, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Attila,

On 07/12/2012 05:00 PM, Attila Kinali wrote:
> I ran into the same problem today, but the proposed fix doesn't seem
> to work for me:
>
> ---schnipp---
> # modprobe libertas_sdio
> [   59.200000] lib80211: common routines for IEEE802.11 drivers
> [   59.240000] cfg80211: Calling CRDA to update world regulatory domain
> [   59.320000] libertas_sdio: Libertas SDIO driver
> [   59.330000] libertas_sdio: Copyright Pierre Ossman
> # modprobe mxs-mmc
> [   64.210000] mxs-mmc 80010000.ssp: initialized
> [   64.260000] mxs-mmc 80034000.ssp: initialized
> [   64.270000] mmc0: new SDIO card at address 0001
> # [   65.440000] libertas_sdio mmc0:0001:1: (unregistered net_device): 00:13:04:80:00:3f, fw 9.70.3p24, cap 0x00000303
> [   65.470000]
> [   65.470000] =============================================
> [   65.470000] [ INFO: possible recursive locking detected ]
> [   65.470000] 3.5.0-rc5 #2 Not tainted
> [   65.470000] ---------------------------------------------
> [   65.470000] ksdioirqd/mmc0/73 is trying to acquire lock:
> [   65.470000]  (&(&host->lock)->rlock#2){-.-...}, at: [<bf054120>] mxs_mmc_enable_sdio_irq+0x18/0xdc [mxs_mmc]
> [   65.470000]
> [   65.470000] but task is already holding lock:
> [   65.470000]  (&(&host->lock)->rlock#2){-.-...}, at: [<bf054120>] mxs_mmc_enable_sdio_irq+0x18/0xdc [mxs_mmc]
> [   65.470000]
> [   65.470000] other info that might help us debug this:
> [   65.470000]  Possible unsafe locking scenario:
> [   65.470000]
> [   65.470000]        CPU0
> [   65.470000]        ----
> [   65.470000]   lock(&(&host->lock)->rlock#2);
> [   65.470000]   lock(&(&host->lock)->rlock#2);
> [   65.470000]
> [   65.470000]  *** DEADLOCK ***
> [   65.470000]
> [   65.470000]  May be due to missing lock nesting notation
> [   65.470000]
> [   65.470000] 1 lock held by ksdioirqd/mmc0/73:
> [   65.470000]  #0:  (&(&host->lock)->rlock#2){-.-...}, at: [<bf054120>] mxs_mmc_enable_sdio_irq+0x18/0xdc [mxs_mmc]
> [   65.470000]
> [   65.470000] stack backtrace:
> [   65.470000] [<c0014990>] (unwind_backtrace+0x0/0xf4) from [<c005ccb8>] (__lock_acquire+0x14f8/0x1b98)
> [   65.470000] [<c005ccb8>] (__lock_acquire+0x14f8/0x1b98) from [<c005d3f8>] (lock_acquire+0xa0/0x108)
> [   65.470000] [<c005d3f8>] (lock_acquire+0xa0/0x108) from [<c02f671c>] (_raw_spin_lock_irqsave+0x48/0x5c)
> [   65.470000] [<c02f671c>] (_raw_spin_lock_irqsave+0x48/0x5c) from [<bf054120>] (mxs_mmc_enable_sdio_irq+0x18/0xdc [mxs_mmc])
> [   65.470000] [<bf054120>] (mxs_mmc_enable_sdio_irq+0x18/0xdc [mxs_mmc]) from [<bf0541d0>] (mxs_mmc_enable_sdio_irq+0xc8/0xdc [mxs_mmc])
> [   65.470000] [<bf0541d0>] (mxs_mmc_enable_sdio_irq+0xc8/0xdc [mxs_mmc]) from [<c0219b38>] (sdio_irq_thread+0x1bc/0x274)
> [   65.470000] [<c0219b38>] (sdio_irq_thread+0x1bc/0x274) from [<c003c324>] (kthread+0x8c/0x98)
> [   65.470000] [<c003c324>] (kthread+0x8c/0x98) from [<c00101ac>] (kernel_thread_exit+0x0/0x8)
> [   65.470000] BUG: spinlock lockup suspected on CPU#0, ksdioirqd/mmc0/73
> [   65.470000]  lock: 0xc3358724, .magic: dead4ead, .owner: ksdioirqd/mmc0/73, .owner_cpu: 0
> [   65.470000] [<c0014990>] (unwind_backtrace+0x0/0xf4) from [<c01b46b0>] (do_raw_spin_lock+0x100/0x144)
> [   65.470000] [<c01b46b0>] (do_raw_spin_lock+0x100/0x144) from [<c02f6724>] (_raw_spin_lock_irqsave+0x50/0x5c)
> [   65.470000] [<c02f6724>] (_raw_spin_lock_irqsave+0x50/0x5c) from [<bf054120>] (mxs_mmc_enable_sdio_irq+0x18/0xdc [mxs_mmc])
> [   65.470000] [<bf054120>] (mxs_mmc_enable_sdio_irq+0x18/0xdc [mxs_mmc]) from [<bf0541d0>] (mxs_mmc_enable_sdio_irq+0xc8/0xdc [mxs_mmc])
> [   65.470000] [<bf0541d0>] (mxs_mmc_enable_sdio_irq+0xc8/0xdc [mxs_mmc]) from [<c0219b38>] (sdio_irq_thread+0x1bc/0x274)
> [   65.470000] [<c0219b38>] (sdio_irq_thread+0x1bc/0x274) from [<c003c324>] (kthread+0x8c/0x98)
> [   65.470000] [<c003c324>] (kthread+0x8c/0x98) from [<c00101ac>] (kernel_thread_exit+0x0/0x8)
> ---schnapp---
>
> Any hints how to work around or fix this, would be appreciated


Does this patch fix your issue?

 >>>>>>>
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -637,11 +637,6 @@ static void mxs_mmc_enable_sdio_irq(struct mmc_host 
*mmc, int enable)
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
@@ -650,6 +645,11 @@ static void mxs_mmc_enable_sdio_irq(struct mmc_host 
*mmc, int enable)
  	}

  	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (enable && readl(host->base + HW_SSP_STATUS(host)) &
+			BM_SSP_STATUS_SDIO_IRQ)
+		mmc_signal_sdio_irq(host->mmc);
+
  }

  static const struct mmc_host_ops mxs_mmc_ops = {
<<<<<<<

mxs_mmc_enable_sdio_irq was called by mmc_signal_sdio_irq. 
mmc_signal_sdio_irq was called inside spin lock. So the lock was tried 
to acquire before it was released.


Best regards,
Lauri Hintsala
