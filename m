From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 5/7] mmc: meson-gx: avoid clock glitch when switching to
 DDR modes
Date: Sat, 20 Apr 2019 11:23:51 +0200
Message-ID: <CAFBinCBtc=Yb3WDgLzgnyd=NauaZnkQRnc08_j-XbiDybh=7cg@mail.gmail.com>
References: <20190417204355.469-1-jbrunet@baylibre.com> <20190417204355.469-6-jbrunet@baylibre.com>
 <CAFBinCCAbMpWYY6-W+909Q=jLpweC2F6ED6CVf6zVGrRiA1hxg@mail.gmail.com>
 <8316d7875bf0479e91cc11ce5fbf3b2e21f92a2c.camel@baylibre.com>
 <CAFBinCBQPSsqwDSd6nQMLqOuApiESwHXn4wQbOp49WLpXfBk=Q@mail.gmail.com>
 <5b19d32be23fbe630339fd48f93b16e9301385d1.camel@baylibre.com> <5d65cc12e18f9a4b86c097fbade0cef91b3b5d9b.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5d65cc12e18f9a4b86c097fbade0cef91b3b5d9b.camel@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Jerome,

On Fri, Apr 19, 2019 at 10:53 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Thu, 2019-04-18 at 23:15 +0200, Jerome Brunet wrote:
> > On Thu, 2019-04-18 at 22:53 +0200, Martin Blumenstingl wrote:
> > > Hi Jerome,
> > >
> > > On Thu, Apr 18, 2019 at 10:46 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > > On Thu, 2019-04-18 at 22:16 +0200, Martin Blumenstingl wrote:
> > > > > Hi Jerome,
> > > > >
> > > > > On Wed, Apr 17, 2019 at 10:44 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > > > > Activating DDR in the Amlogic mmc controller, among other things, will
> > > > > > divide the output clock by 2. So by activating it with clock on, we are
> > > > > > creating a glitch on the output.
> > > > > >
> > > > > > Instead, let's deal with DDR when the clock output is off, when setting
> > > > > > the clock.
> > > > > >
> > > > > > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > > > > it seems that this patch breaks SD card on my Khadas VIM and Khadas VIM2.
> > > >
> > > > The error I see in your logs is with eMMC and hs200, not SD card.
> > > sorry, I should have been more clear that there are two errors:
> > > eMMC, this is what I have been seeing for a while on my Khadas VIM2
> > > (it's probably not related to this patch):
> > >    mmc1: mmc_select_hs200 failed, error -84
> > >    mmc1: error -84 whilst initialising MMC card
> >
> > Following patches were also supposed to help the vim2.
> > ... something I tested numerous time on this particular board.
> >
> > > however, then there's this other error:
> > >    print_req_error: I/O error, dev mmcblk0, sector 0 flags 0
> > >    Buffer I/O error on dev mmcblk0, logical block 0, async page read
> > > as result of this the partition table cannot be read and my kernel
> > > cannot find the rootfs.
> >
> > I don't know what the problem is (probably some CRC error - you can check the log
> > in interrupt for this) but I'm pretty sure it is not related to this patch.
> >
> > I see in the log SD is indeed in HS mode, so not in any DDR mode.
> > I also see that the SDIO fails as well. There something really weird, which can't
> > be explained by this patch alone AFAICT.
>
> Ok, I think I got it. It is indeed not linked to DDR, but a more trivial mistake.
> It looks like a writel went AWOL during the final rebase (and after the test campaign).
>
> in meson_mmc_set_ios, after:
> val |= FIELD_PREP(CFG_BUS_WIDTH_MASK, bus_width);
>
> Could you try adding
> writel(val, host->regs + SD_EMMC_CFG);
good catch!

> Without this, the bus width is not changed, which explains why eMMC, SD and SDIO fail
> on init.
I have added that missing writel on top of the whole series and now:
- SD card is detected again (same as without this series)
- SDIO wifi is detected again (same as without this series)
- eMMC is detected (was not working before)

I will give my Tested-by on v2 of these patches


Martin
