From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 2/3] mmc: core: API for temporarily disabling
 auto-retuning due to errors
Date: Wed, 5 Jun 2019 15:51:19 -0700
Message-ID: <CAD=FV=Vu3p_Y=Q3PLj37nSOU2WH-SyaG5K=f0O_UKu1==Zj-eA@mail.gmail.com>
References: <20190603183740.239031-1-dianders@chromium.org>
 <20190603183740.239031-3-dianders@chromium.org> <25fe1725-76fa-2739-1427-b0e8823ea4ae@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <25fe1725-76fa-2739-1427-b0e8823ea4ae-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arend Van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, brcm80211-dev-list.pdl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Double Lo <double.lo-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Naveen Gupta <naveen.gupta-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Madhan Mohan R <madhanmohan.r-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Wright Feng <wright.feng-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Chi-Hsien Lin <chi-hsien.lin-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, brcm80211-dev-list <brcm80211-dev-list-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Jun 5, 2019 at 12:54 AM Arend Van Spriel
<arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
>
> On 6/3/2019 8:37 PM, Douglas Anderson wrote:
> > Normally when the MMC core sees an "-EILSEQ" error returned by a host
> > controller then it will trigger a retuning of the card.  This is
> > generally a good idea.
> >
> > However, if a command is expected to sometimes cause transfer errors
> > then these transfer errors shouldn't cause a re-tuning.  This
> > re-tuning will be a needless waste of time.  One example case where a
> > transfer is expected to cause errors is when transitioning between
> > idle (sometimes referred to as "sleep" in Broadcom code) and active
> > state on certain Broadcom WiFi cards.  Specifically if the card was
> > already transitioning between states when the command was sent it
> > could cause an error on the SDIO bus.
> >
> > Let's add an API that the SDIO card drivers can call that will
> > temporarily disable the auto-tuning functionality.  Then we can add a
> > call to this in the Broadcom WiFi driver and any other driver that
> > might have similar needs.
> >
> > NOTE: this makes the assumption that the card is already tuned well
> > enough that it's OK to disable the auto-retuning during one of these
> > error-prone situations.  Presumably the driver code performing the
> > error-prone transfer knows how to recover / retry from errors.  ...and
> > after we can get back to a state where transfers are no longer
> > error-prone then we can enable the auto-retuning again.  If we truly
> > find ourselves in a case where the card needs to be retuned sometimes
> > to handle one of these error-prone transfers then we can always try a
> > few transfers first without auto-retuning and then re-try with
> > auto-retuning if the first few fail.
> >
> > Without this change on rk3288-veyron-minnie I periodically see this in
> > the logs of a machine just sitting there idle:
> >    dwmmc_rockchip ff0d0000.dwmmc: Successfully tuned phase to XYZ
> >
> > Fixes: bd11e8bd03ca ("mmc: core: Flag re-tuning is needed on CRC errors")
> > Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > ---
> > Note that are are a whole boatload of different ways that we could
> > provide an API for the Broadcom WiFi SDIO driver.  This patch
> > illustrates one way but if maintainers feel strongly that this is too
> > ugly and have a better idea then I can give it a shot too.  From a
> > purist point of view I kinda felt that the "expect errors" really
> > belonged as part of the mmc_request structure, but getting it into
> > there meant changing a whole pile of core SD/MMC APIs.  Simply adding
> > it to the host seemed to match the current style better and was a less
> > intrusive change.
>
> Hi Doug,
>
> Sorry for bringing this up, but there used to be an issue with retuning
> in general, ie. the device handled tuning command 19 only once after
> startup. I guess that is no longer an issue given your results.

Right.  It definitely used to just happen once at bootup and you were
out of luck if that value was bad for some reason or if conditions
changed.  In cases in my own personal experience it was actually fine
to just tune once at bootup once all the tuning bugs in the controller
were fixed.  ...but I can imagine that some controllers could use
delay elements that drift more.  ...and in any case if you're getting
CRC errors trying a re-tuning seems a sensible thing to do anyway
(unless the CRC error was expected).

Looking at commit bd11e8bd03ca ("mmc: core: Flag re-tuning is needed
on CRC errors") you can definitely see evidence that tuning can happen
again after bootup.


> I guess
> the problem goes away when you disable device sleep functionality. No
> what you want in terms of power consumption, but would be good to know.
> You can disable it with below patch.

I can try testing this if it's useful, but I'm not sure what it will
prove.  I definitely don't want to disable device sleep, so it's not a
long term solution.  Are you just looking for extra evidence that this
is indeed my problem?  I don't think I need any extra evidence, do I?
The fact that patch #3 in this series fixes my problems (plus
debugging I did to arrive at that patch) means we absolutely know that
brcmf_sdio_kso_control() is responsible for the CRC errors that caused
the unneeded tuning.  Setting BRCMF_IDLE_INTERVAL to 0 will
effectively prevent brcmf_sdio_kso_control() from doing anything
useful (except in full system suspend, but that's not the case I was
testing anyway).

-Doug
