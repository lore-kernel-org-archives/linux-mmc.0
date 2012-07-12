From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: mmc: mxs: DEADLOCK
Date: Thu, 12 Jul 2012 22:39:53 +0800
Message-ID: <20120712143950.GA16343@S2101-09.ap.freescale.net>
References: <4FFC367A.8020100@bluegiga.com>
 <20120711060607.GE14060@S2101-09.ap.freescale.net>
 <20120712160008.03731746cdc5cf4bb0548256@kinali.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:35693
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932530Ab2GLOj1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jul 2012 10:39:27 -0400
Content-Disposition: inline
In-Reply-To: <20120712160008.03731746cdc5cf4bb0548256@kinali.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Attila Kinali <attila@kinali.ch>
Cc: Lauri Hintsala <lauri.hintsala@bluegiga.com>, Marek Vasut <marex@denx.de>, Koen Beel <koen.beel@barco.com>, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Jul 12, 2012 at 04:00:08PM +0200, Attila Kinali wrote:
> On Wed, 11 Jul 2012 14:06:09 +0800
> Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> 
> > > I found a way to fix this issue:
> > > 
> > > --- a/drivers/mmc/host/mxs-mmc.c
> > > +++ b/drivers/mmc/host/mxs-mmc.c
> > > @@ -278,11 +278,11 @@ static irqreturn_t mxs_mmc_irq_handler(int
> > > irq, void *dev_id)
> > >  	writel(stat & MXS_MMC_IRQ_BITS,
> > >  	       host->base + HW_SSP_CTRL1(host) + STMP_OFFSET_REG_CLR);
> > > 
> > > +	spin_unlock(&host->lock);
> > > +
> > >  	if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
> > >  		mmc_signal_sdio_irq(host->mmc);
> > > 
> > > -	spin_unlock(&host->lock);
> > > -
> > >  	if (stat & BM_SSP_CTRL1_RESP_TIMEOUT_IRQ)
> > >  		cmd->error = -ETIMEDOUT;
> > >  	else if (stat & BM_SSP_CTRL1_RESP_ERR_IRQ)
> > > 
> > > 
> > > Is there any reason to keep mmc_signal_sdio_irq inside the spinlock?
> > > mmc_signal_sdio_irq calls mxs_mmc_enable_sdio_irq and it tries to
> > > acquire lock while it is already acquired.
> > > 
> > The fix looks right to me.  You can have my ack when you send a patch
> > for it.
> > 
> > Acked-by: Shawn Guo <shawn.guo@linaro.org>
> 
> I ran into the same problem today, but the proposed fix doesn't seem
> to work for me:
> 
It's a different problem from what Lauri reported and fixed.  I haven't
played SDIO card that much, so I'm not completely clear about the SDIO
calling sequence, but is it reasonable that mxs_mmc_enable_sdio_irq is
being called recursively?

Regards,
Shawn

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
> 
> 			Attila Kinali
> 
> -- 
> It is upon moral qualities that a society is ultimately founded. All 
> the prosperity and technological sophistication in the world is of no 
> use without that foundation.
>                  -- Miss Matheson, The Diamond Age, Neil Stephenson

