From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/3] mmc: omap_hsmmc: Pin remux workaround to support
 SDIO interrupt on AM335x.
Date: Tue, 19 Nov 2013 16:09:48 +0100
Message-ID: <CAPDyKFowQACfpZb3LMH1Dvryx7jCGR9hYb32ycf=u0Um2YRf6Q@mail.gmail.com>
References: <1384761240-11005-1-git-send-email-afenkart@gmail.com>
	<1384761240-11005-3-git-send-email-afenkart@gmail.com>
	<CAPDyKFrTm3BB3o=445FjigB1nVuKukwa6FtunPqtzFR2BihhRg@mail.gmail.com>
	<CALtMJEB4RRHdc9HYqdCf=YonbpADrj5_MiWJgE1rxK_t5O8nsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:37746 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421Ab3KSPJt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Nov 2013 10:09:49 -0500
Received: by mail-qc0-f178.google.com with SMTP id i7so4916487qcq.9
        for <linux-mmc@vger.kernel.org>; Tue, 19 Nov 2013 07:09:49 -0800 (PST)
In-Reply-To: <CALtMJEB4RRHdc9HYqdCf=YonbpADrj5_MiWJgE1rxK_t5O8nsA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Daniel Mack <zonque@gmail.com>, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>

On 19 November 2013 14:37, Andreas Fenkart <afenkart@gmail.com> wrote:
> Hi Ulf,
>
> 2013/11/19 Ulf Hansson <ulf.hansson@linaro.org>:
>> On 18 November 2013 08:53, Andreas Fenkart <afenkart@gmail.com> wrote:
>
>>>
>>> +static irqreturn_t omap_hsmmc_cirq(int irq, void *dev_id)
>>> +{
>>> +       struct omap_hsmmc_host *host = dev_id;
>>> +       unsigned long flags;
>>> +
>>> +       spin_lock_irqsave(&host->irq_lock, flags);
>>> +       if (host->flags & HSMMC_CIRQ_GPIO_ENABLED) {
>>> +               disable_irq_nosync(mmc_slot(host).sdio_irq);
>>> +               host->flags &= ~HSMMC_CIRQ_GPIO_ENABLED;
>>> +       }
>>> +       spin_unlock_irqrestore(&host->irq_lock, flags);
>>> +
>>> +       pm_request_resume(host->dev); /* no use counter */
>>
>> In the case were you are not waking up from system suspend, but from
>> runtime suspend, you likely want to signal the SDIO irq as soon as
>> possible. Then you should use mmc_signal_sdio_irq instead.
>
> That was my intention first as well, and previous patches worked that way.
> SDIO IRQ while in pm_suspend is a rare event, compard to SDIO irq
> while in pm_active state.
>
> cat /proc/interrupts
>            CPU0
>  80:      68349      INTC  64  mmc0
> 236:       4352      GPIO  28  mmc0
>
> Here the Wifi module is just connected, not being pinged or iperf
> running. So the benefit will not be as big as you imagine.

You are right.

>
> On the other side the optimisations is not without problems, while in
> pm_suspend the functional clock is off and you must not access the
> registers of the module.
>
> But this is exactly whapt happens when you call mmc_signal_sdio_irq,
> it will call back into the drivers omap_hsmmc_enable_sdio_irq trying to
> disable the SDIO irq. So you must add special state machines there.

Yes, it will be somewhat complicated - I guess.

>
> After all it's doable but error prone, and I consider not worth the troubles
> for no noticeable speedup.
>
> Also have a look here, Balaji T K had a similar remark to yours
> http://www.spinics.net/lists/linux-omap/msg99832.html

Thanks, I should have looked that first. :-)

Kind regards
Ulf Hansson

>
>>
>> In the other case, when waking up from system suspend, you should be
>> able to completely rely on that the mmc_sdio_resume from the core
>> layer, will handle the IRQ.
>>
>> Kind regards
>> Ulf Hansson
>>
