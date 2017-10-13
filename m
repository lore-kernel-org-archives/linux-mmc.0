From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 3/5] mmc: dw_mmc: Add locking to the CTO timer
Date: Thu, 12 Oct 2017 21:20:09 -0700
Message-ID: <CAD=FV=UMuJBKV2-pNo4yiyfxXxYJo_tX6RkxCCzm_UFg9XyjyQ@mail.gmail.com>
References: <20171012201118.23570-1-dianders@chromium.org> <20171012201118.23570-4-dianders@chromium.org>
 <41ae1571-4723-2700-1f03-7215e874c42e@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <41ae1571-4723-2700-1f03-7215e874c42e@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, Alexandru M Stan <amstan@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Brian Norris <briannorris@chromium.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Shawn,

On Thu, Oct 12, 2017 at 6:32 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> On 2017/10/13 4:11, Douglas Anderson wrote:
>>
>> This attempts to instill a bit of paranoia to the code dealing with
>> the CTO timer.  It's believed that this will make the CTO timer more
>> robust in the case that we're having very long interrupt latencies.
>>
>
> Ack. It could help fix some problems observed.
>
>
>> Note that I originally thought that perhaps this patch was being
>> overly paranoid and wasn't really needed, but then while I was running
>> mmc_test on an rk3399 board I saw one instance of the message:
>>    dwmmc_rockchip fe320000.dwmmc: Unexpected interrupt latency
>>
>> I had debug prints in the CTO timer code and I found that it was
>> running CMD 13 at the time.
>>
>> ...so even though this patch seems like it might be overly paranoid,
>> maybe it really isn't?
>>
>> Presumably the bad interrupt latency experienced was due to the fact
>> that I had serial console enabled as serial console is typically where
>> I place blame when I see absurdly large interrupt latencies.  In this
>> particular case there was an (unrelated) printout to the serial
>> console just before I saw the "Unexpected interrupt latency" printout.
>>
>> ...and actually, I managed to even reproduce the problems by running
>> "iw mlan0 scan > /dev/null" while mmc_test was running.  That not only
>> does a bunch of PCIe traffic but it also (on my system) outputs some
>> SELinux log spam.
>> > Fixes: 03de19212ea3 ("mmc: dw_mmc: introduce timer for broken command
>
> transfer over scheme")
>>
>> Tested-by: Emil Renner Berthing <kernel@esmil.dk>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>
>> Changes in v2:
>> - Removed extra "int i"
>>
>>   drivers/mmc/host/dw_mmc.c | 91
>> +++++++++++++++++++++++++++++++++++++++++------
>>   1 file changed, 81 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 16516c528a88..50148991f30e 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -403,6 +403,7 @@ static inline void dw_mci_set_cto(struct dw_mci *host)
>>         unsigned int cto_clks;
>>         unsigned int cto_div;
>>         unsigned int cto_ms;
>> +       unsigned long irqflags;
>>         cto_clks = mci_readl(host, TMOUT) & 0xff;
>>         cto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
>> @@ -413,8 +414,24 @@ static inline void dw_mci_set_cto(struct dw_mci
>> *host)
>>         /* add a bit spare time */
>>         cto_ms += 10;
>>   -     mod_timer(&host->cto_timer,
>> -                 jiffies + msecs_to_jiffies(cto_ms) + 1);
>> +       /*
>> +        * The durations we're working with are fairly short so we have to
>> be
>> +        * extra careful about synchronization here.  Specifically in
>> hardware a
>> +        * command timeout is _at most_ 5.1 ms, so that means we expect an
>> +        * interrupt (either command done or timeout) to come rather
>> quickly
>> +        * after the mci_writel.  ...but just in case we have a long
>> interrupt
>> +        * latency let's add a bit of paranoia.
>> +        *
>> +        * In general we'll assume that at least an interrupt will be
>> asserted
>> +        * in hardware by the time the cto_timer runs.  ...and if it
>> hasn't
>> +        * been asserted in hardware by that time then we'll assume it'll
>> never
>> +        * come.
>> +        */
>> +       spin_lock_irqsave(&host->irq_lock, irqflags);
>> +       if (!test_bit(EVENT_CMD_COMPLETE, &host->pending_events))
>> +               mod_timer(&host->cto_timer,
>> +                       jiffies + msecs_to_jiffies(cto_ms) + 1);
>> +       spin_unlock_irqrestore(&host->irq_lock, irqflags);
>
>
> IIUC, this change is beacuse you move
> mci_writel(host, CMD, cmd_flags | SDMMC_CMD_START) before
> setting up the timer, so there is a timing gap that the cmd_done
> already comes and handled by dw_mci_interrupt->dw_mci_cmd_interrupt.
> At this point, we don't need the cto timer at all.

As per below, if I don't move the mci_writel() before setting up the
timer then there's still a race.  ...and actually that race was harder
for me to write code for, but I invite you to try to see if it's
somehow cleaner.


>>   }
>>     static void dw_mci_start_command(struct dw_mci *host,
>> @@ -429,11 +446,11 @@ static void dw_mci_start_command(struct dw_mci
>> *host,
>>         wmb(); /* drain writebuffer */
>>         dw_mci_wait_while_busy(host, cmd_flags);
>>   +     mci_writel(host, CMD, cmd_flags | SDMMC_CMD_START);
>> +
>>         /* response expected command only */
>>         if (cmd_flags & SDMMC_CMD_RESP_EXP)
>>                 dw_mci_set_cto(host);
>> -
>> -       mci_writel(host, CMD, cmd_flags | SDMMC_CMD_START);
>
>
>
> But why? If we still keep the original logic, it's always correct
> that cmd_done comes after setting up the cto timer. So could you
> eleborate a bit more to help me understand the real intention here?

No matter which order you put things, there's a race one way or the
other.  You need a lock.

Let's think about the old code you wrote.  You did this:
1. Start the CTO timer.
2. Start the command.

Now if you (somehow) take 20 ms to handle the interrupt, then this happens:

1. Start the CTO timer.
2. Start the command.
3. Interrupt is pending, but interrupt handler doesn't run yet.
4. CTO timer fires and enqueues CTO timeout.
5. Interrupt finally fires.


Now normally things are pretty bad if you've got an interrupt latency
of 20 ms.  ...and, in fact, I originally wrote up a commit that simply
explained why the race didn't matter and was thinking of posting that
instead of this one.  I wrote up:

     * Start a timer to detect missing cmd timeout if we expect a response.
     *
     * Note that we need to be a little careful about race conditions here
     * since our timer will be racing with the actual hardware interrupt
     * and things would get confused if both of them happened.
     *
     * We end up avoiding races here mostly because of our 10 ms "spare
     * time" buffer above.  That's probably reliable enough because:
     * - There's "guaranteed" "very little" time between setting the timer
     *   and starting the command.  We're holding a spinlock (host->lock)
     *   in all calls to this function so we won't get preempted.  Possibly
     *   we could get interrupts still, but that shouldn't add up to
     *   anything like the 10 ms spare time.
     * - We expect that when the actual interrupt fires that our interrupt
     *   routine should get called "relatively quickly" (compared to the
     *   10 ms buffer) and will be able to cancel this timer.

...but then I ran a whole bunch of tests and I found that, as far as I
could tell, we actually _were_ getting a super long interrupt latency.
Specifically I saw the printout "Unexpected interrupt latency" in my
patch.  In order to see that printout in my patch (which even starts
the command _before_ the CTO timer), the only explanation is bad
interrupt latency, right?  Also: based on my past experience I believe
it is possible to get upwards of 100 ms interrupt latency if you've
got serial console enabled.  printk, especially printk from an
interrupt context, can do some funny things.


...but this stuff is always hard to get right, so if I messed up the
above please let me know!  I tried to think of all of the cases so it
would work no matter if delays happened in any random place but
concurrency is hard.


-Doug
