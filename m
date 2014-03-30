From: Andreas Fenkart <afenkart@gmail.com>
Subject: Re: [PATCH 6/9] mmc: omap_hsmmc: Enable SDIO interrupt
Date: Mon, 31 Mar 2014 00:43:49 +0200
Message-ID: <CALtMJEBV2rm=QBLrJgymcpO-fD_rPBUUBbq1w5MrUqAbzXEGhQ@mail.gmail.com>
References: <1395404448-30030-2-git-send-email-afenkart@gmail.com>
	<1395418658-2375-1-git-send-email-balajitk@ti.com>
	<1395418658-2375-7-git-send-email-balajitk@ti.com>
	<CAPDyKFqzDS0CX60BVcFx1+kJR840qkyEU6CtATkZSEd8F2z26w@mail.gmail.com>
	<CALtMJECaQrGhMmJjK+tvce3iSEGMUx==pOmMECU-smy=0fyZ3Q@mail.gmail.com>
	<CAPDyKFqy-W5tiBirWUdkq3vHVpjeQ8Hr4KdP34X9CW7_c9Zuaw@mail.gmail.com>
	<CALtMJECAPzvyWKUZ7qo-6Wo8LvB0QRps777mh7CNZ3JktGSFjw@mail.gmail.com>
	<CAPDyKFq-w_0cPYDNK2qVxfHZXp4y-4iBskvvtGrzgaMhj0RB0Q@mail.gmail.com>
	<53319E88.1060405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <53319E88.1060405@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Sorry missed your previous mail

2014-03-25 16:19 GMT+01:00 Balaji T K <balajitk@ti.com>:
>>>
>>>>>>
>>>>>> This seems wrong to me.
>>>>>>
>>>>>> What if the host is suspended (runtime PM wise) and you want to
>>>>>> disable SDIO irq.
>>>>>> Won't SDIO irq be kept enabled in this case?
>
>
> First of all, In runtime suspended state is a corner case where sdio-irq
> got triggered while .runtime_suspend hook was getting executed
> in multi-processor system.

Just to make sure I got you right

2 cores,

1. device was idle for xx ms, transition to runtime suspend
   initiated, host spinlock is aquired
2. meanwhile an sdio-irq is detected but not yet served
3. 2nd core starts process mmc irq, decodes it as an sdio_irq, but
   not yet processed due to spinlock held by runtime_suspend
4. device irqs are masked, clocks are gated, no more register
   access possible, spinlock is released
5. sdio irq gets handled, and register access in
   omap_hsmmc_enable_sdio_irq fails with SIGBUS


- Sdio irq is not a dedicated irq line, but is encoded in irqstat. So yoiu need
  to read irqstat to know it's an sdio_irq. This is racy as well
- pm_runtime_suspend clears the IRQSTAT register, so the vulnerable
  window is very small.

The single core situation, I think:
1. Runtime_suspend holds the spinock irqsave so irqstat is not
    fetched early by the irq handler
2. irqstat is cleared by pm_runtime_suspend
3. after pm_runtime hook is complete, a pending the irq is handled
   delaying the gating of the clocks, so irqstat is read safely
4 there is never an sdio_irq after pm_suspend ran

In the multi-core case runtime_suspend / irq handler can run in parallel
- irqstat is read without spinlock, so it probably happen before
  gating the clocks
-- if irqstat happens to be already cleared, nothing happens
-- if sdio_irq shall be handled, a spin_lock is taken, which is held by
   runtime_suspend, clocks are probably gated soon after releasing it.

Your solution will probably work, but relying on reading irqstat before
clocks are gated is not really kosher, I think we should abort
runtime_suspend if irqstat is non-nulll and/or indicates an sdio_irq.

multi-core... N#r%gl
