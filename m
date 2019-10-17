From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 1/2] mmc: core: Add sdio_trigger_replug() API
Date: Wed, 16 Oct 2019 17:22:08 -0700
Message-ID: <CAD=FV=WTKy3PmMSCbjKA_Ro_MP+dFE89oCzi_Bs7YeCrcD+3Xg@mail.gmail.com>
References: <20190722193939.125578-1-dianders@chromium.org>
 <20190722193939.125578-2-dianders@chromium.org> <CAPDyKFpKWo4n+nmBXVcDc4TNzFV3vc+3aeKcu_nKaB=hj=RKUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpKWo4n+nmBXVcDc4TNzFV3vc+3aeKcu_nKaB=hj=RKUQ@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kalle Valo <kvalo@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Ganapathi Bhat <gbhat@marvell.com>, linux-wireless <linux-wireless@vger.kernel.org>, Andreas Fenkart <afenkart@gmail.com>, Brian Norris <briannorris@chromium.org>, Amitkumar Karwar <amitkarwar@gmail.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Nishant Sarmukadam <nishants@marvell.com>, netdev <netdev@vger.kernel.org>, Avri Altman <avri.altman@wdc.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Xinming Hu <huxinming820@gmail.com>, Matthias Kaehlcke <mka@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>Thomas Gleixner <t>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Oct 10, 2019 at 7:11 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 22 Jul 2019 at 21:41, Douglas Anderson <dianders@chromium.org> wrote:
> >
> > When using Marvell WiFi SDIO cards, it is not uncommon for Linux WiFi
> > driver to fully lose the communication channel to the firmware running
> > on the card.  Presumably the firmware on the card has a bug or two in
> > it and occasionally crashes.
> >
> > The Marvell WiFi driver attempts to recover from this problem.
> > Specifically the driver has the function mwifiex_sdio_card_reset()
> > which is called when communcation problems are found.  That function
> > attempts to reset the state of things by utilizing the mmc_hw_reset()
> > function.
> >
> > The current solution is a bit complex because the Marvell WiFi driver
> > needs to manually deinit and reinit the WiFi driver around the reset
> > call.  This means it's going through a bunch of code paths that aren't
> > normally tested.  However, complexity isn't our only problem.  The
> > other (bigger) problem is that Marvell WiFi cards are often combo
> > WiFi/Bluetooth cards and Bluetooth runs on a second SDIO func.  While
> > the WiFi driver knows that it should re-init its own state around the
> > mmc_hw_reset() call there is no good way to inform the Bluetooth
> > driver.  That means that in Linux today when you reset the Marvell
> > WiFi driver you lose all Bluetooth communication.  Doh!
>
> Thanks for a nice description to the problem!
>
> In principle it makes mmc_hw_reset() quite questionable to use for
> SDIO func drivers, at all. However, let's consider that for later.

Yeah, unless you somehow knew that your card would only have one function.


> > One way to fix the above problems is to leverage a more standard way
> > to reset the Marvell WiFi card where we go through the same code paths
> > as card unplug and the card plug.  In this patch we introduce a new
> > API call for doing just that: sdio_trigger_replug().  This API call
> > will trigger an unplug of the SDIO card followed by a plug of the
> > card.  As part of this the card will be nicely reset.
>
> I have been thinking back and forth on this, exploring various
> options, perhaps adding some callbacks that the core could invoke to
> inform the SDIO func drivers of what is going on.
>
> Although, in the end this boils done to complexity and I think your
> approach is simply the most superior in regards to this. However, I
> think there is a few things that we can do to even further simply your
> approach, let me comment on the code below.

Right.  Unplugging / re-plugging is sorta gross / inelegant, but it is
definitely simpler and nice that it doesn't add so many new code
paths.  For cases where you're just trying to re-init things with a
hammer it works pretty well.


> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >
> > Changes in v2:
> > - s/routnine/routine (Brian Norris, Matthias Kaehlcke).
> > - s/contining/containing (Matthias Kaehlcke).
> > - Add Matthias Reviewed-by tag.
> >
> >  drivers/mmc/core/core.c       | 28 ++++++++++++++++++++++++++--
> >  drivers/mmc/core/sdio_io.c    | 20 ++++++++++++++++++++
> >  include/linux/mmc/host.h      | 15 ++++++++++++++-
> >  include/linux/mmc/sdio_func.h |  2 ++
> >  4 files changed, 62 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 221127324709..5da365b1fdb4 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -2161,6 +2161,12 @@ int mmc_sw_reset(struct mmc_host *host)
> >  }
> >  EXPORT_SYMBOL(mmc_sw_reset);
> >
> > +void mmc_trigger_replug(struct mmc_host *host)
> > +{
> > +       host->trigger_replug_state = MMC_REPLUG_STATE_UNPLUG;
> > +       _mmc_detect_change(host, 0, false);
> > +}
> > +
> >  static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
> >  {
> >         host->f_init = freq;
> > @@ -2214,6 +2220,11 @@ int _mmc_detect_card_removed(struct mmc_host *host)
> >         if (!host->card || mmc_card_removed(host->card))
> >                 return 1;
> >
> > +       if (host->trigger_replug_state == MMC_REPLUG_STATE_UNPLUG) {
> > +               mmc_card_set_removed(host->card);
> > +               return 1;
>
> Do you really need to set state of the card to "removed"?
>
> If I understand correctly, what you need is to allow mmc_rescan() to
> run a second time, in particular for non removable cards.
>
> In that path, mmc_rescan should find the card being non-functional,
> thus it should remove it and then try to re-initialize it again. Etc.
>
> Do you want me to send a patch to show you what I mean!?

If you don't mind, that would probably be easiest.  I've totally
swapped out all of the implementation details of this from my brain
now, but if I saw a patch from you it would be easy for me to analyze
it and test it.

Thanks!

-Doug
