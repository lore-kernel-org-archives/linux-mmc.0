From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: Convert to use MMC_CAP2_SDIO_IRQ_NOTHREAD
 for SDIO IRQs
Date: Wed, 19 Apr 2017 14:10:23 +0200
Message-ID: <CAPDyKFr46c8E3EPxfDp7vKqfs+V1p7z6BZnLnOQFrE9eaSxKKQ@mail.gmail.com>
References: <1492518724-30511-1-git-send-email-ulf.hansson@linaro.org>
 <1492518724-30511-3-git-send-email-ulf.hansson@linaro.org> <CAD=FV=UDirBw=mDhw1Px60mUN68zhFYqV08mr5Gs2ZMsLC8j6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:35148 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762847AbdDSMKZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Apr 2017 08:10:25 -0400
Received: by mail-ua0-f169.google.com with SMTP id f10so13821383uaa.2
        for <linux-mmc@vger.kernel.org>; Wed, 19 Apr 2017 05:10:25 -0700 (PDT)
In-Reply-To: <CAD=FV=UDirBw=mDhw1Px60mUN68zhFYqV08mr5Gs2ZMsLC8j6w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@google.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Brian Norris <briannorris@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 18 April 2017 at 23:25, Doug Anderson <dianders@google.com> wrote:
> Hi,
>
> On Tue, Apr 18, 2017 at 5:32 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Convert to use the more lightweight method for processing SDIO IRQs, which
>> involves the following changes:
>>
>> - Enable MMC_CAP2_SDIO_IRQ_NOTHREAD when SDIO IRQ is supported.
>> - Mask SDIO IRQ when signaling it for processing.
>> - Re-enable (unmask) the SDIO IRQ from the ->ack_sdio_irq() callback.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/mmc/host/dw_mmc.c | 29 ++++++++++++++++++++++++++---
>>  1 file changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 249ded6..f086791 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1635,9 +1635,8 @@ static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card *card)
>>         }
>>  }
>>
>> -static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
>> +static void __dw_mci_enable_sdio_irq(struct dw_mci_slot *slot, int enb)
>>  {
>> -       struct dw_mci_slot *slot = mmc_priv(mmc);
>>         struct dw_mci *host = slot->host;
>>         unsigned long irqflags;
>>         u32 int_mask;
>> @@ -1655,6 +1654,20 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
>>         spin_unlock_irqrestore(&host->irq_lock, irqflags);
>>  }
>>
>> +static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
>> +{
>> +       struct dw_mci_slot *slot = mmc_priv(mmc);
>> +
>> +       __dw_mci_enable_sdio_irq(slot, enb);
>> +}
>> +
>> +static void dw_mci_ack_sdio_irq(struct mmc_host *mmc)
>> +{
>> +       struct dw_mci_slot *slot = mmc_priv(mmc);
>> +
>> +       __dw_mci_enable_sdio_irq(slot, 1);
>
> I have some slight paranoia that some code out there might decide to
> call enable_sdio_irq(0) while an interrupt is being processed.  In
> that case we'll be turning interrupts back on here.  It seems like it
> would be "better safe than sorry" to keep track of the "enabled /
> disabled" state somewhere.  ...and when we "unmask" we treat it as a
> no-op if the interrupt is currently disabled.

I understand your concern and your paranoia, which probably relates to
the current tricky code that involves running our own kthread in
sdio_irq_thread(). :-)

For example, the sdio_irq_thread() need to release the host,
mmc_release_host(), before it invokes ->enable_sdio_irq(), which is
after it has processed the SDIO IRQs. This is actually wrong, as host
drivers expects the host to be claimed when any of the host ops
callbacks are being invoked, particularly from runtime PM point of
view.

Anyway, the current code *seems* to work - but for sure it's fragile
and it has been so for too long.

That said, you have a point about keeping track of the enabled/disable
state. However, by digging a bit deeper into this, I realized the
problem is actually even worse. Let me explain a bit more:

->ack_sdio_irq() is *only* called from the work that processes the
SDIO IRQ. The difference compared to kthread is that the host is being
claimed throughout the entire process when using the work, which by
itself is an improvement. This also means, that the only reason to why
->enable_sdio_irq(0) can be called, is because an SDIO func driver
decides to release the SDIO IRQ. However, for it to do that, it must
first claim the host.

This leads us to two scenarios:
1) The work manages to claim the host before the SDIO func driver.
Then everything should be fine, simply because the work processes and
acks the IRQ, before the SDIO func driver gets permission to release
it.

2) The SDIO func driver gets to claim the host before the work. That
means it releases the IRQ before the work gets permission to run and
process the IRQ. This means we are into trouble. Not only as you say,
->enable_sdio_irq(0) becomes called before ->ack_sdio_irq(), but the
actual processing of the IRQ, mmc_io_rw_direct() etc, becomes executed
when it shouldn't.

So, to fix the problems, I think a better solution than keeping track
of the enabled/disabled state, is to actually prevent the IRQ from
being processed in scenario 2. Including to prevent invoking
->ack_sdio_irq() from the work.

Allow me to cook a separate patch for this, because I think this is
already an existing problem when using MMC_CAP2_SDIO_IRQ_NOTHREAD.

>
>> +}
>> +
>>  static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>  {
>>         struct dw_mci_slot *slot = mmc_priv(mmc);
>> @@ -1756,6 +1769,7 @@ static const struct mmc_host_ops dw_mci_ops = {
>>         .get_cd                 = dw_mci_get_cd,
>>         .hw_reset               = dw_mci_hw_reset,
>>         .enable_sdio_irq        = dw_mci_enable_sdio_irq,
>> +       .ack_sdio_irq           = dw_mci_ack_sdio_irq,
>>         .execute_tuning         = dw_mci_execute_tuning,
>>         .card_busy              = dw_mci_card_busy,
>>         .start_signal_voltage_switch = dw_mci_switch_voltage,
>> @@ -2645,9 +2659,14 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>>                                 continue;
>>
>>                         if (pending & SDMMC_INT_SDIO(slot->sdio_id)) {
>> +                               u32 int_mask;
>> +
>>                                 mci_writel(host, RINTSTS,
>>                                            SDMMC_INT_SDIO(slot->sdio_id));
>> -                               mmc_signal_sdio_irq(slot->mmc);
>> +                               int_mask = mci_readl(host, INTMASK);
>> +                               int_mask &= ~SDMMC_INT_SDIO(slot->sdio_id);
>> +                               mci_writel(host, INTMASK, int_mask);
>
> Seems like you should be calling "__dw_mci_enable_sdio_irq(slot, 0)"
> here.  Specifically the interrupt handler won't have the spinlock so
> you're doing an unsafe read/modify/write here.  Yeah, the spinlock is
> kinda silly in dw_mmc.  Really the whole interrupt handling needs to
> be re-done to use a threaded IRQ instead of the current solution...

Thanks, this make sense! New version on its way.

>
>> +                               sdio_signal_irq(slot->mmc);
>>                         }
>>                 }
>>
>> @@ -2748,6 +2767,10 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>         if (ret)
>>                 goto err_host_allocated;
>>
>> +       /* Process SDIO IRQs through the sdio_irq_work. */
>> +       if (mmc->caps & MMC_CAP_SDIO_IRQ)
>> +               mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
>> +
>>         /* Useful defaults if platform data is unset. */
>>         if (host->use_dma == TRANS_MODE_IDMAC) {
>>                 mmc->max_segs = host->ring_size;
>> --
>> 2.7.4
>>

Kind regards
Uffe
