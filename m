From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/3] mwifiex: Re-work support for SDIO HW reset
Date: Tue, 12 Nov 2019 13:13:21 +0100
Message-ID: <CAPDyKFq-djJFyYu6Wzg9t9hLOQMuqff9KVhbx5Zp5i=Fsynsdw@mail.gmail.com>
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
 <20191109103046.26445-2-ulf.hansson@linaro.org> <CAD=FV=WccuUCnQXHq-HuojCRAKVA02D7HBS9PgqSqq3+b2v4CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAD=FV=WccuUCnQXHq-HuojCRAKVA02D7HBS9PgqSqq3+b2v4CA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wen Gong <wgong-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Erik Stromdahl <erik.stromdahl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 12 Nov 2019 at 01:33, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>
> Hi,
>
> On Sat, Nov 9, 2019 at 2:31 AM Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> >
> > The SDIO HW reset procedure in mwifiex_sdio_card_reset_work() is broken,
> > when the SDIO card is shared with another SDIO func driver. This is the
> > case when the Bluetooth btmrvl driver is being used in combination with
> > mwifiex. More precisely, when mwifiex_sdio_card_reset_work() runs to resets
> > the SDIO card, the btmrvl driver doesn't get notified about it. Beyond that
> > point, the btmrvl driver will fail to communicate with the SDIO card.
> >
> > This is a generic problem for SDIO func drivers sharing an SDIO card, which
> > are about to be addressed in subsequent changes to the mmc core and the
> > mmc_hw_reset() interface. In principle, these changes means the
> > mmc_hw_reset() interface starts to return 1 if the are multiple drivers for
> > the SDIO card, as to indicate to the caller that the reset needed to be
> > scheduled asynchronously through a hotplug mechanism of the SDIO card.
> >
> > Let's prepare the mwifiex driver to support the upcoming new behaviour of
> > mmc_hw_reset(), which means extending the mwifiex_sdio_card_reset_work() to
> > support the asynchronous SDIO HW reset path. This also means, we need to
> > allow the ->remove() callback to run, without waiting for the FW to be
> > loaded. Additionally, during system suspend, mwifiex_sdio_suspend() may be
> > called when a reset has been scheduled, but waiting to be executed. In this
> > scenario let's simply return -EBUSY to abort the suspend process, as to
> > allow the reset to be completed first.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > ---
> >  drivers/net/wireless/marvell/mwifiex/main.c |  6 +++-
> >  drivers/net/wireless/marvell/mwifiex/main.h |  1 +
> >  drivers/net/wireless/marvell/mwifiex/sdio.c | 33 ++++++++++++++-------
> >  3 files changed, 28 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
> > index a9657ae6d782..dbdbdd6769a9 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/main.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> > @@ -76,6 +76,7 @@ static int mwifiex_register(void *card, struct device *dev,
> >         *padapter = adapter;
> >         adapter->dev = dev;
> >         adapter->card = card;
> > +       adapter->is_adapter_up = false;
>
> Probably not needed.  The 'adapter' was kzalloc-ed a few lines above
> and there's no need to re-init to 0.

Right, let me re-spin and drop this.

>
>
> > diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
> > index 24c041dad9f6..2417c94c29c0 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> > @@ -444,6 +444,9 @@ static int mwifiex_sdio_suspend(struct device *dev)
> >                 return 0;
> >         }
> >
> > +       if (!adapter->is_adapter_up)
> > +               return -EBUSY;
>
> I'm moderately concerned that there might be cases where firmware
> never got loaded but we could suspend/resume OK.  ...and now we never
> will?  I'm not familiar enough with the code to know if this is a real
> concern, so I guess we can do this and then see...

There is a completion variable that is used to make sure the firmware
is loaded, before the mwifiex driver runs ->suspend|remove(). This is
needed, because during ->probe() the FW will be loaded asynchronously,
hence both mwifiex_sdio_remove() and mwifiex_sdio_suspend(), may be
called while waiting for the FW to be loaded.

If a HW reset has been scheduled but not completed, which would be the
case if mmc_hw_reset() gets called after mmc_pm_notify() with a
PM_SUSPEND_PREPARE. This is because mmc_pm_notify() then disables the
rescan work, but then re-kicks/enables it at PM_POST_SUSPEND (after
the system has resumed).

Returning -EBUSY, should allow the mmc rescan work to be completed
when the system have resumed.

Of course, one could also considering using pm_wakeup_event(), in case
mmc_hw_reset() needed to schedule the reset, as to prevent the system
for suspending for a small amount of time. As to make sure the rescan
work, gets to run. But I am not sure that's needed here.

>
>
> > @@ -2220,22 +2223,30 @@ static void mwifiex_sdio_card_reset_work(struct mwifiex_adapter *adapter)
> >         struct sdio_func *func = card->func;
> >         int ret;
> >
> > +       /* Prepare the adapter for the reset. */
> >         mwifiex_shutdown_sw(adapter);
> > +       clear_bit(MWIFIEX_IFACE_WORK_DEVICE_DUMP, &card->work_flags);
> > +       clear_bit(MWIFIEX_IFACE_WORK_CARD_RESET, &card->work_flags);
> >
> > -       /* power cycle the adapter */
> > +       /* Run a HW reset of the SDIO interface. */
> >         sdio_claim_host(func);
> > -       mmc_hw_reset(func->card->host);
> > +       ret = mmc_hw_reset(func->card->host);
> >         sdio_release_host(func);
> >
> > -       /* Previous save_adapter won't be valid after this. We will cancel
> > -        * pending work requests.
> > -        */
> > -       clear_bit(MWIFIEX_IFACE_WORK_DEVICE_DUMP, &card->work_flags);
> > -       clear_bit(MWIFIEX_IFACE_WORK_CARD_RESET, &card->work_flags);
>
> I don't know enough about the clearing of these bits to confirm that
> it's OK to move their clearing to be before the mmc_hw_reset().
> Possibly +Brian Norris does?

That shouldn't matter, because we are running in the path of the
mwifiex_sdio_work(), as work from the system_wq. Unless I am mistaken,
only one work of the type mwifiex_sdio_work() can execute at the same
time. By clearing these bits, we want to cancel any potential recently
scheduled work. It should matter if that's done before or after
mmc_hw_reset().

Moreover, this change makes it more consistent with how the pcie
driver clears the bits.

>
>
> I can't promise that I didn't miss anything, but to the best of my
> knowledge this is good now:
>
> Reviewed-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Thanks!

Finally, if you want to verify that the above system suspend path
works fine, you could change the call to "_mmc_detect_change(host, 0,
false)" in mmc_sdio_hw_reset(), into "_mmc_detect_change(host,
msecs_to_jiffies(30000), false)", in patch3.

This should leave you a 30s window of where you can try to system
suspend the platform, while also waiting for the scheduled reset to be
completed.

Kind regards
Uffe
