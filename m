From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v5 0/5] brcmfmac: sdio: Deal better w/ transmission errors
 related to idle
Date: Mon, 17 Jun 2019 11:46:59 -0700
Message-ID: <CAD=FV=U5+j8V7qckLJf0N+xMeuaOqF+ThL3th98y63aTAVe57g@mail.gmail.com>
References: <20190617175653.21756-1-dianders@chromium.org> <CAPDyKFpaX6DSM_BjtghAHUf7qYCyEG+wMagXPUdgz3Eutovqfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFpaX6DSM_BjtghAHUf7qYCyEG+wMagXPUdgz3Eutovqfw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Arend van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, brcm80211-dev-list.pdl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Double Lo <double.lo-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Naveen Gupta <naveen.gupta-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Madhan Mohan R <madhanmohan.r-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Wright Feng <wright.feng-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Chi-Hsien Lin <chi-hsien.lin-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, brcm80211-dev-list <brcm80211-dev-list-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, YueHaibing <yuehaibing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Allison Randal <allison-wcfNWazeolPR7s880joybQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Jun 17, 2019 at 11:39 AM Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
> On Mon, 17 Jun 2019 at 19:57, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> >
> > This series attempts to deal better with the expected transmission
> > errors related to the idle states (handled by the Always-On-Subsystem
> > or AOS) on the SDIO-based WiFi on rk3288-veyron-minnie,
> > rk3288-veyron-speedy, and rk3288-veyron-mickey.
> >
> > Some details about those errors can be found in
> > <https://crbug.com/960222>, but to summarize it here: if we try to
> > send the wakeup command to the WiFi card at the same time it has
> > decided to wake up itself then it will behave badly on the SDIO bus.
> > This can cause timeouts or CRC errors.
> >
> > When I tested on 4.19 and 4.20 these CRC errors can be seen to cause
> > re-tuning.  Since I am currently developing on 4.19 this was the
> > original problem I attempted to solve.
> >
> > On mainline it turns out that you don't see the retuning errors but
> > you see tons of spam about timeouts trying to wakeup from sleep.  I
> > tracked down the commit that was causing that and have partially
> > reverted it here.  I have no real knowledge about Broadcom WiFi, but
> > the commit that was causing problems sounds (from the descriptioin) to
> > be a hack commit penalizing all Broadcom WiFi users because of a bug
> > in a Cypress SD controller.  I will let others comment if this is
> > truly the case and, if so, what the right solution should be.
> >
> > For v3 of this series I have added 2 patches to the end of the series
> > to address errors that would show up on systems with these same SDIO
> > WiFi cards when used on controllers that do periodic retuning.  These
> > systems need an extra fix to prevent the retuning from happening when
> > the card is asleep.
> >
> > I believe v5 of this series is all ready to go assuming Kalle Valo is
> > good with it.  I've added after-the-cut notes to patches awaiting his
> > Ack and have added other tags collected so far.
> >
> > Changes in v5:
> > - Add missing sdio_retune_crc_enable() in comments (Ulf).
> > - /s/reneable/re-enable (Ulf).
> > - Remove leftover prototypes: mmc_expect_errors_begin() / end() (Ulf).
> > - Rewording of "sleep command" in commit message (Arend).
> >
> > Changes in v4:
> > - Moved to SDIO API only (Adrian, Ulf).
> > - Renamed to make it less generic, now retune_crc_disable (Ulf).
> > - Function header makes it clear host must be claimed (Ulf).
> > - No more WARN_ON (Ulf).
> > - Adjust to API rename (Adrian, Ulf).
> > - Moved retune hold/release to SDIO API (Adrian).
> > - Adjust to API rename (Adrian).
> >
> > Changes in v3:
> > - Took out the spinlock since I believe this is all in one context.
> > - Expect errors for all of brcmf_sdio_kso_control() (Adrian).
> > - ("mmc: core: Export mmc_retune_hold_now() mmc_retune_release()") new for v3.
> > - ("brcmfmac: sdio: Don't tune while the card is off") new for v3.
> >
> > Changes in v2:
> > - A full revert, not just a partial one (Arend).  ...with explicit Cc.
> > - Updated commit message to clarify based on discussion of v1.
> >
> > Douglas Anderson (5):
> >   Revert "brcmfmac: disable command decode in sdio_aos"
> >   mmc: core: API to temporarily disable retuning for SDIO CRC errors
> >   brcmfmac: sdio: Disable auto-tuning around commands expected to fail
> >   mmc: core: Add sdio_retune_hold_now() and sdio_retune_release()
> >   brcmfmac: sdio: Don't tune while the card is off
> >
> >  drivers/mmc/core/core.c                       |  5 +-
> >  drivers/mmc/core/sdio_io.c                    | 77 +++++++++++++++++++
> >  .../broadcom/brcm80211/brcmfmac/sdio.c        | 17 ++--
> >  include/linux/mmc/host.h                      |  1 +
> >  include/linux/mmc/sdio_func.h                 |  6 ++
> >  5 files changed, 99 insertions(+), 7 deletions(-)
> >
> > --
> > 2.22.0.410.gd8fdbe21b5-goog
> >
>
> Applied for fixes, thanks!
>
> Some minor changes:
> 1) Dropped the a few "commit notes", that was more related to version
> and practical information about the series.
> 2) Dropped fixes tags for patch 2->5, but instead put a stable tag
> targeted for v4.18+.

OK, sounds good.  Thanks!  :-)

I guess when I see the # v4.18+ in the commit message it makes me
believe that the problem only existed on 4.18+, but maybe that's just
me reading too much into it.  ;-)  In any case, presumably anyone who
had these problems on earlier kernels already has solved them with
local patches.


-Doug
