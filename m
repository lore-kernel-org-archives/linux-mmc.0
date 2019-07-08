From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 4/7] mmc: sdio: Drop powered-on re-init at runtime resume
 and HW reset
Date: Mon, 8 Jul 2019 14:12:39 -0700
Message-ID: <CAD=FV=UfHd=_gqEMajABV19Mb=G-tz6VptDQa48g4kUPxo-A6g@mail.gmail.com>
References: <20190618153448.27145-1-ulf.hansson@linaro.org>
 <20190618153448.27145-5-ulf.hansson@linaro.org> <CAD=FV=X7P2F1k_zwHc0mbtfk55-rucTz_GoDH=PL6zWqKYcpuw@mail.gmail.com>
 <CAPDyKFoHzCmobCtyy-j+-4xjW0Bt1_vA5-s4vHLVN78jXJ4X-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFoHzCmobCtyy-j+-4xjW0Bt1_vA5-s4vHLVN78jXJ4X-w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Arend Van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Jul 8, 2019 at 3:54 AM Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
> On Thu, 4 Jul 2019 at 02:02, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> >
> > Hi,
> >
> > On Tue, Jun 18, 2019 at 8:35 AM Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > >
> > > To use the so called powered-on re-initialization of an SDIO card, the
> > > power to the card must obviously have stayed on. If not, the initialization
> > > will simply fail.
> > >
> > > In the runtime suspend case, the card is always powered off. Hence, let's
> > > drop the support for powered-on re-initialization during runtime resume, as
> > > it doesn't make sense.
> > >
> > > Moreover, during a HW reset, the point is to cut the power to the card and
> > > then do fresh re-initialization. Therefore drop the support for powered-on
> > > re-initialization during HW reset.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > ---
> > >  drivers/mmc/core/sdio.c | 8 +-------
> > >  1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > This has been on my list of things to test for a while but I never
> > quite got to it...
> >
> > ...and then, today, I spent time bisecting why the "reset"
> > functionality of miwfiex is broken on my 4.19 kernel [1].  AKA, this
> > is broken:
> >
> > cd /sys/kernel/debug/mwifiex/mlan0
> > echo 1 > reset
> >
> > I finally bisected the problem and tracked it down to commit
> > ca8971ca5753 ("mmc: dw_mmc: Prevent runtime PM suspend when SDIO IRQs
> > are enabled"), which embarrassingly has my Tested-by on it.  I guess I
> > never tested the Marvell reset call.  :-/
> >
> > I dug a little and found that when the Marvell code did its reset we
> > ended up getting a call to dw_mci_enable_sdio_irq(enb=0) and never saw
> > a dw_mci_enable_sdio_irq(enb=1) after.  I tracked it down further and
> > found that specifically it was the call to mmc_signal_sdio_irq() in
> > mmc_sdio_power_restore() that was making the call.  The call stack
> > shown for the "enb=0" call:
> >
> > [<c071a290>] (dw_mci_enable_sdio_irq) from [<c070a960>]
> > (mmc_sdio_power_restore+0x98/0xc0)
> > [<c070a960>] (mmc_sdio_power_restore) from [<c070a9b4>]
> > (mmc_sdio_reset+0x2c/0x30)
> > [<c070a9b4>] (mmc_signal_sdio_irq) from [<c06ff160>] (mmc_hw_reset+0xbc/0x138)
> > [<c06ff160>] (mmc_hw_reset) from [<bf1bbad8>]
> > (mwifiex_sdio_work+0x5d4/0x678 [mwifiex_sdio])
> > [<bf1bbad8>] (mwifiex_sdio_work [mwifiex_sdio]) from [<c0247cd0>]
> > (process_one_work+0x290/0x4b4)
> >
> > I picked your patch here (which gets rid of the call to
> > mmc_signal_sdio_irq()) and magically the problem went away because
> > there is no more call to mmc_signal_sdio_irq().
> >
> > I personally don't have lots of history about the whole
> > "powered_resume" code path.  I checked and mmc_card_keep_power() was 0
> > in my test case of getting called from hw_reset, so the rest of this
> > patch doesn't affect me at all.  This surprised me a little since I
> > saw "MMC_PM_KEEP_POWER" being set in mwifiex but then I realized that
> > it was only set for the duration of suspend and then cleared by the
> > core.  ;-)
> >
> > I will also say that I don't have any test case or knowledge of how
> > SDIO runtime suspend/resume is supposed to work since on dw_mmc SDIO
> > cards are currently not allowed to runtime suspend anyway.  ;-)
> >
> >
> > So I guess the result of all that long-winded reply is that for on
> > rk3288-veyron-jerry:
> >
> > Fixes: ca8971ca5753 ("mmc: dw_mmc: Prevent runtime PM suspend when
> > SDIO IRQs are enabled")
> > Tested-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>
> Thanks a lot for testing and for your detailed feedback. I have
> amended the patch by adding your tags above.

Sure!  I'm going to try to do some detailed testing on the next patch
too to confirm it's OK, but I have a few other tasks to get to first.
;-)


> Moreover, we seems to need this for stable as well, but I am leaving
> that to be managed as a separate task. We may even consider the hole
> series for stable, but that requires more testing first.

Sure, makes sense.  We'll pick it to the Chrome OS 4.19 kernel
directly but it's usually nice to get fixes like this into stable so
everyone can benefit.


> > One last note is that, though Marvell WiFi works after a reset after
> > this commit, Marvell Bluetooth (on the same SDIO module) doesn't.  I
> > guess next week it'll be another bisect...
>
> Is the Bluetooth connected to the same SDIO interface, thus the
> Bluetooth driver is an SDIO func driver?

Yes, it's a SDIO func driver connected to the same interface.  So far
I've managed to confirm the problem on:

v4.4 (plus 76ae3e26ea43 mwifiex: add debugfs file for testing reset of card)
v4.9
next-20190708

...so it seems like it's not a "regression", it's just never worked.
:-P  I guess I'll have to see if I can figure out what's different in
our chromeos-3.14 kernel.  Ah, I see.  In 3.14 we had this solution:

pr_err("Resetting card...\n");
mmc_remove_host(reset_host);
/* 200ms delay is based on experiment with sdhci controller */
mdelay(200);
reset_host->rescan_entered = 0;
mmc_add_host(reset_host);

...I think that didn't fly upstream.  ...but I can confirm that this works fine:

cd /sys/bus/platform/drivers/dwmmc_rockchip
echo ff0d0000.dwmmc > unbind
sleep .5
echo ff0d0000.dwmmc > bind

...so I guess this boils down to: how does the mwifiex reset code not
behave like a full removal and re-insertion of the card?  Oh, but
maybe that's obvious.  We're doing all the reset / re-init from the
WiFi side of things (mwifiex_sdio_card_reset_work) but I don't think
anything is communicated to the Bluetooth side of things.  Presumably
this is just totally broken for everyone?  ...or am I confused?


-Doug


-Doug
