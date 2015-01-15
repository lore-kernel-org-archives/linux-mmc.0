From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFC 0/3] mmc: Add dynamic frequency scaling
Date: Thu, 15 Jan 2015 10:20:26 +0100
Message-ID: <1421313626.19448.8.camel@AMDC1943>
References: <1421054585-9032-1-git-send-email-k.kozlowski@samsung.com>
 <CAPDyKFpGiaDJ3zjCSSbcia6iLS2+FLBRjGAheQAzvFsAkJax+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAPDyKFpGiaDJ3zjCSSbcia6iLS2+FLBRjGAheQAzvFsAkJax+A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On czw, 2015-01-15 at 09:20 +0100, Ulf Hansson wrote:
> + Mike, Stephen (Clock maintainers)
> 
> On 12 January 2015 at 10:23, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
> > Hi,
> >
> >
> > I would like to hear some comments about idea of scaling MMC clock
> > frequency. The basic idea is to lower the clock when device is
> > completely idle or not busy enough.
> 
> We already have host drivers that implements runtime PM support.
> Typically that would mean the clock will be gated once the device
> becomes runtime PM suspended.
> 
> Why should we decrease the frequency of an already gated clock?

In case of idle state you're right that clkgate would be better. But
what about finding a compromise between high performance (high
frequency) and energy saving for different loads on MMC?

The frequency scaling could help in that case. Anyway I should prepare
some more benchmarks for such conditions.

Best regards,
Krzysztof

> I think this boils done to how DVFS transitions can be triggered from
> the clock drivers, right?
> 
> Currently the clock framework supports this through clock rate change
> notifiers. Should we have clock notifiers for clk_prepare|unprepare()
> as well? I do remember that someone posted patches for that a while
> ago, but those were rejected.
> 
> Mike, Stephen - comments?
> 
> Kind regards
> Uffe
> 
> >
> > The patchset adds MMC card as a devfreq device and uses simple_ondemand
> > as governor. In idle this gave benefits (less energy consumed during
> > idle):
> > 1. Trats2 (Exynos4412): 2.6%
> > 2. Rinato (Exynos3250): 1%
> >
> > but (especially on Rinato) it had impact on performance (probably
> > because ondemand triggering a little to late). What is interesting
> > manually changing the clock (without this patchset) gave slightly
> > bigger benefits. Maybe the devfreq introduces noticeable overhead?
> >
> >
> > Comments are welcomed. Maybe on other platforms this has bigger impact?
> >
> > Best regards,
> > Krzysztof
> >
> >
> > Krzysztof Kozlowski (3):
> >   mmc: Add dynamic frequency scaling
> >   ARM: dts: Specify MSHC realistic clocks and use frequency scaling
> >   ARM: dts: Use frequency scaling for MSHC
> >
> >  Documentation/devicetree/bindings/mmc/mmc.txt |   2 +
> >  arch/arm/boot/dts/exynos3250-rinato.dts       |   1 +
> >  arch/arm/boot/dts/exynos4412-trats2.dts       |   4 +-
> >  drivers/mmc/card/block.c                      | 247 ++++++++++++++++++++++++++
> >  drivers/mmc/core/Kconfig                      |  16 ++
> >  drivers/mmc/core/core.h                       |   1 -
> >  drivers/mmc/core/host.c                       |   2 +
> >  include/linux/mmc/card.h                      |   8 +
> >  include/linux/mmc/host.h                      |   3 +
> >  9 files changed, 282 insertions(+), 2 deletions(-)
> >
> > --
> > 1.9.1
> >
