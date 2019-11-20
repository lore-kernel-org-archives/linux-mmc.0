From: wgong-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Subject: Re: [PATCH v2 3/3] mmc: core: Re-work HW reset for SDIO cards
Date: Wed, 20 Nov 2019 07:10:17 +0000
Message-ID: <0101016e87a5c128-49fdb6eb-a17c-4fe9-8ac5-b521ebd0314f-000000@us-west-2.amazonses.com>
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
 <20191109103046.26445-4-ulf.hansson@linaro.org>
 <CAD=FV=VHReD5qnvcQLHvfgKHnHLbfDLZHwXtY-LV5uy_VCYpPA@mail.gmail.com>
 <CAPDyKFrCyJBz2=RzKPxqn0FSEq500=dEDsTUWYZeoFKWvSRAdA@mail.gmail.com>
 <87zhgr5af6.fsf@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87zhgr5af6.fsf-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Erik Stromdahl <erik.stromdahl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, ath10k-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 2019-11-20 14:28, Kalle Valo wrote:
> + wen, ath10k
> 
> Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
> 
>> On Tue, 12 Nov 2019 at 01:33, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> 
>> wrote:
>>> 
>>> Hi,
>>> 
>>> On Sat, Nov 9, 2019 at 2:31 AM Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> 
>>> wrote:
>>> >
>>> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> > index 6f8342702c73..abf8f5eb0a1c 100644
>>> > --- a/drivers/mmc/core/core.c
>>> > +++ b/drivers/mmc/core/core.c
>>> > @@ -1469,8 +1469,7 @@ void mmc_detach_bus(struct mmc_host *host)
>>> >         mmc_bus_put(host);
>>> >  }
>>> >
>>> > -static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
>>> > -                               bool cd_irq)
>>> > +void _mmc_detect_change(struct mmc_host *host, unsigned long delay, bool cd_irq)
>>> >  {
>>> >         /*
>>> >          * If the device is configured as wakeup, we prevent a new sleep for
>>> > @@ -2129,7 +2128,7 @@ int mmc_hw_reset(struct mmc_host *host)
>>> >         ret = host->bus_ops->hw_reset(host);
>>> >         mmc_bus_put(host);
>>> >
>>> > -       if (ret)
>>> > +       if (ret < 0)
>>> >                 pr_warn("%s: tried to HW reset card, got error %d\n",
>>> >                         mmc_hostname(host), ret);
>>> 
>>> Other callers besides marvell need to be updated?  In theory only 
>>> SDIO
>>> should have positive return values so I guess we don't care about the
>>> caller in drivers/mmc/core/block.c, right?
>> 
>> Correct, but maybe I should add some more information about that in a
>> function header of mmc_hw_reset(). Let me consider doing that as a
>> change on top.
>> 
>>>  What about:
>>> 
>>> drivers/net/wireless/ath/ath10k/sdio.c
>>> 
>>> ...I guess I don't know if there is more than one function probed
>>> there.  Maybe there's not and thus we're fine here too?
>> 
>> Well, honestly I don't know.
>> 
>> In any case, that would mean the driver is broken anyways and needs to
>> be fixed. At least that's my approach to doing this change.
> 
> Wen, does QCA6174 or QCA9377 SDIO devices have other SDIO functions, 
> for
> example bluetooth? I'm just wondering how should we handle this in
> ath10k.
Hi Kalle,
it does not have other SDIO functions for QCA6174 or QCA9377.
