From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 1/3] mwifiex: Re-work support for SDIO HW reset
Date: Tue, 12 Nov 2019 10:04:48 -0800
Message-ID: <CAD=FV=VWdzqGY778SXZnC1YDyxc6EHPgRjkJ_2sOHrxHTams-w@mail.gmail.com>
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
 <20191109103046.26445-2-ulf.hansson@linaro.org> <CAD=FV=WccuUCnQXHq-HuojCRAKVA02D7HBS9PgqSqq3+b2v4CA@mail.gmail.com>
 <CAPDyKFq-djJFyYu6Wzg9t9hLOQMuqff9KVhbx5Zp5i=Fsynsdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFq-djJFyYu6Wzg9t9hLOQMuqff9KVhbx5Zp5i=Fsynsdw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wen Gong <wgong-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Erik Stromdahl <erik.stromdahl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Nov 12, 2019 at 4:14 AM Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
> > > diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
> > > index 24c041dad9f6..2417c94c29c0 100644
> > > --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> > > +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> > > @@ -444,6 +444,9 @@ static int mwifiex_sdio_suspend(struct device *dev)
> > >                 return 0;
> > >         }
> > >
> > > +       if (!adapter->is_adapter_up)
> > > +               return -EBUSY;
> >
> > I'm moderately concerned that there might be cases where firmware
> > never got loaded but we could suspend/resume OK.  ...and now we never
> > will?  I'm not familiar enough with the code to know if this is a real
> > concern, so I guess we can do this and then see...
>
> There is a completion variable that is used to make sure the firmware
> is loaded, before the mwifiex driver runs ->suspend|remove(). This is
> needed, because during ->probe() the FW will be loaded asynchronously,
> hence both mwifiex_sdio_remove() and mwifiex_sdio_suspend(), may be
> called while waiting for the FW to be loaded.
>
> If a HW reset has been scheduled but not completed, which would be the
> case if mmc_hw_reset() gets called after mmc_pm_notify() with a
> PM_SUSPEND_PREPARE. This is because mmc_pm_notify() then disables the
> rescan work, but then re-kicks/enables it at PM_POST_SUSPEND (after
> the system has resumed).
>
> Returning -EBUSY, should allow the mmc rescan work to be completed
> when the system have resumed.
>
> Of course, one could also considering using pm_wakeup_event(), in case
> mmc_hw_reset() needed to schedule the reset, as to prevent the system
> for suspending for a small amount of time. As to make sure the rescan
> work, gets to run. But I am not sure that's needed here.

I was more worried that we could get into a state where we'd return
EBUSY forever, but I think I've convinced myself that this isn't
possible.  If we fail to load things then the adapter variable will be
freed anyway.


> Finally, if you want to verify that the above system suspend path
> works fine, you could change the call to "_mmc_detect_change(host, 0,
> false)" in mmc_sdio_hw_reset(), into "_mmc_detect_change(host,
> msecs_to_jiffies(30000), false)", in patch3.
>
> This should leave you a 30s window of where you can try to system
> suspend the platform, while also waiting for the scheduled reset to be
> completed.

It worked.

https://pastebin.com/NdsvAdE8
