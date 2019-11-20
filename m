From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v2 3/3] mmc: core: Re-work HW reset for SDIO cards
Date: Wed, 20 Nov 2019 06:28:19 +0000
Message-ID: <0101016e877f56ce-8c7f312f-49d9-47e5-8473-30657f87bdd2-000000@us-west-2.amazonses.com>
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
        <20191109103046.26445-4-ulf.hansson@linaro.org>
        <CAD=FV=VHReD5qnvcQLHvfgKHnHLbfDLZHwXtY-LV5uy_VCYpPA@mail.gmail.com>
        <CAPDyKFrCyJBz2=RzKPxqn0FSEq500=dEDsTUWYZeoFKWvSRAdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFrCyJBz2=RzKPxqn0FSEq500=dEDsTUWYZeoFKWvSRAdA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
        (Ulf Hansson's message of "Tue, 12 Nov 2019 13:19:55 +0100")
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wen Gong <wgong-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Erik Stromdahl <erik.stromdahl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, ath10k-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

+ wen, ath10k

Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:

> On Tue, 12 Nov 2019 at 01:33, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>>
>> Hi,
>>
>> On Sat, Nov 9, 2019 at 2:31 AM Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> >
>> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> > index 6f8342702c73..abf8f5eb0a1c 100644
>> > --- a/drivers/mmc/core/core.c
>> > +++ b/drivers/mmc/core/core.c
>> > @@ -1469,8 +1469,7 @@ void mmc_detach_bus(struct mmc_host *host)
>> >         mmc_bus_put(host);
>> >  }
>> >
>> > -static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
>> > -                               bool cd_irq)
>> > +void _mmc_detect_change(struct mmc_host *host, unsigned long delay, bool cd_irq)
>> >  {
>> >         /*
>> >          * If the device is configured as wakeup, we prevent a new sleep for
>> > @@ -2129,7 +2128,7 @@ int mmc_hw_reset(struct mmc_host *host)
>> >         ret = host->bus_ops->hw_reset(host);
>> >         mmc_bus_put(host);
>> >
>> > -       if (ret)
>> > +       if (ret < 0)
>> >                 pr_warn("%s: tried to HW reset card, got error %d\n",
>> >                         mmc_hostname(host), ret);
>>
>> Other callers besides marvell need to be updated?  In theory only SDIO
>> should have positive return values so I guess we don't care about the
>> caller in drivers/mmc/core/block.c, right?
>
> Correct, but maybe I should add some more information about that in a
> function header of mmc_hw_reset(). Let me consider doing that as a
> change on top.
>
>>  What about:
>>
>> drivers/net/wireless/ath/ath10k/sdio.c
>>
>> ...I guess I don't know if there is more than one function probed
>> there.  Maybe there's not and thus we're fine here too?
>
> Well, honestly I don't know.
>
> In any case, that would mean the driver is broken anyways and needs to
> be fixed. At least that's my approach to doing this change.

Wen, does QCA6174 or QCA9377 SDIO devices have other SDIO functions, for
example bluetooth? I'm just wondering how should we handle this in
ath10k.

-- 
Kalle Valo
