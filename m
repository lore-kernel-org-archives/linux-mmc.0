From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] RFC: mmc: core: Increase delay for voltage to stabilize
 from 3.3V to 1.8V
Date: Fri, 15 May 2015 10:34:42 -0700
Message-ID: <CAD=FV=V6HtTVFo=0NSf8i8_aaKmcwJf_KsAT4c8Gy5aAB9r1Vw@mail.gmail.com>
References: <1431467171-12937-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431467171-12937-1-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Doug Anderson <dianders@chromium.org>, Johan Rudholm <johan.rudholm@axis.com>, Adrian Hunter <adrian.hunter@intel.com>, Tim Kryger <tim.kryger@gmail.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Andrew Gabbasov <andrew_gabbasov@mentor.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, May 12, 2015 at 2:46 PM, Doug Anderson <dianders@chromium.org> wrote:
> Since the regulator used for the SDMMC IO voltage is not expected to
> draw a lot of current, most systems will probably use an inexpensive
> LDO for it.  LDO regulators apparently have the feature that they
> don't actively drive the voltage down--they wait for other components
> in the system to drag the voltage down.  Thus they will transition
> faster under heavy loads and slower under light loads.
>
> During an SDMMC voltage change from 3.3V to 1.8V, we are almost
> certainly under a light load.  To be specific:
> * The regulator is hooked through pulls to CMD0-3 and DAT.  Probably
>   the CMD pulls are something like 47K and the DAT is something like
>   10K.
> * The card is supposed to be driving DAT0-3 low during voltage change
>   which will draw _some_ current, but not a lot.
> * The regulator is also provided to the SDMMC host controller, but the
>   SDMMC host controller is in open drain mode during the voltage
>   change and so shouldn't be drawing much current.
>
> In order to keep the SDMMC host working properly (or for noise
> reasons), there might also be a capacitor attached to the SDMMC IO
> regulator.  This also will have the effect of slowing down transitions
> of the regulator, especially under light loads.
>
> From experimental evidence, we've seen the voltage change fail if the
> card doesn't detect that the voltage fell to less than about 2.3V when
> we turn on the clock.  On one device (that admittedly had a 47K CMD
> pullup instead of a 10K CMD pullup) we saw that the voltage was just
> about 2.3V after 5ms and thus the voltage change would sometimes fail.
> Doubling the delay gave margin and made the voltage change work 100%
> of the time, despite the slightly weaker CMD pull.
>
> At the moment submitting this as an RFC patch since my problem _could_
> be fixed by increasing the pull strength (or using a smaller
> capacitor).  However being a little bit more lenient to strange
> hardware could also be a good thing.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/mmc/core/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

One other note is that I'm now seeing this even on a device that has
the proper external pulls.  Maybe external capacitor is too big, but
it's too late to change that now.  I didn't see it before on that
device because we (accidentally) also had the internal pulls turned on
which were draining voltage faster.  I could try adding the internal
pulls back in, but that somehow seems worse than this.  One other
benefit of adding a little bit longer delay is that when we start
tuning it's more likely that we'll be tuning at a more stable voltage,
even if we don't actually get an error.

I'm planning to apply this locally, but still up to you of course
whether you want to take it upstream.  :)

-Doug
