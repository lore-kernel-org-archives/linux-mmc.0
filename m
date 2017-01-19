From: Andrea Merello <andrea.merello@gmail.com>
Subject: Re: [PATCH v3 1/9] mmc: mmci: don't pretend IP variants with only one
 IRQ to have two mask regs
Date: Thu, 19 Jan 2017 18:53:45 +0100
Message-ID: <CAN8YU5P0DdsWwba0wthwqyA7E7qKA+HrqCgO715pA7HxyjCE9g@mail.gmail.com>
References: <1484552238-23171-1-git-send-email-andrea.merello@gmail.com>
 <1484552238-23171-2-git-send-email-andrea.merello@gmail.com> <CAPDyKFozzCGjyxSDv7ZPVZVsD8iMseF9aMUNT1yqOiuFEx7uiQ@mail.gmail.com>
Reply-To: andrea.merello@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34705 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753966AbdASS0n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2017 13:26:43 -0500
Received: by mail-yw0-f193.google.com with SMTP id v73so5488806ywg.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2017 10:26:43 -0800 (PST)
In-Reply-To: <CAPDyKFozzCGjyxSDv7ZPVZVsD8iMseF9aMUNT1yqOiuFEx7uiQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Bruno Herrera <bruherrera@gmail.com>

On Thu, Jan 19, 2017 at 5:44 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 16 January 2017 at 08:37, Andrea Merello <andrea.merello@gmail.com> wrote:
>> Currently the driver supports both devices with one and two IRQ lines.
>>
>> Two mask registers are used in order to select which events have to
>> actually generate an interrupt on each IRQ line.
>>
>> It seems that in the single-IRQ case it's assumed that the IRQs lines
>> are simply OR-ed, while the two mask registers are still present. The
>> driver still programs the two mask registers separately.
>>
>> However the STM32 variant has only one IRQ, and also has only one mask
>> register.
>>
>> This patch prepares for STM32 variant support by making the driver using
>> only one mask register when only one IRQ is available.
>
> The approach as such seems okay to try out!
>
> However, I think a minor re-work is needed, but in the end achieving
> the same goal. Some more comments below.
>
>>
>> Tested only on STM32 variant. RFT for variants other than STM32
>>
>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>> ---
>>  drivers/mmc/host/mmci.c | 17 ++++++++---------
>>  1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 01a8047..597fab8 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -404,9 +404,9 @@ static void mmci_set_mask1(struct mmci_host *host, unsigned int mask)
>>                 mask0 |= mask;
>>
>>                 writel(mask0, base + MMCIMASK0);
>> +       } else {
>> +               writel(mask, base + MMCIMASK1);
>>         }
>> -
>> -       writel(mask, base + MMCIMASK1);
>>  }
>>
>>  static void mmci_stop_data(struct mmci_host *host)
>> @@ -1274,12 +1274,10 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>>
>>         do {
>>                 status = readl(host->base + MMCISTATUS);
>> +               status &= readl(host->base + MMCIMASK0);
>>                 if (host->singleirq) {
>> -                       if (status & readl(host->base + MMCIMASK1))
>> -                               mmci_pio_irq(irq, dev_id);
>
> We want to enter mmci_pio_irq(), *only* when some of those bits are
> set, which we have written to in MMCIMASK1.
>
> This changes this behaviour, which I don't think is a good idea!

The idea is that when we have host->singleirq we write all the bits we
need only in MMCIMASK0, so there would be no point in looking at
MMCIMASK1.

>
>> -
>> -                       status &= ~MCI_IRQ1MASK;
>> +                       mmci_pio_irq(irq, dev_id);
>>                 }
>>
>>                 /*
>> @@ -1287,7 +1285,6 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>>                  * enabled) since the HW seems to be triggering the IRQ on both
>>                  * edges while monitoring DAT0 for busy completion.
>>                  */
>> -               status &= readl(host->base + MMCIMASK0);
>>                 writel(status, host->base + MMCICLEAR);
>>
>>                 dev_dbg(mmc_dev(host->mmc), "irq0 (data+cmd) %08x\n", status);
>> @@ -1710,7 +1707,8 @@ static int mmci_probe(struct amba_device *dev,
>>         spin_lock_init(&host->lock);
>>
>>         writel(0, host->base + MMCIMASK0);
>> -       writel(0, host->base + MMCIMASK1);
>> +       if (!host->singleirq)
>> +               writel(0, host->base + MMCIMASK1);
>
> No, this is wrong.
>
> In the case when we use only a single IRQ, we also need to clear
> MMCIMASK1, as to make sure it don't contains some "garbage" and thus
> triggers spurious IRQs.

You are right here. However the whole point of this patch is to avoid
writing/reading MMCMASK1 reg in variants that does not have this reg
at all. It looks like we need another flag like host->singlemask to
skip this writes in this case.

>>         writel(0xfff, host->base + MMCICLEAR);
>>
>>         /*
>> @@ -1800,7 +1798,8 @@ static int mmci_remove(struct amba_device *dev)
>>                 mmc_remove_host(mmc);
>>
>>                 writel(0, host->base + MMCIMASK0);
>> -               writel(0, host->base + MMCIMASK1);
>> +               if (!host->singleirq)
>> +                       writel(0, host->base + MMCIMASK1);
>
> Ditto.
>
>>
>>                 writel(0, host->base + MMCICOMMAND);
>>                 writel(0, host->base + MMCIDATACTRL);
>> --
>> 2.7.4
>>
>
> Overall, by looking at this change I think an alternative approach
> would be start with some clean-up/micro-optimizations for how the
> driver deals with the MMCIMASK1 and MMCIMASK0.
>
> More precisely, add two new variables in the mmci host struct, used
> for containg a cache of these two registers. The cache needs to be
> updated when new values are written, but more importantly, we don't
> need to go and read the corresponding registers to know their content,
> when masking/unmasking bits. Instead we can use the cache, which is
> more optimal.

This seems a good idea in general; it would be a slight improvement
for the MMCI driver in general, however it seems to me quite unrelated
to the point of this patch..

> Following patches, similar to what you suggested in $subject patch,
> can then make use of the cached values. Depending on whether
> "singleirq" is set or not, the cached values can be used to write the
> correct mask(s).
>
> Kind regards
> Uffe
