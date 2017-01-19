From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/9] mmc: mmci: don't pretend IP variants with only one
 IRQ to have two mask regs
Date: Thu, 19 Jan 2017 21:29:07 +0100
Message-ID: <CAPDyKFqmnvbTU6y8m_9wjqkasQX8z0CrvhGjR0ebkB9ZtpMb5A@mail.gmail.com>
References: <1484552238-23171-1-git-send-email-andrea.merello@gmail.com>
 <1484552238-23171-2-git-send-email-andrea.merello@gmail.com>
 <CAPDyKFozzCGjyxSDv7ZPVZVsD8iMseF9aMUNT1yqOiuFEx7uiQ@mail.gmail.com> <CAN8YU5P0DdsWwba0wthwqyA7E7qKA+HrqCgO715pA7HxyjCE9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38168 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdASUgt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2017 15:36:49 -0500
Received: by mail-wm0-f48.google.com with SMTP id r144so11931195wme.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2017 12:36:49 -0800 (PST)
In-Reply-To: <CAN8YU5P0DdsWwba0wthwqyA7E7qKA+HrqCgO715pA7HxyjCE9g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrea Merello <andrea.merello@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Bruno Herrera <bruherrera@gmail.com>

[...]

>>> @@ -1274,12 +1274,10 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>>>
>>>         do {
>>>                 status = readl(host->base + MMCISTATUS);
>>> +               status &= readl(host->base + MMCIMASK0);
>>>                 if (host->singleirq) {
>>> -                       if (status & readl(host->base + MMCIMASK1))
>>> -                               mmci_pio_irq(irq, dev_id);
>>
>> We want to enter mmci_pio_irq(), *only* when some of those bits are
>> set, which we have written to in MMCIMASK1.
>>
>> This changes this behaviour, which I don't think is a good idea!
>
> The idea is that when we have host->singleirq we write all the bits we
> need only in MMCIMASK0, so there would be no point in looking at
> MMCIMASK1.

Right, I agree that is the next step to take.

However, we also don't want to invoke mmci_pio_irq() unless we got
some of the pio IRQs. The current method to do that is reading the
MMCIMASK1.

I do understand that doesn't work for your new variant, and perhaps
caching the registers could help to avoid that. Typically you could
just check against a "host->mask1_reg" variable, but having to
actually read the register.

>
>>
>>> -
>>> -                       status &= ~MCI_IRQ1MASK;
>>> +                       mmci_pio_irq(irq, dev_id);
>>>                 }
>>>
>>>                 /*
>>> @@ -1287,7 +1285,6 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>>>                  * enabled) since the HW seems to be triggering the IRQ on both
>>>                  * edges while monitoring DAT0 for busy completion.
>>>                  */
>>> -               status &= readl(host->base + MMCIMASK0);
>>>                 writel(status, host->base + MMCICLEAR);
>>>
>>>                 dev_dbg(mmc_dev(host->mmc), "irq0 (data+cmd) %08x\n", status);
>>> @@ -1710,7 +1707,8 @@ static int mmci_probe(struct amba_device *dev,
>>>         spin_lock_init(&host->lock);
>>>
>>>         writel(0, host->base + MMCIMASK0);
>>> -       writel(0, host->base + MMCIMASK1);
>>> +       if (!host->singleirq)
>>> +               writel(0, host->base + MMCIMASK1);
>>
>> No, this is wrong.
>>
>> In the case when we use only a single IRQ, we also need to clear
>> MMCIMASK1, as to make sure it don't contains some "garbage" and thus
>> triggers spurious IRQs.
>
> You are right here. However the whole point of this patch is to avoid
> writing/reading MMCMASK1 reg in variants that does not have this reg
> at all. It looks like we need another flag like host->singlemask to
> skip this writes in this case.

I understand your point and yes we will need another flag, telling if
the MMCIMASK1 exists or not.

I also like the idea of avoiding to use MMCIMASK1 for cases when it
exists but actually isn't needed. Which is a good first step to take,
in my opinion.

Of course, if you want to skip that step, I am fine with that as well.

>
>>>         writel(0xfff, host->base + MMCICLEAR);
>>>
>>>         /*
>>> @@ -1800,7 +1798,8 @@ static int mmci_remove(struct amba_device *dev)
>>>                 mmc_remove_host(mmc);
>>>
>>>                 writel(0, host->base + MMCIMASK0);
>>> -               writel(0, host->base + MMCIMASK1);
>>> +               if (!host->singleirq)
>>> +                       writel(0, host->base + MMCIMASK1);
>>
>> Ditto.
>>
>>>
>>>                 writel(0, host->base + MMCICOMMAND);
>>>                 writel(0, host->base + MMCIDATACTRL);
>>> --
>>> 2.7.4
>>>
>>
>> Overall, by looking at this change I think an alternative approach
>> would be start with some clean-up/micro-optimizations for how the
>> driver deals with the MMCIMASK1 and MMCIMASK0.
>>
>> More precisely, add two new variables in the mmci host struct, used
>> for containg a cache of these two registers. The cache needs to be
>> updated when new values are written, but more importantly, we don't
>> need to go and read the corresponding registers to know their content,
>> when masking/unmasking bits. Instead we can use the cache, which is
>> more optimal.
>
> This seems a good idea in general; it would be a slight improvement
> for the MMCI driver in general, however it seems to me quite unrelated
> to the point of this patch..

Besides the improvement, I think the code could be quite nice,
especially when we extend it to cover also this new case with a non
existing MMCIMASK1.

Although, it was just a suggestion. So if you can feel adding a
variant flag immediately for a non-existing MMCIMASK1 register and
adopt the code that, I can review such change as well.

Anyway, I can help testing with ux500 v2.

[...]

Kind regards
Uffe
