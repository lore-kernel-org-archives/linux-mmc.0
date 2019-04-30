From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 4/7] mmc: meson-gx: disable HS400
Date: Tue, 30 Apr 2019 22:02:27 +0200
Message-ID: <CAFBinCBpujeLJHr0x9DxqLtRiLt0WLkkOoKcJuh3baWeg_bFeA@mail.gmail.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com> <20190423090235.17244-5-jbrunet@baylibre.com>
 <CAFBinCCf8fkBPR5aoPMensjhYKpan_UzG+HCEB5yNaYs+mB8OA@mail.gmail.com>
 <17c5978419c8778eb1f2c2a6e2aee66e864ac53d.camel@baylibre.com>
 <CAFBinCCus5T7LvH7aTMYmc5gKoFkZFR-MCMGK8bSV_eAsu9Svw@mail.gmail.com> <936229765eac2bcdacf9a53925bb17c38ea18e3a.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <936229765eac2bcdacf9a53925bb17c38ea18e3a.camel@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Jerome,

On Mon, Apr 29, 2019 at 8:50 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Mon, 2019-04-29 at 20:31 +0200, Martin Blumenstingl wrote:
> > Hi Jerome,
> >
> > On Mon, Apr 29, 2019 at 10:29 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > On Sat, 2019-04-27 at 22:02 +0200, Martin Blumenstingl wrote:
> > > > Hi Jerome,
> > > >
> > > > On Tue, Apr 23, 2019 at 11:03 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > > > At the moment, all our attempts to enable HS400 on Amlogic chipsets have
> > > > > been unsuccessful or unreliable. Until we can figure out how to enable this
> > > > > mode safely and reliably, let's force it off.
> > > > last year I have seen issues with HS400 on my Khadas VIM2: [0]
> > > > have you tested all other patches from this series and HS400 is still
> > > > not working for you?
> > >
> > > Because HS400 was never really stable to begin with.
> > > It was a mistake to enable it on the VIM2
> > >
> > > > I'm curious because this patch is early in the series and all the
> > > > tuning fixes and improvements are after this patch.
> > >
> > > There are several reasons why this new tuning won't solve the HS400 problem:
> > > - Signal resampling tuning granularity gets worse when rate rises. The resampling
> > > is done using the input frequency. We can basically resample up to the value of
> > > internal divider.
> > >
> > > In HS200 - Fin is 1GHz, Fout is 200MHz (1/5) so the resample range is [0, 4]
> > > In HS400 - Fin should be fdiv5 (400MHZ) and in such case, no resampling is
> > >            possible (internal div = 1)
> > >            Even if we keep 1GHz, then out is 333MHz max giving a range of [0, 2]
> > >            that's not enough to tune
> > this limitation would be great to have in the description of patch 7
> > from this series
>
> That's not really a limitation. I should probably not have mentioned as it it seems to
> have made things even more unclear. I disabled HS400 before introducing the new tuning on
> purpose. Any comment regarding hs400 does not belong in patch 7 IHMO. If you want
> to add comment regarding hs400, I think it belongs here
>
> >
> > > Going further, tuning the Rx path does not make much sense in HS400 since we
> > > should be using the data strobe signal to account for the round trip delay of
> > > the clock and correctly sample Rx. AFAICT, If there is a tuning to be done for
> > > HS400, it is most likely linked to the data strobe.
> > it would be great to have a better description as part of the commit
> > message - with that you can add my:
> > Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >
> > my proposal for an update patch description (apologies I have
> > incorrectly summarized your findings):
> > "
> > At the moment, all our attempts to enable HS400 on Amlogic chipsets have
> > been unsuccessful or unreliable:
> > - signal resampling without delay adjustments and phase tuning for the
> > RX and TX clocks (this caused CRC errors and hangs even without HS400
> > mode, for example on the Khadas VIM, Khadas VIM2 and libretech-cc
> > boards)
> > - signal resampling without delay adjustments and RX clock phase
> > tuning (some HS200 and HS400 eMMC chips were not recognized, for
> > example on the Khadas VIM and Khadas VIM2 boards)
> > - signal resampling tuning with delay adjustments only (works fine for
> > HS200 and UHS modes but doesn't fix HS400 eMMC chips, for example on
> > Khadas VIM2)
> >
> > Further improvements for the HS400 mode are likely to be linked to the
> > data strobe signal.
> > Until we can figure out how to enable this mode safely and reliably,
> > let's force it off.
> > "
>
> Thanks for effort but all this just maintain the blur around HS400 on amlogic.
>
> Let me rephrase it:
> Tuning (phase or resampling) is meant to compensate the clock round trip in UHS
> and HS200 modes. In HS400, this should be taken care of by the data strobe.
> But we have not been to enable this reliably enable this on amlogic chipset ...
I wasn't aware of this: so far I assumed that we're not setting the
phase correctly, end of the story.
thank you again for taking your time to explain this!

> ... and I believe we are back to the original commit message.
no need to update the description just to explain how HS400 works in
general, so feel free to use my:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Martin
