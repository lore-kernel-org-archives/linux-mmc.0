From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/3] mmc: Fixup HW reset for SDIO cards
Date: Wed, 13 Nov 2019 16:11:53 +0100
Message-ID: <CAPDyKFo6=WTONuXkyWsYMy9MS8Zs0HrZue7mzPbN9WUYRWmfAQ@mail.gmail.com>
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
 <CAD=FV=Wv9DgzQZZE8YvB+qjBzPsKdJvafSnFy8YAN_dN6UJbtQ@mail.gmail.com>
 <CAPDyKFq5=B8u=9awGaXuhTmYK6Sbbe6EmF9EMhBQQyyrD1bKRw@mail.gmail.com> <CAD=FV=Xf5O_ew+hG9BLSZUM7bKAZvEvqaK4Cy1xUWgKdTGUMwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAD=FV=Xf5O_ew+hG9BLSZUM7bKAZvEvqaK4Cy1xUWgKdTGUMwA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wen Gong <wgong-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Erik Stromdahl <erik.stromdahl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 12 Nov 2019 at 18:43, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>
> Hi,
>
> On Tue, Nov 12, 2019 at 4:28 AM Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> >
> > On Tue, 12 Nov 2019 at 01:51, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> > >
> > > Hi,
> > >
> > > On Sat, Nov 9, 2019 at 2:31 AM Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > > >
> > > > Changes in v2:
> > > >         - Add adaptations to the mwifiex driver.
> > > >         - Keep existing syncronous reset behaviour if the SDIO card has a single
> > > >         func driver.
> > > >
> > > > It has turned out that it's not a good idea to try to power cycle and to
> > > > re-initialize the SDIO card, as currently done through mmc_hw_reset(). This
> > > > because there may be multiple SDIO funcs attached to the same SDIO card and
> > > > some of the others that didn't execute the call to mmc_hw_reset(), may then
> > > > simply experience an undefined behaviour.
> > > >
> > > > The following patches in this series attempts to address this problem, by
> > > > reworking the mmc_hw_reset() behaviour for SDIO and by adopting the Marvel
> > > > mwifiex driver to these changes.
> > > >
> > > > Note that, I don't have the HW at hand so the the code has only compile tested.
> > > > Test on HW is greatly appreciated!
> > > >
> > > > Ulf Hansson (3):
> > > >   mwifiex: Re-work support for SDIO HW reset
> > > >   mmc: core: Drop check for mmc_card_is_removable() in mmc_rescan()
> > > >   mmc: core: Re-work HW reset for SDIO cards
> > > >
> > > >  drivers/mmc/core/core.c                     | 12 +++-----
> > > >  drivers/mmc/core/core.h                     |  2 ++
> > > >  drivers/mmc/core/sdio.c                     | 28 ++++++++++++++++-
> > > >  drivers/mmc/core/sdio_bus.c                 |  9 +++++-
> > > >  drivers/net/wireless/marvell/mwifiex/main.c |  6 +++-
> > > >  drivers/net/wireless/marvell/mwifiex/main.h |  1 +
> > > >  drivers/net/wireless/marvell/mwifiex/sdio.c | 33 ++++++++++++++-------
> > > >  include/linux/mmc/card.h                    |  1 +
> > > >  8 files changed, 70 insertions(+), 22 deletions(-)
> > >
> > > I put this on rk3288-veyron-jerry atop v5.4-rc7 and I could run my
> > > test case for a while, AKA I got over 50 cycles of:
> > >
> > > ---
> > >
> > > for i in $(seq 1000); do
> > >   echo "LOOP $i --------"
> > >   echo 1 > /sys/kernel/debug/mwifiex/mlan0/reset
> > >
> > >   while true; do
> > >     if ! ping6 -w15 -c1 "${GW}" >/dev/null 2>&1; then
> > >       fail=$(( fail + 1 ))
> > >       echo "Fail WiFi ${fail}"
> > >       if [[ ${fail} == 3 ]]; then
> > >         exit 1
> > >       fi
> > >     else
> > >       fail=0
> > >       break
> > >     fi
> > >   done
> > >
> > >   hciconfig hci0 down
> > >   sleep 1
> > >   if ! hciconfig hci0 up; then
> > >     echo "Fail BT"
> > >     exit 1
> > >   fi
> > >
> > > done
> > >
> > > ---
> > >
> > > NOTE: with no patches I couldn't even get my test case to pass w/out
> > > the BT bits and I swear that used to work before.  ...but I didn't
> > > debug since the end result (with full card hotplug) is happy-working
> > > for me.  I'll still use it as further argument that (IMO) full unplug
> > > / plug of the card is better it uses more standard code paths and is
> > > less likely to break.  ;-)
> > >
> > > Tested-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> >
> > Thanks, I add this to the series and make a re-spin.
> >
> > What do you think about tagging the patches for stable?
> >
> > I guess there is a risk that we may "break" the other two users of
> > mmc_hw_reset(). But, as I said, in that case those needs to be fixed
> > anyways.
>
> I'm not sure how to make that judgement call.  Certainly it would help
> anyone using the Marvell case and the Marvell case was pretty broken
> before.
>
> How about this: if you can get a Tested-by from the other users then
> I'd be good with a general CC: stable.  Otherwise, I'd be OK with a CC
> to stable for 5.4, but I'd be a little hesitant to send it back to
> older kernels (even though it certainly applies and fixes problems).

This makes sense, let's go with this!

> At least in the case of Chrome OS we already have a workable solution
> for our 4.19 tree (my previous patches), and I'd guess anyone testing
> on real hardware is either not seeing problems or has their own
> private patches already.  If things have been sitting stable on 5.4
> for a while and no problems were reported, then we could consider
> going back further?

Yep!

That said, the v3 series is queued up for next and by adding a stable
tag for 5.4+.

Kind regards
Uffe
