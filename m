From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 5/7] mmc: meson-gx: avoid clock glitch when switching to
 DDR modes
Date: Thu, 18 Apr 2019 22:46:05 +0200
Message-ID: <8316d7875bf0479e91cc11ce5fbf3b2e21f92a2c.camel@baylibre.com>
References: <20190417204355.469-1-jbrunet@baylibre.com>
         <20190417204355.469-6-jbrunet@baylibre.com>
         <CAFBinCCAbMpWYY6-W+909Q=jLpweC2F6ED6CVf6zVGrRiA1hxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFBinCCAbMpWYY6-W+909Q=jLpweC2F6ED6CVf6zVGrRiA1hxg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, 2019-04-18 at 22:16 +0200, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Wed, Apr 17, 2019 at 10:44 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > Activating DDR in the Amlogic mmc controller, among other things, will
> > divide the output clock by 2. So by activating it with clock on, we are
> > creating a glitch on the output.
> > 
> > Instead, let's deal with DDR when the clock output is off, when setting
> > the clock.
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> it seems that this patch breaks SD card on my Khadas VIM and Khadas VIM2.

The error I see in your logs is with eMMC and hs200, not SD card.

Either way, There is something I don't really get. eMMC should not go through
any DDR mode to reach HS200 (which is an SDR mode), neither should SD to reach
HS.

All this does is flipping the DDR bit (when necessary) when clock if off for
the mmc device, avoiding a glitch on clk line. 

This patch should not make any difference for SDR only setup, Maybe I missed
something, but I don't see how it could make anything different for SDR only.

I (repeatedly) tested both vim1 and vim2, without seeing this issue, so I can't
debug this. I'll need more detail to progress, something does not make sense here.

> I used git bisect within this series to find that issue.
> applying your .dts patches on top doesn't fix it
> 
> two boot logs attached:
> * kvim-broken.txt has patches 1-5 (= including this patch) applied
> * kvim-working.txt has only patches 1-4 (= excluding this patch) applied
> 
> 
> Regards
> Martin
