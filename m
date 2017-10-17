From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 5/5] mmc: dw_mmc: Cleanup the DTO timer like the CTO one
Date: Mon, 16 Oct 2017 22:05:30 -0700
Message-ID: <CAD=FV=WiYn7GhW=U74pQuyFHbNKa8NFN14ADoZ+ovFFW4+h4AQ@mail.gmail.com>
References: <20171012201118.23570-1-dianders@chromium.org> <20171012201118.23570-6-dianders@chromium.org>
 <48ad69fd-b85a-d9c6-308f-dea72caa70b5@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <48ad69fd-b85a-d9c6-308f-dea72caa70b5@rock-chips.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, Alexandru M Stan <amstan@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Brian Norris <briannorris@chromium.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Oct 16, 2017 at 6:17 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Hi Doug
>
>
> On 2017/10/13 4:11, Douglas Anderson wrote:
>>
>> The recent CTO timer introduced in commit 03de19212ea3 ("mmc: dw_mmc:
>> introduce timer for broken command transfer over scheme") was causing
>> observable problems due to race conditions.  Previous patches have
>> fixed those race conditions.
>>
>> It can be observed that these same race conditions ought to be
>> theoretically possible with the DTO timer too though they are
>> massively less likely to happen because the data timeout is always set
>> to 0xffffff right now.  That means even at a 200 MHz card clock we
>> were arming the DTO timer for 94 ms:
>>    >>> (0xffffff * 1000. / 200000000) + 10
>>    93.886075
>>
>> We always also were setting the DTO timer _after_ starting the
>> transfer, unlike how the old code was seting the CTO timer.
>>
>> In any case, even though the DTO timer is much less likely to have
>> races, it still makes sense to add code to handle it _just in case_.
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>
>> Changes in v2:
>> - Cleanup the DTO timer new for v2
>>
>>   drivers/mmc/host/dw_mmc.c | 54
>> ++++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 51 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 6bc87b1385a9..bc0808615431 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1950,7 +1950,11 @@ static void dw_mci_set_drto(struct dw_mci *host)
>>         /* add a bit spare time */
>>         drto_ms += 10;
>>   -     mod_timer(&host->dto_timer, jiffies + msecs_to_jiffies(drto_ms));
>> +       spin_lock_irqsave(&host->irq_lock, irqflags);
>> +       if (!test_bit(EVENT_DATA_COMPLETE, &host->pending_events))
>> +               mod_timer(&host->dto_timer,
>> +                         jiffies + msecs_to_jiffies(drto_ms));
>> +       spin_unlock_irqrestore(&host->irq_lock, irqflags);
>>   }
>>     static bool dw_mci_clear_pending_cmd_complete(struct dw_mci *host)
>> @@ -1971,6 +1975,18 @@ static bool
>> dw_mci_clear_pending_cmd_complete(struct dw_mci *host)
>>         return true;
>>   }
>>   +static bool dw_mci_clear_pending_data_complete(struct dw_mci *host)
>> +{
>> +       if (!test_bit(EVENT_DATA_COMPLETE, &host->pending_events))
>> +               return false;
>> +
>> +       /* Extra paranoia just like dw_mci_clear_pending_cmd_complete() */
>> +       WARN_ON(del_timer_sync(&host->dto_timer));
>> +       clear_bit(EVENT_DATA_COMPLETE, &host->pending_events);
>> +
>> +       return true;
>> +}
>> +
>>   static void dw_mci_tasklet_func(unsigned long priv)
>>   {
>>         struct dw_mci *host = (struct dw_mci *)priv;
>> @@ -2112,8 +2128,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
>>                         /* fall through */
>>                 case STATE_DATA_BUSY:
>> -                       if (!test_and_clear_bit(EVENT_DATA_COMPLETE,
>> -                                               &host->pending_events)) {
>> +                       if (!dw_mci_clear_pending_data_complete(host)) {
>>                                 /*
>>                                  * If data error interrupt comes but data
>> over
>>                                  * interrupt doesn't come within the given
>> time.
>> @@ -2683,6 +2698,8 @@ static irqreturn_t dw_mci_interrupt(int irq, void
>> *dev_id)
>>                 }
>>                 if (pending & SDMMC_INT_DATA_OVER) {
>> +                       spin_lock_irqsave(&host->irq_lock, irqflags);
>> +
>>                         del_timer(&host->dto_timer);
>>                         mci_writel(host, RINTSTS, SDMMC_INT_DATA_OVER);
>> @@ -2695,6 +2712,8 @@ static irqreturn_t dw_mci_interrupt(int irq, void
>> *dev_id)
>>                         }
>>                         set_bit(EVENT_DATA_COMPLETE,
>> &host->pending_events);
>>                         tasklet_schedule(&host->tasklet);
>> +
>> +                       spin_unlock_irqrestore(&host->irq_lock, irqflags);
>>                 }
>>                 if (pending & SDMMC_INT_RXDR) {
>> @@ -3044,7 +3063,31 @@ static void dw_mci_cto_timer(unsigned long arg)
>>   static void dw_mci_dto_timer(unsigned long arg)
>>   {
>>         struct dw_mci *host = (struct dw_mci *)arg;
>> +       unsigned long irqflags;
>> +       u32 pending;
>> +
>> +       spin_lock_irqsave(&host->irq_lock, irqflags);
>>   +     /*
>> +        * The DTO timer is much longer than the CTO timer, so it's even
>> less
>> +        * likely that we'll these cases, but it pays to be paranoid.
>> +        */
>> +       pending = mci_readl(host, MINTSTS); /* read-only mask reg */
>> +       if (pending & SDMMC_INT_DATA_OVER) {
>> +               /* The interrupt should fire; no need to act but we can
>> warn */
>> +               dev_warn(host->dev, "Unexpected data interrupt
>> latency\n");
>> +               goto exit;
>
>
> I was checking a problem like this:
>
> (1) Start a CTO timer
> (2) Start a command
> (3) Got CMD_DONE interrupt and cancel the CTO timer
> (4) Start a DRTO timer
> (5) Start external dma to get the data from fifo
> (6) The system bus/DRAM port is idle for a very long time for no
> matter what happen.
> (7) DRTO timer fires but DTO was set as the card have already
> sent all data to the fifo.
> (8) Now you patch bails out earlier  and notify the mmc core that this
> data transfer was finished successfully.

I don't understand how you're saying that my patch will notify the mmc
core that the data transfer was finished successfully.  Two things:

A) My patch should only be fixing race conditions here and not
introducing anything new.  In other words if we are somehow
accidentally telling the MMC core that we have a successful transfer
then I don't believe that's something new that my patch introduced.


B) If the dw_mci_dto_timer function gets called then we always
indicate an error.

Specifically the _only_ action that the dw_mci_dto_timer() function
can take is this:

                host->data_status = SDMMC_INT_DRTO;
                set_bit(EVENT_DATA_ERROR, &host->pending_events);
                set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
                tasklet_schedule(&host->tasklet);

Which sets the "EVENT_DATA_ERROR" and thus can't tell the mmc core
that this data transfer was finished "successfully"

> (9) mmc core propgate the successful state to block layer and maybe
> a critical reader in file system will use the data right now but it
> falls into trouble due to the incomplete data.
>
>
> The problem comes from step 6 and setep 7. Quote some bit from dwmmc
> databook, V270a, section 7.1,
>
> "While using the external DMA interface for reading from a card, the DTO
> interrupt occurs only after all the data is flushed to memory by the DMA
> Interface unit. A Busy Clear Interrupt is asserted after the DTO."

Ugh.  Not your fault, but terrible terms.  I keep getting "DTO" and
"DRTO" confused, especially since in the code the "drto" timer is
called the "dto" timer.

DTO = Data Transfer Over
DRTO = Data Read Time Out

NOTE: it seems the bit you're quoting from the databook say that the
DTO is expected to be delayed with external DMA.  This doesn't seem to
match what you said above that  "(7) DRTO timer fires but DTO was set
as the card have already sent all data to the fifo.".  If the databook
is saying that "DTO" will be delayed then how could DTO already be set
when the timer fires??



> So the DTO isn't reliable or perfectly good in practice for that case
> that the delay is in external DMA side.

So just to restate to make sure I'm understanding you properly:

If you're using external DMA then it's possible that you'll get a Data
Transfer Over (DTO) interrupt at some point in time _later_ than the
more than 94 ms that we're waiting because the DTO timer can't be
asserted until all the DMA is flushed.  Actually, on Rockchip you
can't run faster than 150 MHz, so it's actually 121 ms.  It seems a
little bit hard to believe that DMA for a transfer is taking more than
121 ms to flush, but I guess it could happen?

It seems even harder to believe that it's taking > 121 ms to flush and
the system is running well enough that it was able to get to the dto
timer function all without the DTO interrupt bit even being set.

In any case, if the DMA transfer really is taking more than 121 ms to
flush then we'll assert a DRTO interrupt and report an error to the
MMC core.  I suppose (by chance) we could somehow get confused when
the DTO interrupt finally fires and then we could think that a 2nd
transfer finished, but I'm not even sure that would happen...


> That is hard to reproduced but
> it was the reason for me to come up with the immature idea of adding
> a longer enough and catch-all timer. Or we only set a longer enough
> timeout value for CTO and DRTO timer and we could blindly believe the
> hardware falls into troube for HW reason and seems that makes the change
> simpler. Looking forward to your opinion. :)

If you're running into the problem you describe, it kinda sounds like
it's more reason _not_ to use the same code for the CTO and DRTO
timers.  As I understand it, the CTO timer _doesn't_ suffer from the
problems above., so we shouldn't make it suffer any workarounds we
need for the DRTO.  Also the CTO timer is _very_ fast.  We expect a
normal CTO within 1 ms whereas the DRTO timer is much, much longer.
If it's been 10 ms and we haven't seen a command finish and haven't
seen a real CTO then there's no reason to delay further.


As for blindly setting a longer timeout for CTO / DRTO I'm not sure
that's a great idea.  We routinely get these timeouts in tuning and we
really don't want to make tuning even slower than it already is by
lengthening any of these timeouts too much.


Overall: if you're having weird trouble with external DMA as you
describe, I suppose you could just have an even longer DRTO delay only
for external DMA?


NOTE also: the DesignWare Manual that I have (2.80a) actually even
suggests that for long data timeouts (like 100ms) that a software
timeout is appropriate.  They even suggest that in that case you could
rely only on the software timeout.  They say:

> Note: The software timer should be used if the timeout value is in the order
> of 100 ms. In this case, read data timeout interrupt needs to be disabled.

Presumably they are saying that because you can't really express much
more than 100 ms in the TMOUT register?

---

Just to summarize:

* I don't think my patch introduces any new problems like the one you
describe.  I think if there are problems like that, they are
pre-existing.

* I don't see a reason to use a catchall timer where we use the same
timeout for CTO and DRTO.  We could try to save a few bytes of storage
space and have a single "struct timer" at the expense of a little
extra logic to try to disambiguate, but I'm not terribly interested in
writing or reviewing that patch.

---

As always, please let me know if I got mixed up somewhere.

-Doug
